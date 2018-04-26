//
//  AddPlacePresenter.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 04.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import Foundation

struct AppPlacePresenterState {
    var place: PlaceM?
}

class AddPlacePresenterImpl {

    fileprivate weak var view: AddPlaceViewControllerInput?
    fileprivate var interactor: AddPlaceInteractorInput
    fileprivate var router: AddPlaceRouterInput

    fileprivate var state = AppPlacePresenterState()

    init(view: AddPlaceViewControllerInput, interactor: AddPlaceInteractorInput, router: AddPlaceRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension AddPlacePresenterImpl: AddPlaceViewControllerOutput {
    func savePressed(place: PlaceM) {
        interactor.addPlace(place: place)
        router.closeModule()
    }

    func saveImage(data: Data, name: String) {
        interactor.addImage(data: data, name: name)
    }

    func viewReadyEvent() {
        if let editablePlace = state.place {
            view?.configure(with: editablePlace)
        } else {
            interactor.getLocation()
        }
    }

    func backPressed() {
        router.closeModule()
    }
}

extension AddPlacePresenterImpl: AddPlaceModuleInput {
    func configureWith(place: PlaceM) {
        state.place = place
    }
}

extension AddPlacePresenterImpl: AddPlaceInteractorOutput {
    func didGetLocation(latitude: Double, longitude: Double) {
        view?.updateLocation(latitude: latitude, longitude: longitude)
    }
}
