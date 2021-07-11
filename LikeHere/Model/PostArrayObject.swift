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
        fetchPostsForUser(userID: userID)
    }
    
    init(shuffled: Bool) {
        print("GET POSTS FOR FEED. SHUFFLED: \(shuffled)")
        fetchPostsForFeed(shuffled: shuffled)
    }
    
    func filterWithTag(tagID: Int) {
        print("GET POSTS FOR TAGID")
        DataService.instance.downloadPostForTagID(tagID: tagID) { (returnedPosts) in
            if tagID == 0 {
                self.dataArray = []
                self.fetchPostsForFeed(shuffled: false)
                return
            }
            
            if returnedPosts.count > 0{
                let sortedPosts = returnedPosts.sorted{(post1,post2)->Bool in
                    return post1.dateCreated > post2.dateCreated
                }
                self.dataArray = sortedPosts
            } else {
                self.dataArray = []
            }
        }
    }
    
    func fetchPostsForUser(userID: String) {
        print("FETCH POSTS")
        DataService.instance.downloadPostForUser(userID: userID){ (returnedPosts) in
            let sortedPosts = returnedPosts.sorted{(post1,post2)->Bool in
                return post1.dateCreated > post2.dateCreated
            }
            self.dataArray = sortedPosts
        }
    }
    
    func fetchPostsForFeed(shuffled: Bool) {
        print("FETCH POSTS")
        self.dataArray = []
        DataService.instance.downloadPostForFeed { (returnedPosts) in
            if shuffled {
                self.dataArray = returnedPosts.shuffled()
            } else {
                self.dataArray = returnedPosts
            }
        }
    }
    
    init(tagID: Int) {
        print("GET POSTS FOR TAGID")
        DataService.instance.downloadPostForTagID(tagID: tagID) { (returnedPosts) in
            let sortedPosts = returnedPosts.sorted{(post1,post2)->Bool in
                return post1.dateCreated > post2.dateCreated
            }
            self.dataArray.append(contentsOf: sortedPosts)
        }
    }
}
