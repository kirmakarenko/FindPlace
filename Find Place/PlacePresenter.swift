//
//  PlacePresenter.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 10.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//
import UIKit

class PlacePresenterImpl {
    fileprivate weak var view: PlaceViewControllerInput?
    fileprivate var router: PlaceRouter
    fileprivate var interactor: PlaceInteractorInput

    init(view: PlaceViewControllerInput, router: PlaceRouter, interactor: PlaceInteractorInput) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension PlacePresenterImpl: PlaceViewControllerOutput {
    func getPhoto(name: String) {
        interactor.getPhoto(name: name)
    }
    func closePressed() {
        router.closeModule()
    }

    func editPressed(place: PlaceM) {
        router.openEditTaskModule(place: place)
    }

    func ratingChanged(place: PlaceM) {
        interactor.updateRating(place: place)
    }
}

extension PlacePresenterImpl: PlaceModuleInput {
    func configure(with place: PlaceM) {
        view?.configure(with: place)
    }
}

extension PlacePresenterImpl: PlaceInteractorOutput {
    func setPhoto(image: UIImage) {
        view?.setPhoto(photo: image)
    }
}
