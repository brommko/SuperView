//
//  GPSConfigurationViewController.swift
//  Example
//
//  Created by Brommko LLC on 20/12/2018.
//  Copyright © 2018 Brommko LLC. All rights reserved.
//

import UIKit
import Former
import SuperView

class GPSConfigurationViewController: FormViewController {

    let createHeader: ((String) -> ViewFormer) = { text in
        return LabelViewFormer<FormLabelHeaderView>()
            .configure {
                $0.text = text
                $0.viewHeight = 40
        }
    }

    let willRequestAlways = SwitchRowFormer<FormSwitchCell>() {
        $0.titleLabel.text = "Will request always"
        $0.titleLabel.font = .boldSystemFont(ofSize: 15)
        }.configure {
            $0.switched = SuperView.shared.options.gps.willRequestAlways
        }.onSwitchChanged { on in
            SuperView.shared.options.gps.willRequestAlways = on
    }
    var permissionSection:SectionFormer!

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
                $0.switched = SuperView.shared.options.gps.isEnabled
            }.onSwitchChanged { on in
                SuperView.shared.options.gps.isEnabled = on
                self.switchDefaultsSection()
        }

        // Create SectionFormers
        let webViewSection = SectionFormer(rowFormer: isEnabled).set(headerViewFormer: createHeader("GPS"))
        self.permissionSection = SectionFormer(rowFormer: willRequestAlways).set(headerViewFormer: createHeader("Permission"))

        self.former.append(sectionFormer: webViewSection)
        if SuperView.shared.options.gps.isEnabled {
            self.former.append(sectionFormer: self.permissionSection)
        }
    }

    private func switchDefaultsSection() {
        if SuperView.shared.options.gps.isEnabled {
            self.former.insertUpdate(sectionFormer: self.permissionSection, toSection: self.former.numberOfSections, rowAnimation: .top)
        } else {
            self.former.removeUpdate(sectionFormer: self.permissionSection, rowAnimation: .top)
        }
    }
}
