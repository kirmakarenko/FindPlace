//
//  MapCell.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 02.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker
import TableKit

protocol MapCellDelegate: class {

    func willMove(center: CLLocationCoordinate2D)
    func didEnd(center: CLLocationCoordinate2D)
}

class MapCell: UITableViewCell {

    fileprivate weak var delegate: MapCellDelegate?

    var zoom: Float = 16.0
    var camera: GMSCameraPosition?

    var locationService: LocationService!

    var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        return locationManager
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: IBActions

    @IBAction func zoomIn(_ sender: UIButton) {
        if zoom < 17 {
            zoom += 1
            mapView.animate(toZoom: zoom)
        }
    }
    @IBAction func zoomOut(_ sender: UIButton) {
        if zoom > 3 {
            zoom -= 1
            mapView.animate(toZoom: zoom)
        }
    }
    @IBOutlet weak var mapView: GMSMapView! {
        didSet {
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
            mapView.delegate = self
        }
    }
}

extension MapCell: CLLocationManagerDelegate {

}

extension MapCell: GMSMapViewDelegate {

    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        TableCellAction(key: Actions.moveMap, sender: self).invoke()
        delegate?.willMove(center: mapView.projection.coordinate(for: mapView.center))
    }

    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        TableCellAction(key: Actions.moveMap, sender: self).invoke()
        delegate?.didEnd(center: mapView.projection.coordinate(for: mapView.center))
    }

}

extension MapCell: ConfigurableCell {

    static var defaultHeight: CGFloat? {
        return 375
    }

    func configure(with place: PlaceM) {
        let camera = GMSCameraPosition.camera(withLatitude: place.latitude,
                                              longitude: place.longitude,
                                              zoom: 16)
        mapView.camera = camera
    }
}
