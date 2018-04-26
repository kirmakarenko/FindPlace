//
//  AuthPresenter.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 07.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

class AuthPresenterImpl {
    fileprivate var interactor: AuthInteractorInput
    fileprivate var router: AuthRouterInput

    init(interactor: AuthInteractorInput, router: AuthRouterInput) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: AuthViewControllerOutput

extension AuthPresenterImpl: AuthViewControllerOutput {

    func didTriggerViewReadyEvent() {
        interactor.checkAuthorizationStatus()
    }
}

// MARK: AuthInteractorOutput

extension AuthPresenterImpl: AuthInteractorOutput {

    func didCheckAuth(status: AuthorizationStatus) {
        if status == .authorized {
            router.openMapModule()
        }
    }
}
