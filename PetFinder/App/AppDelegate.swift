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
        
        // add styling for navigation bars
        UINavigationBar.appearance().barTintColor = UIColor(named: "PrimaryWhite")
        UINavigationBar.appearance().tintColor = UIColor(named: "PrimaryRed")
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(named: "PrimaryRed")!]
        
        // load database to get persistent data
        dataController.load()
        
        // send that into our coordinator so that it can display view controllers
        let navigationController = UINavigationController()
        appCoordinator = AppCoordinator(navigationController: navigationController,
                                        sharedFactory: SharedFactory())
        // tell the coordinator to take over control
        appCoordinator.start()
        
        // create a basic UIWindow and activate it
        window = UIWindow(frame: UIScreen.main.bounds)
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
