//
//  MapInteractorIO.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 04.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import CoreLocation

protocol MapInteractorInput {
    func getPlaces()
    func getLocation()

}

protocol MapInteractorOutput {
    func didGetPlaces(places: [PlaceM])
    func didGetPlacesWithError(message: String)
    func didGetLocation(latitude: Double, longitude: Double)
}
