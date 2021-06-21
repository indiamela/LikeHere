//
//  RegisterView.swift
//  LikeHere
//
//  Created by Taishi Kusunose on 2021/06/21.
//

import SwiftUI

struct RegisterView: View {
    @State var showImagePicker: Bool = false
    @State var showError: Bool = false

    @State var imageSelected: UIImage = UIImage(named: "logo")!
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary

    @Binding var displayName: String
    @Binding var email: String
    @Binding var providerID: String
    @Binding var provider: String
    
    var body: some View {
        VStack{
            Spacer()
            Image("category0")
                .resizable()
                .frame(width: 200, height: 200, alignment: .center)
                .padding(.bottom,30)
            Text("What's your name?")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.gray)
            
            TextField("Add your name here...", text: $displayName)
                .padding()
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(10)
                .autocapitalization(.sentences)
                .padding(.horizontal)
                .foregroundColor(.black)
            Button(action: {
                showImagePicker.toggle()
            }, label: {
                Text("Finish: Add profile picture")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.yellow)
                    .cornerRadius(12)
                    .padding(.horizontal)
            })
            .accentColor(Color.black)
            .opacity(displayName != "" ? 1.0 : 0.0)
            .animation(.easeOut(duration: 1.0))
            Spacer()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow)
        .edgesIgnoringSafeArea(.all)
        .sheet(isPresented: $showImagePicker, content: {
            ImagePicker(imageselected: $imageSelected, sourceType: $sourceType)
        })
        .alert(isPresented: $showError) { () -> Alert in
            return Alert (title: Text("Error creating profile😤"))
        }
    }
    
    // createProfile
    func createProfile(){
        AuthService.instance.createNewUserInDatabase(name: displayName, email: email, provider: provider, providerID:providerID, profileImage: imageSelected) { (returnedUserID) in
            if let userID = returnedUserID {
                
            } else {
                //error
                print("Error logging in")
                self.showError.toggle()
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    @State static var testString: String = "Test"
    static var previews: some View {
        RegisterView(displayName: $testString, email: $testString, providerID: $testString, provider: $testString)
    }
}
