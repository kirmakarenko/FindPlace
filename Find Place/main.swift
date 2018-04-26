//
//  main.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 16.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import UIKit

let isRunningTests = ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil

if isRunningTests {
    UIApplicationMain(
        CommandLine.argc,
        UnsafeMutableRawPointer(CommandLine.unsafeArgv)
            .bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc)),
        nil,
        nil
    )
} else {
    UIApplicationMain(
        CommandLine.argc,
        UnsafeMutableRawPointer(CommandLine.unsafeArgv)
            .bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc)),
        NSStringFromClass(ApplicationInitializer.self),
        NSStringFromClass(AppDelegate.self)
    )
}
