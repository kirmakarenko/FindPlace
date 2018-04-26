//
//  NameCell.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 03.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import TableKit
import UIKit

class NameCell: UITableViewCell {

    @IBOutlet weak var awesomeTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        awesomeTextField.delegate = self
    }

    @IBAction func nameChanged(_ sender: UITextField) {
        TableCellAction(key: Actions.textChanged, sender: self).invoke()
    }
}

extension NameCell: ConfigurableCell {

    static var defaultHeight: CGFloat? {
        return 45
    }

    func configure(with place: PlaceM) {
        awesomeTextField.text = place.name
    }
}

extension NameCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        awesomeTextField.resignFirstResponder()
        return false
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        //contentView.addSubview(<#T##view: UIView##UIView#>)
    }
}
