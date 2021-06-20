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
    
    
    var body: some View {
        ZStack(alignment:.trailing){
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
                    if checkIn {
                        NavigationView{
                            ProfileView()
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
        }
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
