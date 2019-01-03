//
//  ToolbarConfigurationViewController.swift
//  Example
//
//  Created by Brommko LLC on 19/12/2018.
//  Copyright © 2018 Brommko LLC. All rights reserved.
//

import UIKit
import Former
import SuperView

class ToolbarConfigurationViewController: FormViewController {

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

    var customButtonsSection: SectionFormer!

    private lazy var colorSection: SectionFormer = {
        let backgroundColor = TextFieldRowFormer<SuperViewTextFieldCell>(instantiateType: .Nib(nibName: "SuperViewTextFieldCell")) { [weak self] in
            $0.titleLabel.text = "Background"
            $0.titleLabel.font = .boldSystemFont(ofSize: 15)
            }.configure {
                $0.placeholder = SuperView.shared.options.toolbar.backgroundColor
            }.onTextChanged { text in
                SuperView.shared.options.toolbar.backgroundColor = text
        }
        let buttonColor = TextFieldRowFormer<SuperViewTextFieldCell>(instantiateType: .Nib(nibName: "SuperViewTextFieldCell")) { [weak self] in
            $0.titleLabel.text = "Button"
            $0.titleLabel.font = .boldSystemFont(ofSize: 15)
            }.configure {
                $0.placeholder = SuperView.shared.options.toolbar.buttonColor
            }.onTextChanged { text in
                SuperView.shared.options.toolbar.buttonColor = text
        }
        return SectionFormer(rowFormer: backgroundColor, buttonColor).set(headerViewFormer: self.createHeader("Default colors"))
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
                $0.switched = SuperView.shared.options.toolbar.isEnabled
            }.onSwitchChanged { on in
                SuperView.shared.options.toolbar.isEnabled = on
                self.switchColorSection()
                self.switchCustomButtonsSection()
        }

        let buttonsViewContoller = ButtonsViewContoller()
        buttonsViewContoller.tuples = SuperView.shared.options.toolbar.customButtons?.map({ ($0.title!, $0.url!) }) ?? []
        buttonsViewContoller.onSave = { tuples in
            do {
                SuperView.shared.options.toolbar.customButtons = try tuples.map({ try ToolbarCustomButton(title: $0.name, url: $0.url) })
            } catch {
                print("Error with custom buttons")
            }
        }

        let customButtonsRow = self.createSelectorRow("Custom", "\(SuperView.shared.options.toolbar.customButtons?.count ?? 0)", self.pushSelectorRowSelected(controller: buttonsViewContoller))
        self.customButtonsSection = SectionFormer(rowFormer: customButtonsRow).set(headerViewFormer: self.createHeader("Buttons"))

        // Create SectionFormers
        let toolbarSection = SectionFormer(rowFormer: isEnabled).set(headerViewFormer: self.createHeader("Toolbar"))
        self.former.removeAll().append(sectionFormer: toolbarSection).reload()
        if SuperView.shared.options.toolbar.isEnabled {
            self.former.append(sectionFormer: self.colorSection, self.customButtonsSection).reload()
        }
    }

    private func switchColorSection() {
        if SuperView.shared.options.toolbar.isEnabled {
            self.former.insertUpdate(sectionFormer: self.colorSection, toSection: self.former.numberOfSections, rowAnimation: .top)
        } else {
            self.former.removeUpdate(sectionFormer: self.colorSection, rowAnimation: .top)
        }
    }

    private func switchCustomButtonsSection() {
        if SuperView.shared.options.toolbar.isEnabled {
            self.former.insertUpdate(sectionFormer: self.customButtonsSection, toSection: self.former.numberOfSections, rowAnimation: .top)
        } else {
            self.former.removeUpdate(sectionFormer: self.customButtonsSection, rowAnimation: .top)
        }
    }
}
