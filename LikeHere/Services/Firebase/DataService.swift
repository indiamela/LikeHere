//
//  DataService.swift
//  LikeHere
//
//  Created by Taishi Kusunose on 2021/06/29.
//

import Foundation
import SwiftUI
import FirebaseFirestore

class DataService {
    
    static let instance = DataService()
    let REF_POSTS = DB_BASE.collection("posts")
    
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    
    func downloadPostForFeed(handler:@escaping(_ posts:[PostModel])->()) {
        REF_POSTS.order(by: DatabasePostField.dataCreated,descending: true).limit(to: 50).getDocuments { (QuerrySnapshot, error) in
            handler(self.getPostsFromSnapshot(querySnapshot: QuerrySnapshot))
        }
    }
    
    func downloadPostForUser(userID: String, handler: @escaping(_ posts:[PostModel]) -> ()){
        REF_POSTS.whereField(DatabasePostField.userID, isEqualTo: userID).getDocuments { (querySnapshot, error) in
            handler(self.getPostsFromSnapshot(querySnapshot: querySnapshot))
        }
    }
    
    private func getPostsFromSnapshot(querySnapshot: QuerySnapshot?) -> [PostModel]{
        var postArray = [PostModel]()
        if let snapshot = querySnapshot,snapshot.documents.count > 0{
            
            for document in snapshot.documents {
                let postID = document.documentID
                if let userID = document.get(DatabasePostField.userID) as? String, let displayName = document.get(DatabasePostField.displayName) as? String, let timeStamp = document.get(DatabasePostField.dataCreated) as? Timestamp {
                    let caption = document.get(DatabasePostField.caption) as? String
                    let date = timeStamp.dateValue()
                    let tag = document.get(DatabasePostField.tag) as? String ?? "0"
                    
                    let likeCount = document.get(DatabasePostField.likeCount) as? String ?? "0"
                    let goneCount = document.get(DatabasePostField.goneCount) as? String ?? "0"
                    
                    var likeByUser: Bool = false
                    var goneByUser: Bool = false
                    if let likeUserIDArray = document.get(DatabasePostField.likeByUser) as? [String], let userID = currentUserID {
                        likeByUser = likeUserIDArray.contains(userID)
                    }
                    if let goneUserIDArray = document.get(DatabasePostField.goneByUser) as? [String], let userID = currentUserID {
                        goneByUser = goneUserIDArray.contains(userID)
                    }
                    
                    let newPost = PostModel(tag: tag, postID: postID, userID: userID, username: displayName,caption: caption, dateCreated: date, likeCount: likeCount, goneCount:goneCount, likeByUser: likeByUser, goneByUser: goneByUser)
                    postArray.append(newPost)
                }
            }
            return postArray
        } else {
            print("No documents in snapshot founct for this user")
            return postArray
        }
    }
    
    
    func uploadPost(image: UIImage, address: String?, tag: Int, caption: String?, displayName: String, userID: String, handler: @escaping(_ success: Bool) -> ()) {
        let document = REF_POSTS.document()
        let postID = document.documentID
        
        ImageManager.instance.uploadPostImage(postID: postID, image: image) { (success) in
            
            if success {
                
                let postData: [String:Any] = [
                    DatabasePostField.displayName: displayName,
                    DatabasePostField.postID: postID,
                    DatabasePostField.userID: userID,
                    DatabasePostField.address: address ?? "",
                    DatabasePostField.tag: tag,
                    DatabasePostField.caption: caption ?? "",
                    DatabasePostField.dataCreated: FieldValue.serverTimestamp()
                ]
                
                document.setData(postData) {(error) in
                    if let error = error {
                        print("Error post Data\(error)")
                        handler(false)
                        return
                    } else {
                        print("Success post Data")
                        handler(true)
                        return
                    }
                }
            } else {
                print("Error uploading image")
                handler(false)
                return
            }
        }
    }
}
