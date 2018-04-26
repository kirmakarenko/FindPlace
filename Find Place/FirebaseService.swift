//
//  FirebaseService.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 04.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import PromiseKit

protocol FirebaseService {
    func addPlace(place: PlaceM)
    func getPlaces() -> Promise<[PlaceM]>
    func uploadPhoto(data: Data, name: String)
    func downloadPhoto(name: String) -> Promise<UIImage>
    func updateRating(place: PlaceM)
}
