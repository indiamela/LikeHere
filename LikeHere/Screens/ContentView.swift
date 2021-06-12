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
    @State var showAlert: Bool = false
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
                NavigationView{
                    Text("Hello World")
                }
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
            }
            .accentColor(.black)
            VStack{
                Spacer()
                Button(action: {
                    showAlert.toggle()
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                })
                .padding(.bottom, 70)
                .padding(.trailing,40)
                .actionSheet(isPresented: $showAlert) {
                    ActionSheet(title: Text("Upload New Photo"), message: nil, buttons: [
                        .default(Text("Take Photo"),action:{
                            
                        }),
                        .default(Text("Import Photo"),action:{
                            
                        }),
                        .cancel()
                    ])
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
