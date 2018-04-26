//
//  AuthInteractorInputMock.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 17.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

@testable import Find_Place

class AuthInteractorInputMock: AuthInteractorInput {

    var checkAuthorizationStatusWasCalled = false

    func checkAuthorizationStatus() {
        checkAuthorizationStatusWasCalled = true
    }
}
