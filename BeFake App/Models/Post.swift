//
//  Post.swift
//  BeFake App
//
//  Created by Biraj Dahal on 1/30/25.
//

import Foundation
import ParseSwift
import CoreLocation


struct Post: ParseObject{
    var originalData: Data?
    
    var objectId: String?
    
    var createdAt: Date?
    
    var updatedAt: Date?
    
    var ACL: ParseSwift.ParseACL?
    
    var user: User?
    var caption: String?
    var image: ParseFile?
    var numHours: Int?
    var location: String?
    var locationCoordinates: ParseGeoPoint?
    var comments: [Comment]?
    
}
