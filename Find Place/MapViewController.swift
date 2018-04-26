//
//  ViewController.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 01.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps
import GooglePlacePicker
import Firebase
import GoogleSignIn
import ViperKit
import Dip_UI

class MapViewController: BaseViewController, GMSMapViewDelegate {
    @IBOutlet weak var mapView: GMSMapView!

    var output: MapViewControllerOutput!
    var displayManager: MapDisplayManager! {
        didSet {
            displayManager.delegate = self
        }
    }

    var zoom: Float = 14.0

    // MARK: Life cycle

    override func viewDidLoad() {

        mapView.delegate = displayManager
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }

    //use viewWillAppear for testing, needs to be deleted later
    override func viewWillAppear(_ animated: Bool) {
        output?.viewReadyEvent()
        navigationController?.navigationBar.setVisibleState()
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.setInvisibleState()
    }

    // MARK: IBActions

    // TODO: Убрать всю логику авторизации в сервис
    @IBAction func signOut(_ sender: UIBarButtonItem) {
        do {
            let firebaseAuth = Auth.auth()
            try firebaseAuth.signOut()
            GIDSignIn.sharedInstance().signOut()
            Auth.auth().currentUser?.delete(completion: { (_) in

            })
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        output?.signOutPressed()
    }

    @IBAction func addButton(_ sender: UIBarButtonItem) {
        output?.addPlace()
    }

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
}

// MARK: MapViewControllerInput

extension MapViewController: MapViewControllerInput {

    func showPlaces(places: [PlaceM]) {
        mapView.clear()

        places.forEach { place in
            let placeMarker = PlaceMarker(place: place)

            placeMarker.position = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
            placeMarker.isFlat = true
            placeMarker.icon = UIImage(named: "beer")!
            placeMarker.map = mapView
        }
    }

    func showError(with message: String) {
        let alertController = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Закрыть", style: .cancel, handler: nil))

        present(alertController, animated: true, completion: nil)
    }

    func updateLocation(latitude: Double, longitude: Double) {
        let cameraPosition = GMSCameraPosition.camera(
            withTarget: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
            zoom: 14
        )

        mapView.camera = cameraPosition
    }
}

extension MapViewController: MapDisplayManagerDelegate {
    func infoWindowTapped(place: PlaceM) {
        output?.showPlace(place: place)
    }
}

extension MapViewController: ModuleInputProvider {
    var moduleInput: ModuleInput! {
        // swiftlint:disable:next force_cast
        return output as! ModuleInput
    }
}

extension MapViewController: StoryboardInstantiatable {}
