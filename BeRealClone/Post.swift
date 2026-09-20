//
//  Post.swift
//  BeRealClone
//
//  Created by Krystal Lewin on 9/18/26.
//

import Foundation
import ParseSwift

struct Post: ParseObject {
    // Required by ParseObject
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
    var originalData: Data?

    // Custom Properties for BeReal
    var caption: String?
    var user: User?
    var imageFile: ParseFile?
}
