//
//  AddDisplayManagerDataSource.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 18.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import UIKit
import DTTableViewManager
import DTModelStorage

class AddDisplayManagerDataSource: UIViewController, DTTableViewManageable {

    var tableView: UITableView!

    func configureWith(tableView: UITableView) {
        self.tableView = tableView
        manager.startManaging(withDelegate: self)
    }
}
