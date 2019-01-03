//
//  WebConfigurationViewController.swift
//  Example
//
//  Created by Brommko LLC on 19/12/2018.
//  Copyright © 2018 Brommko LLC. All rights reserved.
//

import UIKit
import Former
import SuperView

class WebViewConfigurationViewController: FormViewController {

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
        self.tableView.contentInset.top = 10
        self.tableView.contentInset.bottom = 30
        self.tableView.contentOffset.y = -10

        // Create RowFomers
        let waitUntilLoaded = SwitchRowFormer<FormSwitchCell>() {
            $0.titleLabel.text = "Wait until loaded"
            $0.titleLabel.font = .boldSystemFont(ofSize: 15)
            }.configure {
                $0.switched = SuperView.shared.options.webView.waitUntilLoaded
            }.onSwitchChanged { on in
                SuperView.shared.options.webView.waitUntilLoaded = on
        }
        let allowPullToRefresh = SwitchRowFormer<FormSwitchCell>() {
            $0.titleLabel.text = "Allow pull to refresh"
            $0.titleLabel.font = .boldSystemFont(ofSize: 15)
            }.configure {
                $0.switched = SuperView.shared.options.webView.allowPullToRefresh
            }.onSwitchChanged { on in
                SuperView.shared.options.webView.allowPullToRefresh = on
        }
        let allowBounce = SwitchRowFormer<FormSwitchCell>() {
            $0.titleLabel.text = "Allow bounce"
            $0.titleLabel.font = .boldSystemFont(ofSize: 15)
            }.configure {
                $0.switched = SuperView.shared.options.webView.allowBounce
            }.onSwitchChanged { on in
                SuperView.shared.options.webView.allowBounce = on
        }
        let allowCache = SwitchRowFormer<FormSwitchCell>() {
            $0.titleLabel.text = "Allow cache"
            $0.titleLabel.font = .boldSystemFont(ofSize: 15)
            }.configure {
                $0.switched = SuperView.shared.options.webView.allowCache
            }.onSwitchChanged { on in
                SuperView.shared.options.webView.allowCache = on
        }
        let allowVideoPlayInline = SwitchRowFormer<FormSwitchCell>() {
            $0.titleLabel.text = "Allow video play inline"
            $0.titleLabel.font = .boldSystemFont(ofSize: 15)
            }.configure {
                $0.switched = SuperView.shared.options.webView.allowVideoPlayInline
            }.onSwitchChanged { on in
                SuperView.shared.options.webView.allowVideoPlayInline = on
        }
        let allowLinkPreview = SwitchRowFormer<FormSwitchCell>() {
            $0.titleLabel.text = "Allow link preview"
            $0.titleLabel.font = .boldSystemFont(ofSize: 15)
            }.configure {
                $0.switched = SuperView.shared.options.webView.allowLinkPreview
            }.onSwitchChanged { on in
                SuperView.shared.options.webView.allowLinkPreview = on
        }
        let allowBackForwardSwipe = SwitchRowFormer<FormSwitchCell>() {
            $0.titleLabel.text = "Allow back forward swipe"
            $0.titleLabel.font = .boldSystemFont(ofSize: 15)
            }.configure {
                $0.switched = SuperView.shared.options.webView.allowBackForwardSwipe
            }.onSwitchChanged { on in
                SuperView.shared.options.webView.allowBackForwardSwipe = on
        }
        let allowPictureInPicture = SwitchRowFormer<FormSwitchCell>() {
            $0.titleLabel.text = "Allow picture in picture"
            $0.titleLabel.font = .boldSystemFont(ofSize: 15)
            }.configure {
                $0.switched = SuperView.shared.options.webView.allowPictureInPicture
            }.onSwitchChanged { on in
                SuperView.shared.options.webView.allowPictureInPicture = on
        }

        let externalLinksController = StringsViewController()
        externalLinksController.strings = SuperView.shared.options.webView.externalLinks
        externalLinksController.onSave = { strings in
            SuperView.shared.options.webView.externalLinks = strings
        }
        let externalLinksRow = self.createSelectorRow("External links", "\(SuperView.shared.options.webView.externalLinks.count)", self.pushSelectorRowSelected(controller: externalLinksController))

        let customURLSchemesController = StringsViewController()
        customURLSchemesController.strings = SuperView.shared.options.webView.customURLSchemes
        customURLSchemesController.onSave = { strings in
            SuperView.shared.options.webView.customURLSchemes = strings
        }
        let customURLSchemesControllerRow = self.createSelectorRow("Custom URL schemes", "\(SuperView.shared.options.webView.customURLSchemes.count)", self.pushSelectorRowSelected(controller: customURLSchemesController))


        // Create Headers
        let createHeader: ((String) -> ViewFormer) = { text in
            return LabelViewFormer<FormLabelHeaderView>()
                .configure {
                    $0.text = text
                    $0.viewHeight = 40
            }
        }

        // Create SectionFormers
        let webViewSection = SectionFormer(rowFormer: waitUntilLoaded,
                                           allowPullToRefresh,
                                           allowBounce,
                                           allowCache,
                                           allowVideoPlayInline,
                                           allowLinkPreview,
                                           allowBackForwardSwipe,
                                           allowPictureInPicture,
                                           externalLinksRow,
                                           customURLSchemesControllerRow
            ).set(headerViewFormer: createHeader("Web View"))
        self.former.removeAll().append(sectionFormer: webViewSection).reload()
    }

    private func pushSelectorRowSelected(controller: FormViewController) -> (RowFormer) -> Void {
        return { [weak self] rowFormer in
            if rowFormer is LabelRowFormer<FormLabelCell> {
                self?.navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
}
