//
//  ContentView.swift
//  LikeHere
//
//  Created by Taishi Kusunose on 2021/06/06.
//

import UIKit
import SwiftUI

struct ContentView: View {
    var login:Bool = false

    @State var checkIn: Bool = false
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    @AppStorage(CurrentUserDefaults.displayName) var currentDisplayName: String?
    
    
    var body: some View {
        TabView{
            NavigationView{
                HomeView(posts: PostArrayObject())
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
                        ProfileView(isMyProfile: true, userID: userID, userDisplayName: displayName)
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
        .sheet(isPresented: $checkIn, content: {
            SignUpView()
        })
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
