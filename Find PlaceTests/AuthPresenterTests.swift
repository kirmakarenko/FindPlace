//
//  AuthPresenterTests.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 17.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import XCTest
@testable import Find_Place

class AuthPresenterTests: XCTestCase {

    var presenter: AuthPresenterImpl!
    var routerMock: AuthRouterInputMock!
    var interactorMock: AuthInteractorInputMock!

    override func setUp() {
        super.setUp()

        routerMock = AuthRouterInputMock()
        interactorMock = AuthInteractorInputMock()

        presenter = AuthPresenterImpl(interactor: interactorMock, router: routerMock)
    }

    override func tearDown() {
        routerMock = nil
        interactorMock = nil

        presenter = nil

        super.tearDown()
    }

    // MARK: AuthViewOutput

    func testThatPresenterCallsInteractorOnViewReadyEvent() {
        // given

        // when
        presenter.didTriggerViewReadyEvent()

        // then
        XCTAssertTrue(interactorMock.checkAuthorizationStatusWasCalled)
    }

    // MARK: AuthInteractorOutput

    func testThatPresenterCallsRouterOpenMapMethodWhenInteractorCheckedAuthStatus() {
        // given
        let authStatus = AuthorizationStatus.authorized

        // when
        presenter.didCheckAuth(status: authStatus)

        // then
        XCTAssertTrue(routerMock.openMapModuleWasCalled)
    }
}
