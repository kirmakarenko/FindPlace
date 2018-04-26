//
//  AddPlaceModuleAssebly.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 16.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//
import Dip
import ViperKit

class AddPlaceModuleAssembly: Assembly {

    init(collaborator: ServiceLayerAssembly) {
        super.init(collaborator: collaborator)

        container.register(tag: nil) { AddPlaceViewController() }
            .implements(AddPlaceViewControllerInput.self, TransitionHandler.self)
            .resolvingProperties { (container, addPlaceViewController) in
                addPlaceViewController.output = try container.resolve()
        }

        container.register { AddPlacePresenterImpl(view: $0, interactor: $1, router: $2) }
            .implements(AddPlaceModuleInput.self, AddPlaceViewControllerOutput.self, AddPlaceInteractorOutput.self)

        container.register { AddPlaceRouterImpl(transitionHandler: $0) as AddPlaceRouterInput}

        container.register { AddPlaceInteractorImpl(firebaseService: $0, locationService: $1) }
            .implements(AddPlaceInteractorInput.self)
            .resolvingProperties { (container, interactor) in
                interactor.moduleOutput = try container.resolve()
        }

        DependencyContainer.uiContainers += [container]
    }
}
