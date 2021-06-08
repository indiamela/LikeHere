//
//  PostArrayObject.swift
//  LikeHere
//
//  Created by Taishi Kusunose on 2021/06/09.
//

import Foundation
import SwiftUI

struct PostModel:Hashable,Identifiable{
    var id = UUID()
    var tag: String
    var postID: String //ID for the post in Databese
    var userID: String //ID for the post in Databese
    var username: String
    var caption: String?
    var address: String?
    var dateCreated: Date
    var wantCount: Int
    var goneCount: Int
    var wantByUser: Bool
    var goneByUser: Bool
    
    func hash(into hasher: inout Hasher){
        hasher.combine(id)
    }
    
    // podtID
    // userID
    // user username
    // caption - optional
    // date
    // like count
    // like by current user
}

