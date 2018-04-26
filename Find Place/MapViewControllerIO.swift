//
//  MapViewIO.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 04.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//
import CoreLocation

protocol MapViewControllerInput: class {
    func showPlaces(places: [PlaceM])
    func updateLocation(latitude: Double, longitude: Double)
    func showError(with message: String)
}

protocol MapViewControllerOutput: class {
    func viewReadyEvent()
    func showPlace(place: PlaceM)
    func addPlace()
    func signOutPressed()
}
