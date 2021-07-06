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
