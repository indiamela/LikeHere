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
    @State var userID: String
    @State var userDisplayName: String
    @State var userDisplayAddress = ""
    @State var userProfilePicture = UIImage(named: "logo.loading")!

    
    var body: some View {
        VStack{
            ProfileHeaderView(displayName: userDisplayName, displayPicture: $userProfilePicture, displayAddress: userDisplayAddress)
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
        .onAppear(perform: {
            getProfileImage()
        })
    }
    
    func getProfileImage() {
        ImageManager.instance.downloadingProfileImage(userID: userID) { (returnedImage) in
            if let image = returnedImage {
                self.userProfilePicture = image
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ProfileView(userID: "", userDisplayName: "")
        }
    }
}
