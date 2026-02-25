//
//  ContentView.swift
//  SuperView
//
//  SwiftUI wrapper for SuperWebViewController
//

import SwiftUI
import SuperViewCore

struct ContentView: View {
    var body: some View {
        SuperWebViewControllerRepresentable()
            .ignoresSafeArea()
    }
}

struct SuperWebViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = SuperWebViewController

    func makeUIViewController(context: Context) -> SuperWebViewController {
        let viewController = SuperWebViewController()
        return viewController
    }

    func updateUIViewController(_ uiViewController: SuperWebViewController, context: Context) {
        // No updates needed - the view controller manages its own state
    }
}

#Preview {
    ContentView()
}
