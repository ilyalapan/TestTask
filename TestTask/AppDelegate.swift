//
//  AppDelegate.swift
//  TestTask
//
//  Created by Ilya Lapan on 14/12/2016.
//  Copyright © 2016 ilyalapan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        return true
    }

    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if let navController = window?.rootViewController as? UINavigationController {
            for viewController in navController.childViewControllers {
                if let productListController = viewController as? ProductListTableViewController {
                    let previousPosts = productListController.manager.products[0]
                    productListController.manager.load(){_ in
                        
                        var new = productListController.manager.products[0].filter({ p1 in
                            previousPosts.contains(where: { p2 in
                                p1.id == p2.id
                            })
                        })
                        
                        var localNotification = UILocalNotification()
                        if new.count == 0 {
                            completionHandler(UIBackgroundFetchResult.noData)
                        }
                        else if new.count == 1{
                            localNotification.fireDate = NSDate.init(timeIntervalSinceNow: 1) as Date
                            localNotification.alertBody = new[0].name + ": new product!"
                        } else {
                            localNotification.fireDate = NSDate.init(timeIntervalSinceNow: 1) as Date
                            localNotification.alertBody = String(new.count) + "new products"
                        }
                        productListController.tableView.reloadData()
                        completionHandler(UIBackgroundFetchResult.newData)

                    }
                }
            }
        }
    
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
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
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

