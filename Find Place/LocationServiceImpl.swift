//
//  LocationServiceImpl.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 17.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import PromiseKit

class LocationServiceImpl: LocationService {

    func obtainCurrentLocation() -> Promise<CLLocation> {
        return CLLocationManager.promise()
    }
}
