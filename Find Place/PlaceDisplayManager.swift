//
//  DisplayManager.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 09.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//
import UIKit

protocol PlaceDisplayManagerDelegate: class {
    func update()
}

class PlaceDisplayManager: NSObject {
    weak var delegate: PlaceDisplayManagerDelegate?
    var place: PlaceM?
}

extension PlaceDisplayManager: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlacePriceCell") as? PlacePriceCell else {
                fatalError("Cell is not PlacePriceCell")
            }
            cell.contentView.backgroundColor = UIColor(red: 62.0/255.0, green: 71.0/255.0, blue: 87.0/255.0, alpha: 1.0)
            cell.selectionStyle = .none
            cell.configure(with: place!)
            return cell
        } else {
            let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
            return cell
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

extension PlaceDisplayManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        } else {
            return UITableViewAutomaticDimension
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

}

extension PlaceDisplayManager: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.update()
    }
}
