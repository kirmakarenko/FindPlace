//
//  AddPlaceModuleIO.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 15.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import ViperKit

protocol AddPlaceModuleInput: ModuleInput {
    func configureWith(place: PlaceM)
}

protocol AddPlaceModuleOutput {

}
