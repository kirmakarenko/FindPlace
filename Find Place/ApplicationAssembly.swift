//
//  ApplicationAssembly.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 16.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import Dip

class ApplicationAssembly: Assembly {

    override init() {
        super.init()

        container.register(.eagerSingleton) { ServiceLayerAssembly(collaborator: self) }
        container.register(.eagerSingleton) { PresentationLayerAssembly(collaborator: self) }

        bootstrap()
    }
}
