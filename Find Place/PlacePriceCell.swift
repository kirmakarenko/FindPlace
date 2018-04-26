//
//  PlacePriceCell.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 11.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import UIKit

class PlacePriceCell: UITableViewCell {
    @IBOutlet weak var priceLabel: UILabel!

    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet weak var addressLabel: UILabel!
    var minPrice: Int?
    var maxPrice: Int?
    var openHour: Int?
    var openMinute: Int?
    var closeHour: Int?
    var closeMinute: Int?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with place: PlaceM) {

        if let minPrice = place.minPrice, let maxPrice = place.maxPrice {
            priceLabel.text = "\(minPrice)-\(maxPrice)"
        } else {
            priceLabel.text = "-"
        }

        if let openHour = place.openHour, let openMinute = place.openMinute,
            let closeHour = place.closeHour, let closeMinute = place.closeMinute {
            timeLabel.text = "\(openHour):\(openMinute/10 == 0 ? "0"+String(openMinute): String(openMinute))-\(closeHour):\(closeMinute/10 == 0 ? "0"+String(closeMinute): String(closeMinute))"
        } else {
            timeLabel.text = "-"
        }

        if let address = place.address {
            addressLabel.text = address
        } else {
            addressLabel.isHidden = true
        }
    }
}
