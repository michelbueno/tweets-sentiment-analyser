//
//  AppDelegate.swift
//  TweetSentimentAnalyser
//
//  Created by Michel Bueno on 17/08/20.
//  Copyright © 2020 Michel Bueno. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.backgroundColor = .white
        window?.rootViewController = HomeRouter().createModule()
        window?.makeKeyAndVisible()
           
       return true
   }

}

