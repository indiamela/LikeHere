//
//  ContentView.swift
//  LikeHere
//
//  Created by Taishi Kusunose on 2021/06/06.
//

import SwiftUI

struct ContentView: View {
    var login:Bool = false
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
                Text("Hello World")
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Browse")
            }
            NavigationView{
                Text("Hello World")
            }
            .tabItem {
                Image(systemName: "square.and.arrow.up.fill")
                Text("Upload")
            }
            NavigationView{
                Text("Hello World")
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
            }
        }
        .accentColor(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
