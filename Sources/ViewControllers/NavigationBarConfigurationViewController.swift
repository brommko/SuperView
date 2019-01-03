//
//  NavigationBarConfigurationViewController.swift
//  Example
//
//  Created by Brommko LLC on 20/12/2018.
//  Copyright © 2018 Brommko LLC. All rights reserved.
//

import UIKit
import Former
import SuperView

class NavigationBarConfigurationViewController: FormViewController {

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
        let isStatusBarLight = SwitchRowFormer<FormSwitchCell>() {
            $0.titleLabel.text = "Status bar is light"
            $0.titleLabel.font = .boldSystemFont(ofSize: 15)
            }.configure {
                $0.switched = SuperView.shared.options.navigationBar.isStatusBarLight
            }.onSwitchChanged { on in
                SuperView.shared.options.navigationBar.isStatusBarLight = on
        }
        let backgroundColor = TextFieldRowFormer<SuperViewTextFieldCell>(instantiateType: .Nib(nibName: "SuperViewTextFieldCell")) { [weak self] in
            $0.titleLabel.text = "Background color"
            $0.titleLabel.font = .boldSystemFont(ofSize: 15)
            }.configure {
                $0.placeholder = SuperView.shared.options.navigationBar.backgroundColor
            }.onTextChanged { text in
                SuperView.shared.options.navigationBar.backgroundColor = text
        }
        let titleColor = TextFieldRowFormer<SuperViewTextFieldCell>(instantiateType: .Nib(nibName: "SuperViewTextFieldCell")) { [weak self] in
            $0.titleLabel.text = "Title color"
            $0.titleLabel.font = .boldSystemFont(ofSize: 15)
            }.configure {
                $0.placeholder = SuperView.shared.options.navigationBar.titleColor
            }.onTextChanged { text in
                SuperView.shared.options.navigationBar.titleColor = text
        }
        let progressColor = TextFieldRowFormer<SuperViewTextFieldCell>(instantiateType: .Nib(nibName: "SuperViewTextFieldCell")) { [weak self] in
            $0.titleLabel.text = "Progress color"
            $0.titleLabel.font = .boldSystemFont(ofSize: 15)
            }.configure {
                $0.placeholder = SuperView.shared.options.navigationBar.progressColor
            }.onTextChanged { text in
                SuperView.shared.options.navigationBar.progressColor = text
        }
        return SectionFormer(rowFormer: isStatusBarLight, backgroundColor, titleColor, progressColor).set(headerViewFormer: self.createHeader("Default colors"))
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
                $0.switched = SuperView.shared.options.navigationBar.isEnabled
            }.onSwitchChanged { on in
                SuperView.shared.options.navigationBar.isEnabled = on
                self.switchDefaultsSection()
        }

        // Create SectionFormers
        let isEnabledSection = SectionFormer(rowFormer: isEnabled).set(headerViewFormer: self.createHeader("Navigation Bar"))
        self.former.append(sectionFormer: isEnabledSection)
        if SuperView.shared.options.navigationBar.isEnabled {
            self.former.append(sectionFormer: self.defaultsSection)
        }
    }

    private func switchDefaultsSection() {
        if SuperView.shared.options.navigationBar.isEnabled {
            self.former.insertUpdate(sectionFormer: self.defaultsSection, toSection: self.former.numberOfSections, rowAnimation: .top)
        } else {
            self.former.removeUpdate(sectionFormer: self.defaultsSection, rowAnimation: .top)
        }
    }

}
