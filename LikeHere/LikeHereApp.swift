//
//  LikeHereApp.swift
//  LikeHere
//
//  Created by Taishi Kusunose on 2021/06/06.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn

@main
struct LikeHereApp: App {
    
    init(){
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
