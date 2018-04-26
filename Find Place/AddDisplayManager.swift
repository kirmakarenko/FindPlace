//
//  AddDisplayManager.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 02.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import UIKit
import GoogleMaps
import DTTableViewManager
import DTModelStorage
import TableKit
import Cosmos

class AddDisplayManager: NSObject {

    weak var tableView: UITableView?
    weak var delegate: AddDisplayManagerDelegate?

    // when moving to 2nd screen, table view is scrolling, causes showing button
    var lastContentOffset: CGFloat = -1

    var placeM: PlaceM = {
        return PlaceM(name: "", latitude: 0, longitude: 0, marksNumber: 0, rating: [0, 0, 0, 0, 0, 0, 0, 0, 0])
    }()

    var tableDirector: TableDirector!

    func configureWith(place: PlaceM) {
        placeM = place
    }

    func setUpTableView() {

        let nameChanged = TableRowAction<NameCell>(.custom(Actions.textChanged)) { (options) in
            self.placeM.name = (options.cell?.awesomeTextField.text)!
        }

        let addressChanged = TableRowAction<AddressCell>(.custom(Actions.addressChanged)) { (options) in
            self.placeM.address = (options.cell?.addressField.text)!
        }

        let openHourChanged = TableRowAction<WorkingHoursCell>(.custom(Actions.openHour)) { (options) in
            self.placeM.openHour = (options.cell?.openHour)!
        }

        let openMinuteChanged = TableRowAction<WorkingHoursCell>(.custom(Actions.openMinute)) { (options) in
            self.placeM.openMinute = (options.cell?.openMinute)
        }

        let closeHourChanged = TableRowAction<WorkingHoursCell>(.custom(Actions.closeHour)) { (options) in
            self.placeM.closeHour = (options.cell?.closeHour)
        }

        let closeMinuteChanged = TableRowAction<WorkingHoursCell>(.custom(Actions.closeMinute)) { (options) in
            self.placeM.closeMinute = (options.cell?.closeMinute)
        }

        let photoChanged = TableRowAction<PhotoCell>(.custom(Actions.photoTapped)) { (_) in
            self.delegate?.showAlert()
        }

        let minPriceChanged = TableRowAction<PriceCell>(.custom(Actions.minPrice)) { (options) in
            self.placeM.minPrice = Int((options.cell?.bottomPriceField.text)!)
        }

        let maxPriceChanged = TableRowAction<PriceCell>(.custom(Actions.maxPrice)) { (options) in
            self.placeM.maxPrice = Int((options.cell?.topPriceField.text)!)
        }

        let mapMoved = TableRowAction<MapCell>(.custom(Actions.moveMap)) { (options) in
            self.placeM.latitude = (options.cell?.mapView.projection.coordinate(
                for: (options.cell?.mapView.center)!))!.latitude
            self.placeM.longitude = (options.cell?.mapView.projection.coordinate(
                for: (options.cell?.mapView.center)!))!.longitude
        }

        let mapRow = TableRow<MapCell>(item: placeM, actions: [mapMoved])
        let nameRow = TableRow<NameCell>(item: placeM, actions: [nameChanged])
        let photoRow = TableRow<PhotoCell>(item: placeM, actions: [photoChanged])
        let priceCell = TableRow<PriceCell>(item: placeM, actions: [minPriceChanged, maxPriceChanged])
        let workingHoursCell = TableRow<WorkingHoursCell>(item: placeM, actions: [
            openHourChanged, openMinuteChanged, closeHourChanged, closeMinuteChanged
            ])
        let addressCell = TableRow<AddressCell>(item: placeM, actions: [addressChanged])

        let section = TableSection(rows: [
                                mapRow, nameRow, addressCell, photoRow, priceCell, workingHoursCell
                                ])

        tableDirector = TableDirector(
                        tableView: tableView!, scrollDelegate: self,
                        shouldUseAutomaticCellRegistration: true,
                        shouldUsePrototypeCellHeightCalculation: true)

        tableDirector += section
    }
}

extension AddDisplayManager: UITableViewDelegate {

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if lastContentOffset != -1 {
            if self.lastContentOffset < scrollView.contentOffset.y {
                // moved to bottom
                delegate?.movedBottom()
            } else if self.lastContentOffset > scrollView.contentOffset.y {
                // moved to top
                delegate?.movedTop()
            } else {

            }
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let  height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom <= height {
            delegate?.movedTop()
        } else {
            print("d: \(distanceFromBottom) g: \(height)")
        }
    }
}
