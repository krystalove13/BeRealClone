//
//  User.swift
//  BeRealClone
//
//  Created by Krystal Lewin on 9/18/26.
//

import Foundation
import ParseSwift

struct User: ParseUser {
    // Required by ParseObject / ParseUser
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
    var originalData: Data?

    // Required by ParseUser
    var username: String?
    var email: String?
    var emailVerified: Bool?
    var password: String?
    var authData: [String: [String: String]?]?
}
