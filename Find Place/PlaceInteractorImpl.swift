//
//  PlaceInteractor.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 10.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//
import Foundation
import PromiseKit

class PlaceInteractorImpl: PlaceInteractorInput {

    var output: PlaceInteractorOutput?
    fileprivate var firebaseService: FirebaseService

    init(firebaseService: FirebaseService) {
        self.firebaseService = firebaseService
    }

    func addImage(data: Data, name: String) {
        firebaseService.uploadPhoto(data: data, name: name)
    }

    func getPhoto(name: String) {
        firebaseService.downloadPhoto(name: name).then { image in
            self.output?.setPhoto(image: image)
        }.catch { _ in
            //fatalError("Failed get photo")
        }
    }

    func updateRating(place: PlaceM) {
        firebaseService.updateRating(place: place)
    }
}
