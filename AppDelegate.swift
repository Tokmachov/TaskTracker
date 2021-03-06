//
//  AppDelegate.swift
//  TaskKiller
//
//  Created by Oleg Tokmachov on 07.11.2018.
//  Copyright © 2018 Oleg Tokmachov. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private lazy var tagFactory = TagFactoryImp()
    private lazy var taskFactory = TaskFactoryImp(tagFactory: tagFactory)
    private lazy var taskListModelFactory = TaskListModelFactoryImp()
    private lazy var taskProgressModelFactry = TaskProgressModelFactoryImp()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //MARK: NotificationCenter request authorization
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {(granted, error) in
                // handle result
        })
        guard let rootController = window?.rootViewController as? UITabBarController else { fatalError() }
        guard let taskListVC = ((rootController.viewControllers?[0] as? UINavigationController)?.viewControllers[0]) as? TaskListVC else { fatalError() }
        taskListVC.taskFactory = taskFactory
        taskListVC.taskListModelFactory = taskListModelFactory
        taskListVC.taskProgressModelFactory = taskProgressModelFactry
        return true
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is acodercan occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
            application.applicationIconBadgeNumber = 0
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        PersistanceService.saveContext()
    }
}

