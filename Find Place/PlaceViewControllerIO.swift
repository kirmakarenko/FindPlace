//
//  PlaceViewControllerIO.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 10.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//
import UIKit

protocol PlaceViewControllerInput: class {
    func configure(with place: PlaceM)
    func setPhoto(photo: UIImage)
}

protocol PlaceViewControllerOutput: class {
    func getPhoto(name: String)
    func closePressed()
    func editPressed(place: PlaceM)
    func ratingChanged(place: PlaceM)
}
