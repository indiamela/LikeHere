//
//  SignWithGoogle.swift
//  DogGram
//
//  Created by Taishi Kusunose on 2021/05/29.
//

import Foundation
import SwiftUI
import GoogleSignIn
import FirebaseAuth

class SignInWithGoogle: NSObject, GIDSignInDelegate{
    
    static let instance = SignInWithGoogle()
    var signUpView:SignUpView!

    func startSignInGoogleFlow(view:SignUpView){
        self.signUpView = view
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
        GIDSignIn.sharedInstance()?.presentingViewController.modalPresentationStyle = .fullScreen
        GIDSignIn.sharedInstance().signIn()
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if error != nil {
            print("ERROR SIGNING IN TO GOOGLE")
            self.signUpView.showError.toggle()
            return
        }
        
        let fullName: String = user.profile.name
        let email: String = user.profile.email
        
        let idToken: String = user.authentication.idToken
        let accessToken: String = user.authentication.accessToken
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        self.signUpView.connectToFirebase(name: fullName, email: email, provider: "Google", credential: credential)
        
        // ...
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
        print("USER DISCONNECTED FROM GOOGLE")
        self.signUpView.showError.toggle()
    }
    
}


