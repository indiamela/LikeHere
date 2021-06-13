//
//  SettingsView.swift
//  LikeHere
//
//  Created by Taishi Kusunose on 2021/06/13.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode

    @State var showSignOutError = false
    
    @Binding var userDisplayName:String
    @Binding var userDisplayAddress:String
    @Binding var userProfilePicture: UIImage
    
    var body: some View {
        NavigationView{
            ScrollView{
                GroupBox(label: SettingLabelView(labelText: "Profile", labelImage: "person.fill"), content: {
                    NavigationLink(
                        destination: SettingEditTextView(submissionText: "userDisplayName", title: "Display name", description:  "This is the description so that we can tell the user what they are doing on this screen", placeholder: "Put your display name...", profileText:  $userDisplayName),
                        label: {
                            SettingRollView(leftIcon: "pencil", text: "Display Name", color: Color.gray)
                        })
                    NavigationLink(
                        destination: SettingEditTextView(submissionText: "userDisplayAddress", title: "Profile Address", description: "Your bio is a great place to let other users know a little about you", placeholder: "Your bio here...", profileText: $userDisplayAddress),
                        label: {
                            SettingRollView(leftIcon: "text.quote", text: "Bio", color: Color.gray)
                        })
                    NavigationLink(
                        destination: SettingEditImageView(title: "Profile Picrure", description: "Your profile picrture will be shown on your profile ad on your posts. Most users make it an image of themselves or of their dog!", selectedImage: userProfilePicture, profileImage: $userProfilePicture),
                        label: {
                            SettingRollView(leftIcon: "photo", text: "Profile Picture", color: Color.gray)
                        })
                    Button {
                        signOut()
                    } label: {
                        SettingRollView(leftIcon: "figure.walk", text: "Sign out", color: Color.yellow)
                    }
                    .alert(isPresented: $showSignOutError) {
                        return Alert(title: Text("Error Signing Out 😱"))
                    }
                    
                })
                .padding()
            }
        }
        .navigationBarTitle("Settings")
        .navigationBarTitleDisplayMode(.large)
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
                .font(.title)
        })
        .accentColor(.primary)
        )
    }
    
    func signOut(){
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    @State static var testString:String = ""
    @State static var image: UIImage = UIImage(named: "dog1")!
    static var previews: some View {
        SettingsView(userDisplayName: $testString, userDisplayAddress: $testString, userProfilePicture: $image)
            .preferredColorScheme(.dark)
    }
}
