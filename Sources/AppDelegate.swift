//
//  AppDelegate.swift
//  Example
//
//  Created by Brommko LLC on 09/10/2018.
//

import UIKit
import SuperView

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        SuperView.configure(application: application, launchOptions: launchOptions)

        return true
    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return SuperView.handleURL(url: url, options: options)
    }
}

