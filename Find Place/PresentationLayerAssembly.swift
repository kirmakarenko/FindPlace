//
//  PresentationLayerAssembly.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 16.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

class PresentationLayerAssembly: Assembly {

    override init(collaborator: Assembly) {
        super.init(collaborator: collaborator)

        container.register(.eagerSingleton) { AuthModuleAssembly(collaborator: $0) }
        container.register(.eagerSingleton) { MapModuleAssembly(collaborator: $0) }
        container.register(.eagerSingleton) { AddPlaceModuleAssembly(collaborator: $0) }
        container.register(.eagerSingleton) { PlaceModuleAssembly(collaborator: $0) }

        bootstrap()
    }
}
