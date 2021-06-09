//
//  CommentArrayObject.swift
//  LikeHere
//
//  Created by Taishi Kusunose on 2021/06/10.
//

import Foundation

struct CommentModel:Hashable,Identifiable{
    
    var id = UUID()
    var commentID: String // ID fro the comment in the Database
    var userID: String // ID for the user in the DB
    var username: String
    var content: String
    var dataCreated: Date
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}
