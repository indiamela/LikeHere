//
//  PostArrayObject.swift
//  LikeHere
//
//  Created by Taishi Kusunose on 2021/06/09.
//

import Foundation

class PostArrayObject:ObservableObject{
    @Published var dataArray = [PostModel]()
    
    init(){
        print("FETCH FROM DATABASE")
        let post1 = PostModel(tag: "1", postID: "", userID: "", username: "taishiKusunose", caption: "小さなお子様連れの旅行では、持ち物がたくさんあるのでつい忘れてしまう物も出てきます。", dateCreated: Date(), likeCount: 5, goneCount: 2, likeByUser: true, goneByUser: true)
        let post2 = PostModel(tag: "2", postID: "", userID: "", username: "JoeGreen", caption: "小さなお子様連れの旅行では、持ち物がたくさんあるのでつい忘れてしまう物も出てきます。", dateCreated: Date(), likeCount: 5, goneCount: 2, likeByUser: true, goneByUser: true)
        let post3 = PostModel(tag: "3", postID: "", userID: "", username: "JohnLenonn", caption: "小さなお子様連れの旅行では、持ち物がたくさんあるのでつい忘れてしまう物も出てきます。", dateCreated: Date(), likeCount: 5, goneCount: 2, likeByUser: true, goneByUser: true)
        dataArray.append(post1)
        dataArray.append(post2)
        dataArray.append(post3)
    }
    
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
        print("FETCH FROM DATABASE")
        
    }
    
}
