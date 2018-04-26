//
//  AddPlaceInteractorImpl.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 04.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//
import PromiseKit

class AddPlaceInteractorImpl: AddPlaceInteractorInput {

    var moduleOutput: AddPlaceInteractorOutput?

    private var firebaseService: FirebaseService
    private var locationService: LocationService

    init(firebaseService: FirebaseService, locationService: LocationService) {
        self.firebaseService = firebaseService
        self.locationService = locationService
    }

    func addImage(data: Data, name: String) {
        firebaseService.uploadPhoto(data: data, name: name)
    }

    func addPlace(place: PlaceM) {
        firebaseService.addPlace(place: place)
    }

    func getLocation() {
        locationService.obtainCurrentLocation().then { location -> Void in
            self.moduleOutput?.didGetLocation(latitude: location.coordinate.latitude,
                                        longitude: location.coordinate.longitude)
            }.catch { error in
                print(error.localizedDescription)
        }
    }
}
