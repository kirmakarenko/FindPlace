//
//  AuthRouter.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 07.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import ViperKit

class AuthRouterImpl: AuthRouterInput {
    weak var transitionHandler: TransitionHandler?

    init(transitionHandler: TransitionHandler) {
        self.transitionHandler = transitionHandler
    }

    func openMapModule() {
        transitionHandler?.openModule(segueIdentifier: "showMap")
    }
}
