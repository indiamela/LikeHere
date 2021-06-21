//
//  AuthService.swift
//  LikeHere
//
//  Created by Taishi Kusunose on 2021/06/21.
//

import Foundation
import Firebase


class AuthService{
    
    static let instance = AuthService()
    
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
        
    }
}

