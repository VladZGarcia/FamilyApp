//
//  Users.swift
//  FamilyApp
//
//  Created by Hugo Garcia on 2023-02-10.
//

import Foundation
import CoreLocation
import FirebaseFirestoreSwift
import SwiftUI

struct Users : Codable, Identifiable{
    @DocumentID var id : String?
    var name : String = ""
    var email: String = ""
    var userIDinFG: String = ""
    var groupCode : String = ""
    var latitude : Double
    var longitude : Double
    
    var coordinate : CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
