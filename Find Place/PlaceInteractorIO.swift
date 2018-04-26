//
//  PlaceInteractorIO.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 10.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//
import PromiseKit

protocol PlaceInteractorOutput {
    func setPhoto(image: UIImage)
}

protocol PlaceInteractorInput {
    func getPhoto(name: String)
    func updateRating(place: PlaceM)
}
