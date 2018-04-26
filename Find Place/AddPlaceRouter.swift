//
//  AddPlaceRouter.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 15.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import ViperKit

protocol AddPlaceRouterInput: class {
    func closeModule()
}

class AddPlaceRouterImpl: AddPlaceRouterInput {
    weak var transitionHandler: TransitionHandler?

    init(transitionHandler: TransitionHandler) {
        self.transitionHandler = transitionHandler
    }

    func closeModule() {
        transitionHandler?.closeCurrentModule()
    }
}
