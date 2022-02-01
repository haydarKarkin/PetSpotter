//
//  AppDelegate.swift
//  PetFinder
//
//  Created by hkarkin on 30.11.2021.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let dataController = DataController(modelName: "PetFinder")
    private var appCoordinator: AppCoordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().barTintColor = UIColor(named: "PrimaryWhite")
        UINavigationBar.appearance().tintColor = UIColor(named: "PrimaryWhite")
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(named: "PrimaryRed")!]
        
        window = UIWindow(frame: UIScreen.main.bounds)
        dataController.load()
        
        let navigationController = UINavigationController()
        appCoordinator = AppCoordinator(navigationController: navigationController,
                                        sharedFactory: SharedFactory())
        appCoordinator.start()
        
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
        
        return true
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PetFinder")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
