//
//  Assembly.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 16.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import Dip

class Assembly {
    let container = DependencyContainer()

    init() {}

    init(collaborator: Assembly) {
        container.collaborate(with: collaborator.container)
    }

    func resolve<T>(tag: String? = nil) -> T {
        do {
            return try container.resolve(tag: tag) as T
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func bootstrap() {
        do {
            try container.bootstrap()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
