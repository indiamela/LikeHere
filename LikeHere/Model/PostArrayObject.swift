//
//  PostArrayObject.swift
//  LikeHere
//
//  Created by Taishi Kusunose on 2021/06/09.
//

import Foundation

class PostArrayObject:ObservableObject{
    @Published var dataArray = [PostModel]()
    
    func tagName(_ index:Int) -> String{
        switch index {
        case 0:
          return "BROWSE ALL"
        case 1:
          return "Reluxing"
        case 2:
            return "Loving"
        case 3:
            return "Intersting"
        case 4:
            return "Freedom"
        case 5:
            return "Peaceful"
        case 6:
            return "Jouful"
        default:
            return "BROWSE ALL"
        }
    }
    
    init(userID: String) {
        print("GET POSTS FOR USER ID: \(userID)")
        DataService.instance
    }
    
}
