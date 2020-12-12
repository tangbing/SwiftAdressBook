//
//  AppDelegate.swift
//  Swift_通讯录
//
//  Created by Tb on 2020/11/7.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let tarBarVc = MainTabBarViewController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tarBarVc
        window?.makeKeyAndVisible()
        
        return true
    }



}

