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
    
    func uploadPost(image: UIImage, address: String?, tag: Int, caption: String?, displayName: String, userID: String, handler: @escaping(_ success: Bool) -> ()) {
        let document = REF_POSTS.document()
        let postID = document.documentID
        
        ImageManager.instance.uploadPostImage(postID: postID, image: image) { (success) in
            
            if success {
                
                let postData: [String:Any] = [
                    DatabasePostField.name: displayName,
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
