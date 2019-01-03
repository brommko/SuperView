//
//  ActivityIndicatorConfigurationViewController.swift
//  Example
//
//  Created by Brommko LLC on 24/12/2018.
//  Copyright © 2018 Brommko LLC. All rights reserved.
//

import UIKit
import Former
import SuperView

class ActivityIndicatorConfigurationViewController: FormViewController {

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
        let message = TextFieldRowFormer<SuperViewTextFieldCell>(instantiateType: .Nib(nibName: "SuperViewTextFieldCell")) {
            $0.titleLabel.text = "Message"
            $0.titleLabel.font = .boldSystemFont(ofSize: 15)
            }.configure {
                $0.placeholder = SuperView.shared.options.activityIndicator.message
            }.onTextChanged { text in
                SuperView.shared.options.activityIndicator.message = text
        }
        let type = self.createSelectorRow("Select type", "\(SuperView.shared.options.activityIndicator.type)", self.pushSelectorRowSelected(controller: ActivityIndicatorViewController()))
        return SectionFormer(rowFormer: message, type).set(headerViewFormer: self.createHeader("Defaults"))
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
                $0.switched = SuperView.shared.options.activityIndicator.isEnabled
            }.onSwitchChanged { on in
                SuperView.shared.options.activityIndicator.isEnabled = on
                self.switchDefaultsSection()
        }

        // Create SectionFormers
        let isEnabledSection = SectionFormer(rowFormer: isEnabled).set(headerViewFormer: self.createHeader("Activity indicator"))
        self.former.removeAll().append(sectionFormer: isEnabledSection).reload()
        if SuperView.shared.options.activityIndicator.isEnabled {
            self.former.append(sectionFormer: self.defaultsSection).reload()
        }
    }

    private func switchDefaultsSection() {
        if SuperView.shared.options.activityIndicator.isEnabled {
            self.former.insertUpdate(sectionFormer: self.defaultsSection, toSection: self.former.numberOfSections, rowAnimation: .top).reload()
        } else {
            self.former.removeUpdate(sectionFormer: self.defaultsSection, rowAnimation: .top).reload()
        }
    }

}
