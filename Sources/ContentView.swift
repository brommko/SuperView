//
//  ContentView.swift
//  SuperView
//
//  SwiftUI wrapper for SuperWebViewController with JS Bridge support
//

import SwiftUI
import WebKit
import SuperViewCore

struct ContentView: View {
    var body: some View {
        SuperWebViewControllerRepresentable()
            .ignoresSafeArea()
    }
}

struct SuperWebViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = SuperWebViewController

    func makeCoordinator() -> JSBridgeCoordinator {
        JSBridgeCoordinator()
    }

    func makeUIViewController(context: Context) -> SuperWebViewController {
        let viewController = SuperWebViewController()

        // Schedule JS bridge setup after the view controller loads
        DispatchQueue.main.async {
            context.coordinator.setupJSBridge(for: viewController)
        }

        return viewController
    }

    func updateUIViewController(_ uiViewController: SuperWebViewController, context: Context) {
        // No updates needed - the view controller manages its own state
    }
}

// MARK: - JavaScript Bridge Coordinator

final class JSBridgeCoordinator: NSObject, WKScriptMessageHandler {

    private weak var webView: WKWebView?

    // MARK: - Bridge Setup

    func setupJSBridge(for viewController: SuperWebViewController) {
        // Find the WKWebView in the view hierarchy
        guard let webView = findWebView(in: viewController.view) else {
            // Retry after a short delay if view hierarchy isn't ready
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self, weak viewController] in
                guard let self = self, let vc = viewController else { return }
                self.setupJSBridge(for: vc)
            }
            return
        }

        self.webView = webView

        // Register message handlers
        let contentController = webView.configuration.userContentController
        contentController.add(self, name: "deviceid")
        contentController.add(self, name: "customBridge")

        // Inject JavaScript bridge interface
        let bridgeScript = WKUserScript(
            source: jsBridgeCode,
            injectionTime: .atDocumentStart,
            forMainFrameOnly: false
        )
        contentController.addUserScript(bridgeScript)
    }

    // MARK: - WKScriptMessageHandler

    func userContentController(
        _ userContentController: WKUserContentController,
        didReceive message: WKScriptMessage
    ) {
        switch message.name {
        case "deviceid":
            handleDeviceIdRequest(message: message)
        case "customBridge":
            handleCustomBridgeMessage(message: message)
        default:
            break
        }
    }

    // MARK: - Message Handlers

    private func handleDeviceIdRequest(message: WKScriptMessage) {
        let deviceId = UIDevice.current.identifierForVendor?.uuidString ?? "unknown"

        // Get callback ID if provided
        if let body = message.body as? [String: Any],
           let callbackId = body["callbackId"] as? String {
            let js = "window.SuperViewBridge._callbacks['\(callbackId)']('\(deviceId)')"
            webView?.evaluateJavaScript(js, completionHandler: nil)
        }
    }

    private func handleCustomBridgeMessage(message: WKScriptMessage) {
        guard let body = message.body as? [String: Any],
              let action = body["action"] as? String else {
            return
        }

        let callbackId = body["callbackId"] as? String
        var response: String = ""

        switch action {
        case "getDeviceId":
            response = UIDevice.current.identifierForVendor?.uuidString ?? "unknown"
        case "getDeviceName":
            response = UIDevice.current.name
        case "getSystemVersion":
            response = UIDevice.current.systemVersion
        case "getAppVersion":
            response = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "unknown"
        case "getBuildNumber":
            response = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "unknown"
        default:
            response = "unknown_action"
        }

        if let callbackId = callbackId {
            let escapedResponse = response.replacingOccurrences(of: "'", with: "\\'")
            let js = "window.SuperViewBridge._callbacks['\(callbackId)']('\(escapedResponse)')"
            webView?.evaluateJavaScript(js, completionHandler: nil)
        }
    }

    // MARK: - Helper Methods

    private func findWebView(in view: UIView) -> WKWebView? {
        if let webView = view as? WKWebView {
            return webView
        }
        for subview in view.subviews {
            if let webView = findWebView(in: subview) {
                return webView
            }
        }
        return nil
    }

    // MARK: - JavaScript Bridge Code

    private var jsBridgeCode: String {
        """
        (function() {
            if (window.SuperViewBridge) return;

            window.SuperViewBridge = {
                _callbacks: {},
                _callbackId: 0,

                _generateCallbackId: function() {
                    return 'cb_' + (++this._callbackId) + '_' + Date.now();
                },

                getDeviceId: function(callback) {
                    var callbackId = this._generateCallbackId();
                    this._callbacks[callbackId] = function(result) {
                        delete window.SuperViewBridge._callbacks[callbackId];
                        if (callback) callback(result);
                    };
                    window.webkit.messageHandlers.deviceid.postMessage({callbackId: callbackId});
                },

                call: function(action, callback) {
                    var callbackId = this._generateCallbackId();
                    this._callbacks[callbackId] = function(result) {
                        delete window.SuperViewBridge._callbacks[callbackId];
                        if (callback) callback(result);
                    };
                    window.webkit.messageHandlers.customBridge.postMessage({
                        action: action,
                        callbackId: callbackId
                    });
                },

                getDeviceName: function(callback) {
                    this.call('getDeviceName', callback);
                },

                getSystemVersion: function(callback) {
                    this.call('getSystemVersion', callback);
                },

                getAppVersion: function(callback) {
                    this.call('getAppVersion', callback);
                },

                getBuildNumber: function(callback) {
                    this.call('getBuildNumber', callback);
                }
            };

            // Legacy support - direct deviceid function
            window.deviceid = function(callback) {
                window.SuperViewBridge.getDeviceId(callback);
            };
        })();
        """
    }
}

#Preview {
    ContentView()
}
