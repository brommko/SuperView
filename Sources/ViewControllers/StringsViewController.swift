//
//  StringsViewController.swift
//  Example
//
//  Created by Brommko LLC on 21/12/2018.
//  Copyright © 2018 Brommko LLC. All rights reserved.
//

import UIKit
import Former
import SuperView

final class StringsViewController: FormViewController {

    // MARK: Public
    var strings = [String]() {
        didSet {
            self.reloadForm()
        }
    }

    var onSelected: ((String) -> Void)?
    var onSave: (([String]) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction))
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @objc func addAction() {
        let alertController = UIAlertController(title: "Add URL", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter text"
        }
        let saveAction = UIAlertAction(title: "Add", style: .default, handler: { alert -> Void in
            let titleField = alertController.textFields![0] as UITextField
            print("title \(String(describing: titleField.text))")
            if let title = titleField.text {
                self.strings.append(title)
            }
            self.onSave?(self.strings)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }

    private func reloadForm() {
        // Create RowFormers
        let rowFormers = self.strings.map { string -> LabelRowFormer<FormLabelCell> in
            return LabelRowFormer<FormLabelCell>() { [weak self] in
                if let _ = self {
                    $0.titleLabel.font = .boldSystemFont(ofSize: 16)
                    $0.selectionStyle = .none
                }
                }.configure {
                    $0.text = string
                }.onSelected { [weak self] _ in
                    self?.onSelected?(string)
            }
        }

        // Create SectionFormers
        let sectionFormer = SectionFormer(rowFormers: rowFormers)
        self.former.removeAll().append(sectionFormer: sectionFormer).reload()
    }
}
