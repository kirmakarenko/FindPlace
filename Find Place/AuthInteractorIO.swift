//
//  AuthInteractorIO.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 17.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

enum AuthorizationStatus {
    case authorized
    case notAuthorized
}

protocol AuthInteractorInput {

    func checkAuthorizationStatus()
}

protocol AuthInteractorOutput: class {

    func didCheckAuth(status: AuthorizationStatus)
}
