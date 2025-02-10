//
//  User.swift
//  BeFake App
//
//  Created by Biraj Dahal on 1/30/25.
//

import Foundation
import UIKit
import ParseSwift


struct User: ParseUser{
    var originalData: Data?
    
    var objectId: String?
    
    var createdAt: Date?
    
    var updatedAt: Date?
    
    var ACL: ParseSwift.ParseACL?
    
    
    var username: String?
    var userInitials: String?
    var email: String?
    var password: String?
    var emailVerified: Bool?
    var authData: [String : [String : String]?]?
    var lastAdded: Date?
    
}
