//
//  PlaceModuleIO.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 10.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import ViperKit

protocol PlaceModuleInput: ModuleInput {
    func configure(with place: PlaceM)
}
