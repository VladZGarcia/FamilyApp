//
//  FamilyGroupCode.swift
//  FamilyApp
//
//  Created by Hugo Garcia on 2023-02-10.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift


struct FamilyGroupCode: Codable, Identifiable {
    @DocumentID var  id : String?
    var  groupCode : String
}

class GroupCodes : ObservableObject {
    @Published var groupCodes = [FamilyGroupCode]()
}
