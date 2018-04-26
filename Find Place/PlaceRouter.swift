//
//  PlaceRouter.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 10.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import ViperKit

protocol PlaceRouter: class {
    func closeModule()
    func openEditTaskModule(place: PlaceM)
}

class PlaceRouterImpl: PlaceRouter {

    private var transitionHandler: TransitionHandler?
    init(transitionHandler: TransitionHandler) {
        self.transitionHandler = transitionHandler
    }

    func closeModule() {
        transitionHandler?.closeCurrentModule()
    }

    func openEditTaskModule(place: PlaceM) {
        transitionHandler?.openModule(segueIdentifier: "editSegue", configurationBlock: { moduleInput in

            guard let addPlaceModuleInput = moduleInput as? AddPlaceModuleInput else {
                fatalError("moduleInput is not AddPlaceModuleInput")
            }

            addPlaceModuleInput.configureWith(place: place)
        })
    }
}
