//
//  PostArrayObject.swift
//  LikeHere
//
//  Created by Taishi Kusunose on 2021/06/09.
//

import Foundation

class PostArrayObject:ObservableObject{
    @Published var dataArray = [PostModel]()
    
    
    init(userID: String) {
        print("GET POSTS FOR USER ID: \(userID)")
        DataService.instance.downloadPostForUser(userID: userID){ (returnedPosts) in
            let sortedPosts = returnedPosts.sorted{(post1,post2)->Bool in
                return post1.dateCreated > post2.dateCreated
            }
            self.dataArray.append(contentsOf: sortedPosts)
        }
    }
    
    init(shuffled: Bool) {
        print("GET POSTS FOR FEED. SHUFFLED: \(shuffled)")
        DataService.instance.downloadPostForFeed { (returnedPosts) in
            if shuffled {
                self.dataArray.append(contentsOf: returnedPosts.shuffled())
            } else {
                self.dataArray.append(contentsOf: returnedPosts)
            }
        }
    }
}
