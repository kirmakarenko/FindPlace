//
//  MapPresenter.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 04.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

class MapPresenterImpl {
    fileprivate weak var view: MapViewControllerInput?
    fileprivate let interactor: MapInteractorInput
    fileprivate let router: MapRouterInput

    init(view: MapViewControllerInput, interactor: MapInteractorInput, router: MapRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK: MapViewControllerOutput

extension MapPresenterImpl: MapViewControllerOutput {

    func viewReadyEvent() {
        interactor.getLocation()
        interactor.getPlaces()
    }

    func showPlace(place: PlaceM) {
        router.openPlaceModule(place: place)
    }

    func addPlace() {
        router.openAddPlaceModule()
    }

    func signOutPressed() {
        router.closeModule()
    }
}

// MARK: MapInteractorOutput

extension MapPresenterImpl: MapInteractorOutput {

    func didGetPlaces(places: [PlaceM]) {
        view?.showPlaces(places: places)
    }

    func didGetPlacesWithError(message: String) {
        view?.showError(with: message)
    }

    func didGetLocation(latitude: Double, longitude: Double) {
        view?.updateLocation(latitude: latitude, longitude: longitude)
    }
}

extension MapPresenterImpl: MapModuleInput {}
