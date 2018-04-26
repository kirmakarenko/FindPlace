//
//  PhotoCell.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 03.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import UIKit
import TableKit

protocol PhotoCellDelegate: class {
    func photoActionTapped()
}

class PhotoCell: UITableViewCell {

    weak var delegate: PhotoCellDelegate?

    @IBOutlet weak var photoButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()

        photoButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
    }

    func configure(delegate: PhotoCellDelegate) {
        self.delegate = delegate
    }

    func showAlert() {
        TableCellAction(key: Actions.photoTapped, sender: self).invoke()
    }
}

extension PhotoCell: ConfigurableCell {
    func configure(with place: PlaceM) {

    }
}
