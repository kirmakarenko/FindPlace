//
//  AuthInteractor.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 17.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import FirebaseAuth

class AuthInteractor: AuthInteractorInput {

    weak var output: AuthInteractorOutput?

    func checkAuthorizationStatus() {
        Auth.auth().addStateDidChangeListener { (_, user) in
            if user != nil {
                self.output?.didCheckAuth(status: .authorized)
                return
            }

            self.output?.didCheckAuth(status: .notAuthorized)
        }
    }
}
