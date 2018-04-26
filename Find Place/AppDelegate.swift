//
//  AppDelegate.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 01.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps
import Firebase
import Firebase
import GoogleSignIn

class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyDj5Kvf3zZDeGuhPEbZodacY5X0HwHkAOg")
        GMSPlacesClient.provideAPIKey("AIzaSyDj5Kvf3zZDeGuhPEbZodacY5X0HwHkAOg")
        FirebaseApp.configure()

        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self

        return true
    }

    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        guard let sourceApplication = options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String else {
            return false
        }

        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication:sourceApplication,
                                                 annotation: [:])
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url, sourceApplication: sourceApplication, annotation: annotation)
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if user != nil {
        if let authentication = user.authentication {
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)

            Auth.auth().signIn(with: credential) { (_, _) in
            }
        }
        }
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
}
