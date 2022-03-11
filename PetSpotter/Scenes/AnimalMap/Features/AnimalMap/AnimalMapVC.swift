//
//  AnimalMapVC.swift
//  PetFinder
//
//  Created by hkarkin on 29.01.2022.
//

import UIKit
import MapKit

class AnimalMapVC: ViewController<AnimalMapVM> {
    
    //MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Properties
    var animals: [Animal] = [Animal]()
    
    // MARK: - VM Binders
    var getAnimalsByLocationClosure: ((CLLocationCoordinate2D) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func makeUI() {
        super.makeUI()
        title = "Map"
        configureMap()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        let animalClosure: (([Animal]) -> Void)? = { [weak self] (result) in
            DispatchQueue.main.async {
                self?.animals = result
            }
        }
        
        let input = AnimalMapVM.Input(animals: animalClosure)
        
        viewModel.transform(input: input){ (output) in
            self.getAnimalsByLocationClosure = output.getAnimalsByLocation
        }
    }
}

// MARK: - Configuration

extension AnimalMapVC {
    
    func configureMap() {
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        if let coor = mapView.userLocation.location?.coordinate{
            mapView.setCenter(coor, animated: true)
        }
    }
}

// MARK: - Storyboarded
extension AnimalMapVC: Storyboarded {
    static var storyboardName = StoryboardName.animalMap
}

// MARK: - MKMapViewDelegate

extension AnimalMapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        return nil
    }
}

// MARK: - MKMapViewDelegate

extension AnimalMapVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coor: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        mapView.setCenter(coor, animated: true)
        getAnimalsByLocationClosure?(coor)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let authorizationStatus: CLAuthorizationStatus = {
            if #available(iOS 14, *) {
                return manager.authorizationStatus
            }
            return CLLocationManager.authorizationStatus()
        }()
        
        switch authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
            break
        default:
            break
        }
    }
}
