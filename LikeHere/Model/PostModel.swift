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
    var tag: Int
    var postID: String //ID for the post in Databese
    var userID: String //ID for the post in Databese
    var username: String
    var caption: String?
    var address: String?
    var dateCreated: Date
    var likeCount: Int
    var goneCount: Int
    var likeByUser: Bool
    var goneByUser: Bool
    
    func hash(into hasher: inout Hasher){
        hasher.combine(id)
    }
    
    func tagName() -> String{
        switch tag {
        case 0:
          return ""
        case 1:
          return "Relux"
        case 2:
            return "Love"
        case 3:
            return "Intersting"
        case 4:
            return "Freedom"
        case 5:
            return "Peaceful"
        case 6:
            return "Joyful"
        default:
            return ""
        }
    }
}

