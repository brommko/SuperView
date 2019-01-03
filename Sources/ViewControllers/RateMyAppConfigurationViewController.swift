//
//  RateMyAppConfigurationViewController.swift
//  Example
//
//  Created by Brommko LLC on 21/12/2018.
//  Copyright © 2018 Brommko LLC. All rights reserved.
//

import UIKit
import Former
import SuperView

class RateMyAppConfigurationViewController: FormViewController {

    let createHeader: ((String) -> ViewFormer) = { text in
        return LabelViewFormer<FormLabelHeaderView>()
            .configure {
                $0.text = text
                $0.viewHeight = 40
        }
    }

    private lazy var defaultsSection: SectionFormer = {
        let promptForReviewCounter = TextFieldRowFormer<SuperViewTextFieldCell>(instantiateType: .Nib(nibName: "SuperViewTextFieldCell")) { [weak self] in
            $0.titleLabel.text = "Review counter"
            $0.titleLabel.font = .boldSystemFont(ofSize: 15)
            }.configure {
                $0.placeholder = "\(SuperView.shared.options.rateMyApp.promptForReviewCounter)"
                $0.text = "\(SuperView.shared.options.rateMyApp.promptForReviewCounter)"
            }.onTextChanged { text in
                SuperView.shared.options.rateMyApp.promptForReviewCounter = Int(text) ?? 0
        }
        return SectionFormer(rowFormer: promptForReviewCounter).set(headerViewFormer: self.createHeader("Default"))
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.former.reload()
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
                $0.switched = SuperView.shared.options.rateMyApp.isEnabled
            }.onSwitchChanged { on in
                SuperView.shared.options.rateMyApp.isEnabled = on
                self.switchDefaultsSection()
        }

        // Create SectionFormers
        let webViewSection = SectionFormer(rowFormer: isEnabled).set(headerViewFormer: createHeader("Rate my app"))
        self.former.append(sectionFormer: webViewSection)
        if SuperView.shared.options.rateMyApp.isEnabled {
            self.former.append(sectionFormer: self.defaultsSection)
        }
    }

    private func switchDefaultsSection() {
        if SuperView.shared.options.rateMyApp.isEnabled {
            self.former.insertUpdate(sectionFormer: self.defaultsSection, toSection: self.former.numberOfSections, rowAnimation: .top)
        } else {
            self.former.removeUpdate(sectionFormer: self.defaultsSection, rowAnimation: .top)
        }
    }
}
