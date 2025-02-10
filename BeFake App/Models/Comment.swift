//
//  Comment.swift
//  BeFake App
//
//  Created by Biraj Dahal on 2/9/25.
//

import Foundation
import ParseSwift

struct Comment: ParseObject {
    var originalData: Data?
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseSwift.ParseACL?
    
    var post: Post?
    var user: User?
    var content: String? 
}
