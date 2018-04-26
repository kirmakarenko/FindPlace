//
//  AuthViewController.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 07.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import GoogleSignIn
import UIKit
import ViperKit
import Dip_UI

class AuthViewController: BaseViewController, GIDSignInUIDelegate {

    var output: AuthViewControllerOutput!

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        //UIApplication.shared.statusBarStyle = .lightContent
        GIDSignIn.sharedInstance().uiDelegate = self

        output.didTriggerViewReadyEvent()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.setInvisibleState()
    }

    // MARK: IBActions

    @IBAction func signIn(_ sender: GIDSignInButton) {
        GIDSignIn.sharedInstance().signIn()
    }
}

extension AuthViewController: StoryboardInstantiatable {}
