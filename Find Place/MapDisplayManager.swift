//
//  DisplayManager.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 01.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import Foundation
import GoogleMaps

class MapDisplayManager: NSObject {
    weak var delegate: MapDisplayManagerDelegate?
}

extension MapDisplayManager: GMSMapViewDelegate {

    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        let placeMarker = marker as? PlaceMarker
        guard let unwrappedMarker = placeMarker else {
            return
        }

        delegate?.infoWindowTapped(place: unwrappedMarker.place)
    }

    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let optionalMarker = marker as? PlaceMarker
        let optionalNib = Bundle.main.loadNibNamed("MarkerWindow", owner: self, options: nil)?.first as? MarkerWindow

        guard let placeMarker = optionalMarker, let infoWindow = optionalNib else {
            return nil
        }

        infoWindow.configure(with: placeMarker.place.name, andRating: (placeMarker.place.averageRating))

        return infoWindow
    }
}
