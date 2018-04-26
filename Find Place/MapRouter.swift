//
//  MapRouter.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 07.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import ViperKit

protocol MapRouterInput: class {
    func openPlaceModule(place: PlaceM)
    func openAddPlaceModule()
    func closeModule()
}

class MapRouterImplementation: MapRouterInput {
    weak var transitionHandler: TransitionHandler?

    init(transitionHandler: TransitionHandler) {
        self.transitionHandler = transitionHandler
    }

    func openPlaceModule(place: PlaceM) {
        transitionHandler?.openModule(segueIdentifier: "showPlace", configurationBlock: { moduleInput in
            guard let mapModuleInput = moduleInput as? PlaceModuleInput else {
                fatalError("moduleInput isn't MapModuleInput")
            }
            mapModuleInput.configure(with: place)
        })
    }

    func openAddPlaceModule() {
        transitionHandler?.openModule(segueIdentifier: "addPlace")
    }

    func closeModule() {
        transitionHandler?.closeCurrentModule()
    }
}
