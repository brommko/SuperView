//
//  DemoSuperViewController.swift
//  Example
//
//  Created by Brommko LLC on 20/12/2018.
//  Copyright © 2018 Brommko LLC. All rights reserved.
//

import UIKit
import SuperView
import Former

class DemoSuperViewController: FormViewController {

    // Create Headers
    let createHeader: ((String) -> ViewFormer) = { text in
        return LabelViewFormer<FormLabelHeaderView>()
            .configure {
                $0.text = text
                $0.viewHeight = 40
        }
    }

    let createSelectorRow = { (
        text: String,
        subText: String,
        onSelected: ((RowFormer) -> Void)?
        ) -> RowFormer in
        return LabelRowFormer<FormLabelCell>() {
            $0.titleLabel.font = .boldSystemFont(ofSize: 16)
            $0.subTextLabel.font = .boldSystemFont(ofSize: 14)
            $0.accessoryType = .disclosureIndicator
            $0.selectionStyle = .none
            }.configure { form in
                _ = onSelected.map {
                    form.onSelected($0)
                }
                form.text = text
                form.subText = subText
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configure()
    }

    private func configure() {
        self.title = "Super View"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Go", style: .plain, target: self, action: #selector(goAction))

        self.tableView.contentInset.top = 10
        self.tableView.contentInset.bottom = 30
        self.tableView.contentOffset.y = -10

        // Create RowFomers
        let url = TextFieldRowFormer<FormTextFieldCell>() {
            $0.textField.font = .systemFont(ofSize: 15)
            $0.textField.keyboardType = .webSearch
            $0.selectionStyle = .none
            }.configure {
                $0.placeholder = "http://example.com"
                $0.text = SuperView.shared.options.webView.url
            }.onTextChanged { (text) in
                SuperView.shared.options.webView.url = text
        }

        let purchaseCode = TextFieldRowFormer<FormTextFieldCell>() {
            $0.textField.font = .systemFont(ofSize: 15)
            $0.textField.keyboardType = .webSearch
            $0.selectionStyle = .none
            }.configure {
                $0.placeholder = "Your purchase code"
                $0.text = SuperView.shared.options.purchaseCode
            }.onTextChanged { (text) in
                SuperView.shared.options.purchaseCode = text
        }

        let sideMenuController = ButtonsViewContoller()
        sideMenuController.tuples = SuperView.shared.options.sideMenu.items?.map({ ($0.title!, $0.url!) }) ?? []
        sideMenuController.onSave = { tuples in
            do {
                SuperView.shared.options.sideMenu.items = try tuples.map({ try MenuCustomButton(title: $0.name, url: $0.url) })
            } catch {
                print("Error with menu items")
            }
        }


        let activityIndicatorRow = self.createSelectorRow("Activity indicator", "", self.pushSelectorRowSelected(controller: ActivityIndicatorConfigurationViewController()))
        let adMobPushRow = self.createSelectorRow("AdMob", "", self.pushSelectorRowSelected(controller: AdMobConfigurationViewController()))
        let facebookRow = self.createSelectorRow("Facebook", "", self.pushSelectorRowSelected(controller: FacebookConfigurationViewController()))
        let fontPushRow = self.createSelectorRow("Custom Font", "", self.pushSelectorRowSelected(controller: CustomFontConfigurationViewController()))
        let gpsRow = self.createSelectorRow("GPS", "", self.pushSelectorRowSelected(controller: GPSConfigurationViewController()))
        let inAppPurchaseRow = self.createSelectorRow("In-App purchase", "", self.pushSelectorRowSelected(controller: InAppPurchaseConfigurationViewController()))
        let navigationBarPushRow = self.createSelectorRow("Navigation Bar", "", self.pushSelectorRowSelected(controller: NavigationBarConfigurationViewController()))
        let oneSignalPushRow = self.createSelectorRow("One Signal", "", self.pushSelectorRowSelected(controller: OneSignalConfigurationViewController()))
        let rateMyAppPushRow = self.createSelectorRow("Rate my app", "", self.pushSelectorRowSelected(controller: RateMyAppConfigurationViewController()))
        let sideMenuRow = self.createSelectorRow("Side Menu", "\(SuperView.shared.options.sideMenu.items?.count ?? 0)", self.pushSelectorRowSelected(controller: sideMenuController))
        let toolbarPushRow = self.createSelectorRow("Toolbar", "", self.pushSelectorRowSelected(controller: ToolbarConfigurationViewController()))
        let webViewPushRow = self.createSelectorRow("WebView", "", self.pushSelectorRowSelected(controller: WebViewConfigurationViewController()))

        // Create SectionFormers
        let urlSection = SectionFormer(rowFormer: url).set(headerViewFormer: self.createHeader("URL"))
        let licenseSection = SectionFormer(rowFormer: purchaseCode).set(headerViewFormer: self.createHeader("License"))

        let configurationSection = SectionFormer(rowFormer:
            activityIndicatorRow,
                                                 adMobPushRow,
                                                 facebookRow,
                                                 fontPushRow,
                                                 gpsRow,
                                                 inAppPurchaseRow,
                                                 navigationBarPushRow,
                                                 oneSignalPushRow,
                                                 rateMyAppPushRow,
                                                 sideMenuRow,
                                                 toolbarPushRow,
                                                 webViewPushRow).set(headerViewFormer: self.createHeader("Configuration"))

        self.former.removeAll().append(sectionFormer: urlSection, licenseSection, configurationSection).reload()
    }

    @objc func goAction() {
        SuperView.show()
    }

    private func pushSelectorRowSelected(controller: FormViewController) -> (RowFormer) -> Void {
        return { [weak self] rowFormer in
            if rowFormer is LabelRowFormer<FormLabelCell> {
                self?.navigationController?.pushViewController(controller, animated: true)
            }
        }
    }

}
