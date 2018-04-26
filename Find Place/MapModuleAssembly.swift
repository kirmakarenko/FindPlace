//
//  MapModuleAssembly.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 16.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import Dip
import Dip_UI
import ViperKit

class MapModuleAssembly: Assembly {
    init(collaborator: ServiceLayerAssembly) {
        super.init(collaborator: collaborator)

        container.register(tag: nil) { MapViewController() }
            .implements(MapViewControllerInput.self, TransitionHandler.self, MapDisplayManagerDelegate.self)
            .resolvingProperties { (container, viewController) in
                viewController.output = try container.resolve()
                viewController.displayManager = try container.resolve()
        }

        container.register { MapDisplayManager() }
            .resolvingProperties { (container, displayManager) in
                displayManager.delegate = try container.resolve()
        }

        container.register { MapPresenterImpl(view: $0, interactor: $1, router: $2) }
            .implements(MapViewControllerOutput.self, MapInteractorOutput.self, MapModuleInput.self)

        container.register { MapInteractorImpl(firebaseService: $0, locationService: $1) }
            .implements(MapInteractorInput.self)
            .resolvingProperties { (container, interactor) in
                interactor.output = try container.resolve()

        }

        container.register { MapRouterImplementation(transitionHandler: $0) as MapRouterInput }

        DependencyContainer.uiContainers += [container]

    }
}
