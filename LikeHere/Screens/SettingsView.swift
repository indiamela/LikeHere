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
                GroupBox(label: SettingLabelView(labelText: "プロフィール", labelImage: "person.fill"), content: {
                    NavigationLink(
                        destination: SettingEditTextView(submissionText: userDisplayName , title: "ユーザーネーム", placeholder: "Put your display name...", profileText:  $userDisplayName, settingsEditTextOption: .displayName),
                        label: {
                            SettingRollView(leftIcon: "pencil", text: "Display Name", color: Color.gray)
                        })
                    NavigationLink(
                        destination: SettingEditTextView(submissionText: userDisplayAddress, title: "場所", placeholder: "Your address here...", profileText: $userDisplayAddress, settingsEditTextOption: .address),
                        label: {
                            SettingRollView(leftIcon: "text.quote", text: "Address", color: Color.gray)
                        })
                    NavigationLink(
                        destination: SettingEditImageView(title: "プロフィール画像", selectedImage: userProfilePicture, profileImage: $userProfilePicture),
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

                
//                GroupBox(label: SettingLabelView(labelText: "Application", labelImage: "apps.iphone"), content: {
//                    Button(action: {
//                        openCustomURL(urlString: "https://www.google.com")
//                    }, label: {
//                        SettingRollView(leftIcon: "folder.fill", text: "Privacy Policy", color: Color.yellow)
//                    })
//                })
//                .padding()

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
        AuthService.instance.logOutUser { success in
            if success {
                print("success log out")
                self.presentationMode.wrappedValue.dismiss()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let defaultsDictionaly = UserDefaults.standard.dictionaryRepresentation()
                    defaultsDictionaly.keys.forEach { (key) in
                        UserDefaults.standard.removeObject(forKey: key)
                    }
                }
            } else {
                print("error log out")
                self.showSignOutError.toggle()

            }
        }
    }
    
    func openCustomURL(urlString:String){
        guard let url = URL(string: urlString) else {return}
        if UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    @State static var testString:String = ""
    @State static var image: UIImage = UIImage(named: "dog1")!
    static var previews: some View {
        NavigationView{
            SettingsView(userDisplayName: $testString, userDisplayAddress: $testString, userProfilePicture: $image)
        }
    }
}
