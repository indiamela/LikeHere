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
    var profileUserID: String
    @State var userDisplayName: String
    @State var userDisplayAddress = ""
    @State var userProfilePicture = UIImage(named: "logo.loading")!
    
    @ObservedObject var posts:PostArrayObject

    
    var body: some View {
        VStack{
            ProfileHeaderView(displayName: $userDisplayName, displayPicture: $userProfilePicture, displayAddress: $userDisplayAddress, postArray: PostArrayObject(userID: profileUserID))
            Divider()
            ScrollView(showsIndicators: true) {
                RefreshControl(coordinateSpaceName: "RefreshControl", onRefresh: {
                    posts.fetchPostsForUser(userID: profileUserID)
                })
                WaterfallGrid(posts.dataArray, id: \.self) { index in
                    PostView(post: index, showHeaderAndFooter: false)
                }
                .gridStyle(
                    columns: 2,
                    animation: .easeInOut(duration: 0.5)
                )
            }
            .coordinateSpace(name: "RefreshControl")
        }
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
            getUserProfile()
        })
    }
    
    func getProfileImage() {
        ImageManager.instance.downloadingProfileImage(userID: profileUserID) { (returnedImage) in
            if let image = returnedImage {
                self.userProfilePicture = image
            }
        }
    }
    
    func getUserProfile() {
        AuthService.instance.getUserInfo(userID: profileUserID) { (returnedName,returnedAddress)  in
            if let name = returnedName {
                self.userDisplayName = name
            }
            if let address = returnedAddress {
                self.userDisplayAddress = address
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ProfileView(profileUserID: "", userDisplayName: "", posts: PostArrayObject(userID: ""))
        }
    }
}
