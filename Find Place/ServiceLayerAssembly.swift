//
//  ServiceLayerAssembly.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 16.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

class ServiceLayerAssembly: Assembly {

    override init(collaborator: Assembly) {
      super.init(collaborator: collaborator)

        container.register(.eagerSingleton) { FirebaseServiceImpl() as FirebaseService }
        container.register(.eagerSingleton) { LocationServiceImpl() as LocationService }
    }
}
