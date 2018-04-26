//
//  PlaceModuleAssembly.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 16.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import Dip
import Dip_UI
import ViperKit

class PlaceModuleAssembly: Assembly {

    init(collaborator: ServiceLayerAssembly) {
        super.init(collaborator: collaborator)

        container.register(tag: nil) { PlaceViewController() }
            .implements(PlaceViewControllerInput.self, TransitionHandler.self)
            .resolvingProperties { (container, placeViewController) in
                placeViewController.output = try container.resolve()
        }

        container.register { PlacePresenterImpl(view: $0, router: $1, interactor: $2) }
            .implements(PlaceViewControllerOutput.self, PlaceInteractorOutput.self, PlaceModuleInput.self)

        container.register { PlaceRouterImpl(transitionHandler: $0) as PlaceRouter}

        container.register { PlaceInteractorImpl(firebaseService: $0) }
            .implements( PlaceInteractorInput.self)
            .resolvingProperties { (container, interacor) in
                interacor.output = try container.resolve()
        }

        DependencyContainer.uiContainers += [container]
    }
}
