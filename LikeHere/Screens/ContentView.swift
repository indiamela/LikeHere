//
//  ContentView.swift
//  LikeHere
//
//  Created by Taishi Kusunose on 2021/06/06.
//

import UIKit
import SwiftUI

struct ContentView: View {
//    @State var loggedIn: Bool = false
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    @AppStorage(CurrentUserDefaults.displayName) var currentDisplayName: String?
    
    
    var body: some View {
        TabView{
            NavigationView{
                HomeView(posts: PostArrayObject(shuffled: true))
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            NavigationView{
                DiscoverView()
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Browse")
            }
            
            ZStack{
                if let userID = currentUserID, let displayName = currentDisplayName {
                    NavigationView{
                        ProfileView(isMyProfile: true, profileUserID: userID, userDisplayName: displayName, posts: PostArrayObject(userID: userID))
                    }
                } else {
                    SignUpView()
                }
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
            }
        }
        .accentColor(.black)
//        .sheet(isPresented: $loggedIn, content: {
//            SignUpView()
//        })
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
