//
//  ProfileView.swift
//  LikeHere
//
//  Created by Taishi Kusunose on 2021/06/13.
//

import SwiftUI
import WaterfallGrid

struct ProfileView: View {
    @State var isMyProfile = true
    @State var settingsView = false
    @State var userDisplayName = ""
    @State var userDisplayAddress = ""
    @State var userProfilePicture = UIImage(named: "dog1")!

    
    var body: some View {
        VStack{
            ProfileHeaderView()
            Divider()
            ScrollView(showsIndicators: true) {
                WaterfallGrid((1..<8), id: \.self) { index in
                    Image("place\(index)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .gridStyle(
                    columns: 2,
                    animation: .easeInOut(duration: 0.5)
                )
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
                                Button(action: {
                                    settingsView.toggle()
                                }, label: {
                                    Image(systemName: "line.horizontal.3")
                                        .accentColor(.black)
                                })
                                .opacity(isMyProfile ? 1.0 : 0.0)
                            
        )
        .sheet(isPresented: $settingsView, content: {
            SettingsView(userDisplayName: $userDisplayName, userDisplayAddress: $userDisplayAddress, userProfilePicture: $userProfilePicture)
        })
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ProfileView()
        }
    }
}
