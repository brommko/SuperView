//
//  ProfileFieldCell.swift
//  Example
//
//  Created by Brommko LLC on 21/12/2018.
//  Copyright © 2018 Brommko LLC. All rights reserved.
//

import UIKit
import Former

final class SuperViewTextFieldCell: UITableViewCell, TextFieldFormableRow {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.textColor = .black
        self.textField.textColor = .gray
    }
    
    func formTextField() -> UITextField {
        return self.textField
    }
    
    func formTitleLabel() -> UILabel? {
        return self.titleLabel
    }
    
    func updateWithRowFormer(_ rowFormer: RowFormer) {}
}
