//
//  AppDelegate.swift
//  PostcardControllerDemo
//
//  Created by EamonLiang on 2019/9/4.
//  Copyright © 2019 EamonLiang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController()
        window?.makeKey()
        window?.makeKeyAndVisible()
        return true
    }
}

