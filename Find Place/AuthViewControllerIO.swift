//
//  AuthViewControllerIO.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 07.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

protocol AuthViewControllerInput {
}

protocol AuthViewControllerOutput {

    /// Tells presenter that viewReady event was triggered
    func didTriggerViewReadyEvent()
}
