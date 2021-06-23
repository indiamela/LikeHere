//
//  AuthService.swift
//  LikeHere
//
//  Created by Taishi Kusunose on 2021/06/21.
//

import Foundation
import Firebase
import FirebaseFirestore

let DB_BASE = Firestore.firestore()

class AuthService{
    
    static let instance = AuthService()
    
    private var REF_USERS = DB_BASE.collection("users")  // usersコレクション
    
    func logInUserToFirebase(credential: AuthCredential,handler: @escaping(_ providerID: String?, _ isError: Bool) -> ()){
        
        Auth.auth().signIn(with: credential) { (result, error) in
            // check error
            if error != nil {
                print("Error logging in to Firebase")
                handler(nil,true)
                return
            }
            
            guard let providerID = result?.user.uid else {
                print("Error getting provider ID")
                handler(nil,true)
                return
            }
            
            //success
            handler(providerID, false)
        }
    }
    
    func createNewUserInDatabase(name: String, email: String, provider: String, providerID: String, profileImage: UIImage, handler: @escaping (_ userID: String?)->()) {
        
        // set up a user Document
        let document = REF_USERS.document()
        let userID = document.documentID
        
        // Upload profileImage
        ImageManager.instance.uploadProfileImage(userID: userID, image: profileImage)
        
        // Upload profile data
        let userData: [String: Any] = [
            DatabaseUserField.displayName: name,
            DatabaseUserField.email : email,
            DatabaseUserField.providerID : providerID,
            DatabaseUserField.provider : provider,
            DatabaseUserField.userID : userID,
            DatabaseUserField.bio : "",
            DatabaseUserField.dataCreated : FieldValue.serverTimestamp()
        ]
        
        document.setData(userData) {(error) in
            //error
            if let error = error {
                print("Error uploading data to user document. \(error)")
                handler(nil)
            } else {
                //success
                handler(userID)
            }
        }
    }
}

