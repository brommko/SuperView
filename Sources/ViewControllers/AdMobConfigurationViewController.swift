//
//  AdMobConfigurationViewController.swift
//  Example
//
//  Created by Brommko LLC on 21/12/2018.
//  Copyright © 2018 Brommko LLC. All rights reserved.
//

import UIKit
import Former
import SuperView

class AdMobConfigurationViewController: FormViewController {

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

        // Create RowFomers
        let isEnabled = SwitchRowFormer<FormSwitchCell>() {
            $0.titleLabel.text = "Enabled"
            $0.titleLabel.font = .boldSystemFont(ofSize: 15)
            }.configure {
                $0.switched = SuperView.shared.options.adMob.isEnabled
            }.onSwitchChanged { on in
                SuperView.shared.options.adMob.isEnabled = on
        }

        // Create SectionFormers
        let webViewSection = SectionFormer(rowFormer: isEnabled).set(headerViewFormer: createHeader("GPS"))
        self.former.append(sectionFormer: webViewSection)
    }
}
