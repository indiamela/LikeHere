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
    
    func downloadComment(postID: String, handler: @escaping(_ comments: [CommentModel]) -> ()){
        REF_POSTS.whereField(DatabasePostField.postID, isEqualTo: postID).getDocuments { (querySnapshot, error) in
            handler(self.getCommentsFromSnapshot(querrySnapshot: querySnapshot))
        }
    }
    
    private func getCommentsFromSnapshot(querrySnapshot: QuerySnapshot?) -> [CommentModel] {
        var commentArray = [CommentModel]()
        if let snapshot = querrySnapshot,snapshot.documents.count > 0 {
            for document in snapshot.documents {
                if let userID = document.get(DatabaseCommentField.userID) as? String,
                   let displayName = document.get(DatabaseCommentField.displayName) as? String,
                   let comment = document.get(DatabaseCommentField.comment) as? String,
                   let timeStamp = document.get(DatabaseCommentField.dataCreated) as? Timestamp{
                    let date = timeStamp.dateValue()
                    let commentID = document.documentID
                    let newComment = CommentModel(commentID: commentID, userID: userID, username: displayName, content: comment, dataCreated: date)
                    commentArray.append(newComment)
                }
            }
            return commentArray
        } else {
            print("No comments is document for this post")
            return commentArray
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
                    let tag = document.get(DatabasePostField.tag) as? Int ?? 0
                    let address = document.get(DatabasePostField.address) as? String
                    
                    let likeCount = document.get(DatabasePostField.likeCount) as? Int ?? 0
                    let goneCount = document.get(DatabasePostField.goneCount) as? Int ?? 0

                    var likeByUser: Bool = false
                    var goneByUser: Bool = false
                    if let likeUserIDArray = document.get(DatabasePostField.likeByUser) as? [String], let userID = currentUserID {
                        likeByUser = likeUserIDArray.contains(userID)
                    }
                    if let goneUserIDArray = document.get(DatabasePostField.goneByUser) as? [String], let userID = currentUserID {
                        goneByUser = goneUserIDArray.contains(userID)
                    }
                    
                    let newPost = PostModel(tag: tag, postID: postID, userID: userID, username: displayName, caption: caption, address: address, dateCreated: date, likeCount: likeCount, goneCount: goneCount, likeByUser: likeByUser, goneByUser: goneByUser)
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
    
    func uploadComment(userID: String, postID: String, userName: String,comment: String, handler: @escaping(_ success: Bool, _ commentID: String?) -> ()) {
        let document = REF_POSTS.document(postID).collection(DatabasePostField.comments).document()
        let commentID = document.documentID
        
        let postData:[String:Any] = [
            DatabaseCommentField.commentID : commentID,
            DatabaseCommentField.comment : comment,
            DatabaseCommentField.userID : userID,
            DatabaseCommentField.displayName : userName,
            DatabaseCommentField.dataCreated : FieldValue.serverTimestamp()
        ]
        document.setData(postData){(error) in
            if let error = error {
                print("Error post Data\(error)")
                handler(false, nil)
                return
            } else {
                print("Success post Data")
                handler(true, commentID)
                return
            }
        }
    }
    
    func likePost(postID: String, currentUserID: String) {
        let increment: Int64 = 1
        let data: [String:Any] = [
            DatabasePostField.likeCount : FieldValue.increment(increment),
            DatabasePostField.likeByUser : FieldValue.arrayUnion([currentUserID])
        ]
        REF_POSTS.document(postID).updateData(data)
    }
    
    func unlikePost(postID: String, currentUserID: String) {
        let increment: Int64 = -1
        let data: [String:Any] = [
            DatabasePostField.likeCount : FieldValue.increment(increment),
            DatabasePostField.likeByUser : FieldValue.arrayRemove([currentUserID])
        ]
        REF_POSTS.document(postID).updateData(data)
    }
    
    func gonePost(postID: String, currentUserID: String) {
        let increment: Int64 = 1
        let data: [String:Any] = [
            DatabasePostField.goneCount : FieldValue.increment(increment),
            DatabasePostField.goneByUser : FieldValue.arrayUnion([currentUserID])
        ]
        REF_POSTS.document(postID).updateData(data)
    }
    
    func notGonePost(postID: String, currentUserID: String) {
        let increment: Int64 = -1
        let data: [String:Any] = [
            DatabasePostField.goneCount : FieldValue.increment(increment),
            DatabasePostField.goneByUser : FieldValue.arrayRemove([currentUserID])
        ]
        REF_POSTS.document(postID).updateData(data)
    }

}
