//
//  AddPlaceViewControllerIO.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 04.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import Foundation

protocol AddPlaceViewControllerInput: class {
    func configure(with place: PlaceM)
    func updateLocation(latitude: Double, longitude: Double)
}

protocol AddPlaceViewControllerOutput: class {
    func viewReadyEvent()
    func savePressed(place: PlaceM)
    func saveImage(data: Data, name: String)
    func backPressed()
}
