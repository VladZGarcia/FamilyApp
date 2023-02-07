//
//  Place.swift
//  FamilyApp
//
//  Created by Hugo Garcia on 2023-01-30.
//

import Foundation
import CoreLocation
import FirebaseFirestoreSwift

struct Place : Codable, Identifiable{
    @DocumentID var id : String?
    var name : String
    var latitude : Double
    var longitude : Double
    
    var coordinate : CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
