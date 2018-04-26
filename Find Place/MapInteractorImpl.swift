//
//  MapInteractorImpl.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 04.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import PromiseKit

class MapInteractorImpl: MapInteractorInput {

    var output: MapInteractorOutput?

    private var firebaseService: FirebaseService
    private var locationService: LocationService

    init(firebaseService: FirebaseService, locationService: LocationService) {
        self.firebaseService = firebaseService
        self.locationService = locationService
    }

    func getLocation() {
        locationService.obtainCurrentLocation().then { location -> Void in
            self.output?.didGetLocation(latitude: location.coordinate.latitude,
                                        longitude: location.coordinate.longitude)
            }.catch { _ in

        }
    }

    func getPlaces() {
        firebaseService.getPlaces().then { places in
            self.output?.didGetPlaces(places: places)
        }.catch { _ in
            self.output?.didGetPlacesWithError(message: "Не удалось получить ответ от сервера")
        }
    }
}
