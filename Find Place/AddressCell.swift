//
//  AdressCell.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 14.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import UIKit
import TableKit

class AddressCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        addressField.delegate = self
    }
    @IBOutlet weak var addressField: UITextField!
    @IBAction func addressChanged(_ sender: UITextField) {
        TableCellAction(key: Actions.addressChanged, sender: self).invoke()
    }
}

extension AddressCell: ConfigurableCell {

    static var defaultHeight: CGFloat? {
        return 70
    }

    func configure(with place: PlaceM) {
        if place.address != nil {
            addressField.text = place.address
        }
    }
}

extension AddressCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addressField.resignFirstResponder()
        return false
    }
}
