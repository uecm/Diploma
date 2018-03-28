//
//  TextFieldCell.swift
//  Diploma
//
//  Created by Egor on 3/27/18.
//  Copyright © 2018 egor. All rights reserved.
//

import UIKit

protocol TextFieldCellDelegate {
    func textFiledCell(_ cell: TextFieldCell, didEndEditingWith text: String)
}

class TextFieldCell: UITableViewCell {
    
    var delegate: TextFieldCellDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    struct Configurator {
        let title: String
        let placeholder: String?
        let text: String?
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with configurator: Configurator) {
        titleLabel.text = configurator.title
        textField.placeholder = configurator.placeholder
        textField.text = configurator.text
    }
    
    @IBAction func textFieldDidEndEditing(_ sender: UITextField) {
        delegate?.textFiledCell(self, didEndEditingWith: sender.text ?? "")
    }
    
}
