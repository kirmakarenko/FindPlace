//
//  FirebaseServiceImpl.swift
//  Find Place
//
//  Created by Кирилл Макаренко on 04.08.17.
//  Copyright © 2017 Kirill Makarenko. All rights reserved.
//
import Firebase
import FirebaseDatabase
import FirebaseStorage
import PromiseKit
import GoogleMaps
import Marshal

class FirebaseServiceImpl: FirebaseService {

    var ref: DatabaseReference!
    var storage: Storage!

    init() {
        ref = Database.database().reference()
        storage = Storage.storage()
    }

    func addPlace(place: PlaceM) {
        let user = Auth.auth().currentUser
        let userInfo = user?.email
        let name = place.name
        let latitude = place.latitude
        let longitude = place.longitude
        let rating = place.rating
        let value = [
                    "name": name,
                    "latitude": latitude,
                    "longitude": longitude,
                    "rating": rating,
                    "userInfo": userInfo!,
                    "minPrice": place.minPrice,
                    "maxPrice": place.maxPrice,
                    "openHour": place.openHour,
                    "openMinute": place.openMinute,
                    "closeHour": place.closeHour,
                    "closeMinute": place.closeMinute,
                    "address": place.address,
                    "marksNumber": place.marksNumber
                ] as [String : Any?]
                    self.ref.child(place.key).setValue(value)

    }

    func updateRating(place: PlaceM) {
        self.ref.child(place.key).child("rating").setValue(place.rating)
        self.ref.child(place.key).child("marksNumber").setValue(place.marksNumber)
    }

    func getPlaces() -> Promise<[PlaceM]> {
        return Promise { fulfill, reject in
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                guard let placesArrayOfDict = snapshot.value as? [String: Any] else {
                    return
                }
                var places = [PlaceM]()
                placesArrayOfDict.forEach { value in
                    guard let cityPlaces = value.value as? [String: Any] else {
                        return
                    }

                    do {
                        var placeM = try PlaceM(object: cityPlaces)
                        placeM.key = value.key
                        places.append(placeM)
                    } catch {
                        reject(error)
                    }
                }

                fulfill(places)
            }) { error in
                reject(error)
            }
        }
    }

    func uploadPhoto(data: Data, name: String) {
        DispatchQueue.global(qos: .background).async {
            let imageRef = self.storage.reference().child("images/\(name)")
            imageRef.putData(data, metadata: nil) { (_, _) in
            }
        }
    }
    func downloadPhoto(name: String) -> Promise<UIImage> {
            return Promise { fulfill, _ in
            let pathReference = storage.reference(withPath: "images/\(name)")
            var image = UIImage()
            // Download in memory with a maximum allowed size of 4MB (1 * 4096 * 4096 bytes)
            pathReference.getData(maxSize: 1 * 4096 * 4096) { data, error in
                if let _ = error {
                    // Uh-oh, an error occurred!
                    image = UIImage(named: "place placeholder")!
                    fulfill(image)
                } else {
                    // Data for "images/island.jpg" is returned
                    image = UIImage(data: data!)!
                    fulfill(image)
                }
            }
        }
    }
}
