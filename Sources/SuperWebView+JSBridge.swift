//
//  AppDelegate.swift
//  App
//
//  Created by Brommko LLC on 11/12/2021.
//

import UIKit
import Foundation
import SuperViewCore

extension SuperView {
    public static func configureCustomBridge() {
        MethodSwizzler.swizzleMethods(cls: SuperWebView.self,
                                      originalSelector: #selector(SuperWebView.setupCustomBridge),
                                      overrideSelector: #selector(SuperWebView.override_setupCustomBridge))
    }
}

extension SuperWebView {
    @objc func override_setupCustomBridge() {
        self.override_setupCustomBridge()

        self.bridge.register({ (_, completion) in
            let id = UIDevice.current.identifierForVendor?.uuidString ?? ""
            print("SuperView | Device ID: \(id)")
            completion(.success(["id": id]))
        }, for: "deviceid")
    }
}
