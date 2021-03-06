//
//  SettingEditImageView.swift
//  LikeHere
//
//  Created by Taishi Kusunose on 2021/06/13.
//

import SwiftUI

struct SettingEditImageView: View {
    @State var title: String
    @State var selectedImage: UIImage
    @State var sourceType: UIImagePickerController.SourceType = UIImagePickerController.SourceType.photoLibrary
    @Binding var profileImage: UIImage
    @Environment(\.presentationMode) var presentationMode
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    @State var showSuccess = false
    
    @State var showImagePicker: Bool = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20){
            
            Image(uiImage: selectedImage)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200, alignment: .center)
                .clipped()
                .cornerRadius(20)
            
            Button(action: {
                showImagePicker.toggle()
            }, label: {
                Text("Import".uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.yellow)
                    .cornerRadius(12)
            })
            .accentColor(Color.gray)
            .sheet(isPresented: $showImagePicker, content: {
                ImagePicker(imageselected: $selectedImage, sourceType: $sourceType)
            })
            
            
            
            Button(action: {
                saveImage()
            }, label: {
                Text("Save".uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray)
                    .cornerRadius(12)
            })
            .accentColor(Color.yellow)
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .navigationBarTitle(title)
        .alert(isPresented: $showSuccess){()->Alert in
            Loading.defaults().stop()
            return Alert(title: Text("??????????????????"), message: nil, dismissButton: .default(Text("OK"),action: {
                self.presentationMode.wrappedValue.dismiss()
            })
            )}
    }
    
    func saveImage(){
        guard let userID = currentUserID else {
            return
        }
        Loading.defaults().start()
        // Update the UI of the Profile
        self.profileImage = selectedImage
        
        // Update profileImage in database
        ImageManager.instance.uploadProfileImage(userID: userID, image: selectedImage)
        
        self.showSuccess.toggle()
    }
    
    
}

struct SettingEditImageView_Previews: PreviewProvider {
    @State static var image: UIImage = UIImage(named: "dog1")!

    static var previews: some View {
        SettingEditImageView(title: "Title", selectedImage: UIImage(named: "dog1")!, profileImage: $image)
    }
}
