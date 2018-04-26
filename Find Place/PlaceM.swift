//
//  PlaceM.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 08.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//

import Marshal

struct PlaceM: Unmarshaling {
    var name: String
    var latitude: Double
    var longitude: Double
    var rating: [Int]
    var minPrice: Int?
    var maxPrice: Int?
    var openHour: Int?
    var openMinute: Int?
    var closeHour: Int?
    var closeMinute: Int?
    var address: String?
    var marksNumber: Int
    var key = UUID().uuidString
    var averageRating: Double {
        get {
            var average = 0.0
            for i in 0...rating.count-1 where marksNumber != 0 {
                average += ((Double(i)/2.0)+1.0)*Double((rating[i]))/Double(marksNumber)
            }
            return average
        }
        set(newValue) {
            switch newValue {
            case 1.0:
                rating[0] += 1
            case 1.5:
                rating[1] += 1
            case 2.0:
                rating[2] += 1
            case 2.5:
                rating[3] += 1
            case 3.0:
                rating[4] += 1
            case 3.5:
                rating[5] += 1
            case 4.0:
                rating[6] += 1
            case 4.5:
                rating[7] += 1
            case 5.0:
                rating[8] += 1
            default:
                break
            }
        }
    }

    init(object: MarshaledObject) throws {
        name = try object.value(for: "name")
        latitude = try object.value(for: "latitude")
        longitude = try object.value(for: "longitude")
        rating = try object.value(for: "rating")
        minPrice = try object.value(for: "minPrice")
        maxPrice = try object.value(for: "maxPrice")
        openHour = try object.value(for: "openHour")
        openMinute = try object.value(for: "openMinute")
        closeHour = try object.value(for: "closeHour")
        closeMinute = try object.value(for: "closeMinute")
        address = try object.value(for: "address")
        marksNumber = try object.value(for: "marksNumber")
    }

    init(name: String, latitude: Double, longitude: Double, marksNumber: Int, rating: [Int]) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.marksNumber = marksNumber
        self.rating = rating
    }
}
