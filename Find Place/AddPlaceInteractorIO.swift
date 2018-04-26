//
//  AddPlaceInteractorIO.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 04.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//
import Foundation

protocol AddPlaceInteractorInput {
    func addPlace(place: PlaceM)
    func addImage(data: Data, name: String)
    func getLocation()
}

protocol AddPlaceInteractorOutput {
    func didGetLocation(latitude: Double, longitude: Double)
}
