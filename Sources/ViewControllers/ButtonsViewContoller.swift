//
//  ButtonsViewContoller.swift
//  Former-Demo
//
//  Created by Ryo Aoyama on 8/10/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

import UIKit
import Former
import SuperView

final class ButtonsViewContoller: FormViewController {
    
    // MARK: Public
    typealias Tuple = (name: String, url: String)

    var tuples = [Tuple]() {
        didSet {
            self.reloadForm()
        }
    }
    
    var onSelected: ((Tuple) -> Void)?
    var onSave: (([Tuple]) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction))
    }

    @objc func addAction() {
        let alertController = UIAlertController(title: "Add button", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter title"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter url"
            textField.keyboardType = .webSearch
        }
        let saveAction = UIAlertAction(title: "Add", style: .default, handler: { alert -> Void in
            let titleField = alertController.textFields![0] as UITextField
            let urlField = alertController.textFields![1] as UITextField
            print("title \(String(describing: titleField.text)), url \(String(describing: urlField.text))")
            if let title = titleField.text, let url = urlField.text {
                self.tuples.append((name: title, url: url))
            }
            self.onSave?(self.tuples)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }

    private func reloadForm() {
        // Create RowFormers
        let rowFormers = self.tuples.map { tuple -> LabelRowFormer<FormLabelCell> in
            return LabelRowFormer<FormLabelCell>() { [weak self] in
                if let _ = self {
                    $0.titleLabel.font = .boldSystemFont(ofSize: 16)
                    $0.selectionStyle = .none
                }
                }.configure {
                    $0.text = tuple.name
                    $0.subText = tuple.url
                }.onSelected { [weak self] _ in
                    self?.onSelected?(tuple)
            }
        }
        
        // Create SectionFormers
        let sectionFormer = SectionFormer(rowFormers: rowFormers)
        self.former.removeAll().append(sectionFormer: sectionFormer).reload()
    }
}
