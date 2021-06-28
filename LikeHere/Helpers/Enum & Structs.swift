//
//  Enum & Structs.swift
//  LikeHere
//
//  Created by Taishi Kusunose on 2021/06/23.
//

import Foundation

struct DatabaseUserField { //Fields within the User Document in Database
    
    static let displayName = "display_name"
    static let email = "email"
    static let providerID = "provider_id"
    static let provider = "provider"
    static let userID = "user_id"
    static let displayAddress = "display_address"
    static let dataCreated = "data_created"
    
}

struct DatabasePostField { //Fields within the User Document in Database
    
    static let name = "display_name"
    static let userID = "user_id"
    static let address = "display_address"
    static let tag = "tag"
    static let caption = "caption"
    static let dataCreated = "data_created"
    static let postID = "post_id"
}


struct CurrentUserDefaults {
    static let userID = "user_id"
    static let displayName = "display_name"
    static let displayAddress = "display_address"
}
