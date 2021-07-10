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
    
    static let displayName = "display_name"
    static let userID = "user_id"
    static let address = "address"
    static let tag = "tag"
    static let caption = "caption"
    static let dataCreated = "data_created"
    static let postID = "post_id"
    static let likeCount = "like_count"
    static let goneCount = "gone_count"
    static let likeByUser = "liked_by"
    static let goneByUser = "gone_by"
}

struct CurrentUserDefaults {
    static let userID = "user_id"
    static let displayName = "display_name"
    static let displayAddress = "display_address"
}

enum tagName {
    case browseAll
    case relux
    case love
    case interesting
    case freedom
    case peaceful
    case joyful
}

extension tagName {
    
    var label: String {
        switch self {
        case .browseAll:
            return ""
        case .relux:
            return "Relux"
        case .love:
            return "Love"
        case .interesting:
            return "Interesting"
        case .freedom:
            return "Freedom"
        case .peaceful:
            return "Peaceful"
        case .joyful:
            return "Joyful"
        }
    }
}


