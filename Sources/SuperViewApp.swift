//
//  SuperViewApp.swift
//  SuperView
//
//  Migrated to SwiftUI
//

import SwiftUI
import SuperViewCore

#if canImport(SuperViewAdMob)
import SuperViewAdMob
#endif

#if canImport(SuperViewCardScan)
import SuperViewCardScan
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

@main
struct SuperViewApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .ignoresSafeArea()
        }
    }
}

final class AppDelegate: NSObject, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {

        SuperView.configure(application: application, launchOptions: launchOptions)

        #if canImport(SuperViewAdMob)
        SuperView.configureAdMob()
        #endif

        #if canImport(SuperViewCardScan)
        SuperView.configureCardScan()
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

    func application(
        _ application: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        return SuperView.handleURL(url: url, options: options)
    }

    func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
              let url = userActivity.webpageURL else {
            return false
        }
        application.open(url)
        return true
    }

    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        #if canImport(SuperViewOneSignal)
        // OneSignal handles this automatically
        #endif
    }

    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        print("SuperView | Failed to register for remote notifications: \(error)")
    }
}
