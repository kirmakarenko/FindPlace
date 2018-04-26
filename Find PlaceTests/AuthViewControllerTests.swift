//
//  AuthViewControllerTests.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 17.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import XCTest
@testable import Find_Place

class AuthViewControllerTests: XCTestCase {

    var viewController: AuthViewController!

    override func setUp() {
        super.setUp()

        viewController = AuthViewController()
    }

    override func tearDown() {
        viewController = nil

        super.tearDown()
    }

    func testThatViewControllerCallsViewReadyEvent() {
        // given
        let outputMock = AuthViewOutputMock()
        viewController.output = outputMock

        // when
        viewController.viewDidLoad()

        // then
        XCTAssertTrue(outputMock.didTriggerViewReadyEventWasCalled)
    }
}
