//
//  AuthViewOutputMock.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 17.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

@testable import Find_Place

class AuthViewOutputMock: AuthViewControllerOutput {

    var didTriggerViewReadyEventWasCalled = false

    func didTriggerViewReadyEvent() {
        didTriggerViewReadyEventWasCalled = true
    }
}
