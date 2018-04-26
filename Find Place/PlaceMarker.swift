//
//  PlaceMarker.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 17.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import GoogleMaps

class PlaceMarker: GMSMarker {

    let place: PlaceM

    init(place: PlaceM) {
        self.place = place
    }
}
