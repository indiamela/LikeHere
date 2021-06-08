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
        let post1 = PostModel(tag: "", postID: "", userID: "", username: "taishiKusunose", caption: "小さなお子様連れの旅行では、持ち物がたくさんあるのでつい忘れてしまう物も出てきます。", dateCreated: Date(), wantCount: 5, goneCount: 2, wantByUser: true, goneByUser: true)
        let post2 = PostModel(tag: "", postID: "", userID: "", username: "JoeGreen", caption: "小さなお子様連れの旅行では、持ち物がたくさんあるのでつい忘れてしまう物も出てきます。", dateCreated: Date(), wantCount: 5, goneCount: 2, wantByUser: true, goneByUser: true)
        let post3 = PostModel(tag: "", postID: "", userID: "", username: "JohnLenonn", caption: "小さなお子様連れの旅行では、持ち物がたくさんあるのでつい忘れてしまう物も出てきます。", dateCreated: Date(), wantCount: 5, goneCount: 2, wantByUser: true, goneByUser: true)
        dataArray.append(post1)
        dataArray.append(post2)
        dataArray.append(post3)
    }
}
