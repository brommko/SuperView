//
//  AppDelegate.swift
//  App
//
//  Created by Brommko LLC on 09/10/2018.
//

import UIKit
import Foundation
import SuperViewCore

#if canImport(SuperViewAdMob)
import SuperViewAdMob
#endif

#if canImport(SuperViewCardScan)
import SuperViewCardScan
#endif

#if canImport(SuperViewFacebook)
import SuperViewFacebook
#endif

#if canImport(SuperViewOneSignal)
import SuperViewOneSignal
#endif

#if canImport(SuperViewLocation)
import SuperViewLocation
#endif

#if canImport(SuperViewQR)
import SuperViewQR
#endif

#if canImport(SuperViewFirebase)
import SuperViewFirebase
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        SuperView.configure(application: application, launchOptions: launchOptions)
        SuperView.configureCustomBridge()
        
        #if canImport(SuperViewAdMob)
        SuperView.configureAdMob()
        #endif

        #if canImport(SuperViewCardScan)
        SuperView.configureCardScan()
        #endif

        #if canImport(SuperViewFacebook)
        SuperView.configureFacebook()
        #endif

        #if canImport(SuperViewFirebase)
        SuperView.configureFirebase()
        #endif

        #if canImport(SuperViewLocation)
        SuperView.configureLocation()
        #endif

        #if canImport(SuperViewOneSignal)
        SuperView.configureOneSignal()
        #endif

        #if canImport(SuperViewQR)
        SuperView.configureQR()
        #endif
        
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return SuperView.handleURL(url: url, options: options)
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb, let url = userActivity.webpageURL else {
            return false
        }
        application.open(url)
        return true
    }
}
