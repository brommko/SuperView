//
//  CustomFontConfigurationViewController.swift
//  Example
//
//  Created by Brommko LLC on 20/12/2018.
//  Copyright © 2018 Brommko LLC. All rights reserved.
//

import UIKit
import Former
import SuperView

class CustomFontConfigurationViewController: FormViewController {

    // Create Headers
    let createHeader: ((String) -> ViewFormer) = { text in
        return LabelViewFormer<FormLabelHeaderView>()
            .configure {
                $0.text = text
                $0.viewHeight = 40
        }
    }

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

        let fontRow = TextFieldRowFormer<SuperViewTextFieldCell>(instantiateType: .Nib(nibName: "SuperViewTextFieldCell")) {
            $0.titleLabel.text = "Font name"
            $0.titleLabel.font = .boldSystemFont(ofSize: 15)
            }.configure {
                $0.placeholder = SuperView.shared.options.font?.name
                $0.text = SuperView.shared.options.font?.name
            }.onTextChanged { text in
                SuperView.shared.options.font?.name = text
        }
        let sizeRow = TextFieldRowFormer<SuperViewTextFieldCell>(instantiateType: .Nib(nibName: "SuperViewTextFieldCell")) {
            $0.titleLabel.text = "Font size"
            $0.titleLabel.font = .boldSystemFont(ofSize: 15)
            }.configure {
                $0.placeholder = "\(SuperView.shared.options.font?.size ?? 0)"
                $0.text = "\(SuperView.shared.options.font?.size ?? 0)"
            }.onTextChanged { text in
                SuperView.shared.options.font?.size = Float(text)
        }

        // Create SectionFormers
        let fontSection = SectionFormer(rowFormer: fontRow, sizeRow).set(headerViewFormer: self.createHeader("Custom font"))
        self.former.append(sectionFormer: fontSection)
    }
}
