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
            handler(providerID, false)
        }
    }
    
    func logInUserToApp(userID:String, handler: @escaping(_ success: Bool) -> ()) {
        // Get the user info
        getUserInfo(userID: userID) { (returnedName, retrunedBio) in
            if let name = returnedName, let bio = retrunedBio {
                print("success")
                handler(true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    // Set to the user defaults
                    UserDefaults.standard.setValue(userID, forKey: CurrentUserDefaults.userID)
                    UserDefaults.standard.setValue(name, forKey: CurrentUserDefaults.displayName)
                    UserDefaults.standard.setValue(bio, forKey: CurrentUserDefaults.bio)
                }
            } else {
                print("error")
                handler(false)
            }
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
            DatabaseUserField.displayAddress : "",
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
    
    func getUserInfo(userID: String, handler: @escaping(_ name:String?, _ bio: String?)->()){
        REF_USERS.document(userID).getDocument { (documentSnapshot, error) in
            if let document = documentSnapshot,
               let name = document.get(DatabaseUserField.displayName) as? String,
               let bio = document.get(DatabaseUserField.displayAddress) as? String{
                print("success getting user info")
                handler(name,bio)
                return
            } else {
                print("error getting user info")
                handler(nil,nil)
                return
            }
        }
    }
    
    func logOutUser(handler: @escaping(_ success: Bool) -> ()){
        do {
            try Auth.auth().signOut()
        } catch {
            print("error\(error)")
            handler(false)
        }
        handler(true)
    }
}

