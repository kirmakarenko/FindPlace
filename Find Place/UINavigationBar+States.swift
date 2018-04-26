//
//  UINavigationBar+States.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 24.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import UIKit

extension UINavigationBar {
    func setInvisibleState() {
        barTintColor = UIColor(red: 62.0/255.0, green: 71.0/255.0, blue: 87.0/255.0, alpha: 0.0)
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
        isTranslucent = true
    }

    func setVisibleState() {
        isTranslucent = false
        barTintColor = UIColor(red: 62.0/255.0, green: 71.0/255.0, blue: 87.0/255.0, alpha: 1.0)
        tintColor = .white
    }
}
