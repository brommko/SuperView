//
//  InAppPurchaseConfigurationViewController.swift
//  Example
//
//  Created by Brommko LLC on 26/12/2018.
//  Copyright © 2018 Brommko LLC. All rights reserved.
//

import Foundation

import UIKit
import Former
import SuperView

class InAppPurchaseConfigurationViewController: FormViewController {

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

    private func pushSelectorRowSelected(controller: FormViewController) -> (RowFormer) -> Void {
        return { [weak self] rowFormer in
            if rowFormer is LabelRowFormer<FormLabelCell> {
                self?.navigationController?.pushViewController(controller, animated: true)
            }
        }
    }

    private lazy var defaultsSection: SectionFormer = {
        return self.createDefaultsSection()
    }()

    func createDefaultsSection() -> SectionFormer {
        let productId = TextFieldRowFormer<FormTextFieldCell>() {
            $0.titleLabel.font = .boldSystemFont(ofSize: 15)
            }.configure {
                $0.placeholder = "Your Non-Consumable product id"
                $0.text = SuperView.shared.options.inAppPurchase.productId
            }.onTextChanged { text in
                SuperView.shared.options.inAppPurchase.productId = text
        }
        return SectionFormer(rowFormer: productId).set(headerViewFormer: self.createHeader("Product ID"))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.defaultsSection = self.createDefaultsSection()
        self.configure()
    }

    private func configure() {
        self.tableView.contentInset.top = 10
        self.tableView.contentInset.bottom = 30
        self.tableView.contentOffset.y = -10

        // Create RowFomers
        let isEnabled = SwitchRowFormer<FormSwitchCell>() {
            $0.titleLabel.text = "Enabled"
            $0.titleLabel.font = .boldSystemFont(ofSize: 15)
            }.configure {
                $0.switched = SuperView.shared.options.inAppPurchase.isEnabled
            }.onSwitchChanged { on in
                SuperView.shared.options.inAppPurchase.isEnabled = on
                self.switchDefaultsSection()
        }

        // Create SectionFormers
        let isEnabledSection = SectionFormer(rowFormer: isEnabled).set(headerViewFormer: self.createHeader("In-App purchase"))
        self.former.removeAll().append(sectionFormer: isEnabledSection).reload()
        if SuperView.shared.options.inAppPurchase.isEnabled {
            self.former.append(sectionFormer: self.defaultsSection).reload()
        }
    }

    private func switchDefaultsSection() {
        if SuperView.shared.options.inAppPurchase.isEnabled {
            self.former.insertUpdate(sectionFormer: self.defaultsSection, toSection: self.former.numberOfSections, rowAnimation: .top).reload()
        } else {
            self.former.removeUpdate(sectionFormer: self.defaultsSection, rowAnimation: .top).reload()
        }
    }

}
