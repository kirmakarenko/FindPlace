//
//  AuthModuleAssembly.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 16.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import Dip
import ViperKit

class AuthModuleAssembly: Assembly {

    init(collaborator: ServiceLayerAssembly) {
        super.init(collaborator: collaborator)

        container.register(tag: nil) { AuthViewController() }
            .implements(AuthViewControllerInput.self, TransitionHandler.self)
            .resolvingProperties { (container, viewController) in
                viewController.output = try container.resolve()
            }

        container.register { AuthPresenterImpl(interactor: $0, router: $1) }
            .implements(AuthViewControllerOutput.self, AuthInteractorOutput.self)

        container.register { AuthInteractor() }
            .implements(AuthInteractorInput.self)
            .resolvingProperties { (container, interactor) in
                interactor.output = try container.resolve()
        }

        container.register { AuthRouterImpl(transitionHandler: $0) as AuthRouterInput }

        DependencyContainer.uiContainers += [container]
    }
}
