//
//  MarkerWindow.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 09.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import UIKit
import Cosmos

class MarkerWindow: UIView {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!

    override func awakeFromNib() {
        frame = CGRect(x: 0, y: 0, width: 120, height: 50)
        layer.cornerRadius = 10.0
    }

    func configure(with placeName: String, andRating rating: Double) {
        nameLabel.text = placeName
        ratingView.rating = rating
    }
}
