//
//  ProfileView.swift
//  LikeHere
//
//  Created by Taishi Kusunose on 2021/06/13.
//

import SwiftUI

struct ProfileHeaderView: View {
    @Binding var displayName:String
    @Binding var displayPicture: UIImage
    @Binding var displayAddress: String
    @ObservedObject var postArray: PostArrayObject
    
    var body: some View {
        VStack{
            //ProfileImage
            Image(uiImage: displayPicture)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 128, height: 128)
                .clipShape(Circle())
                .padding(.top,30)
            
            //name
            Text(displayName)
                .font(.custom("Comfortaa Regular", size: 30))
                .tracking(-0.54)
                .multilineTextAlignment(.center)
            
            //address
            Text(displayAddress)
                .font(.custom("Roboto Black", size: 15))
                .tracking(0.52)
                .multilineTextAlignment(.center)
                .textCase(.uppercase)
        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(profileUserID: "", userDisplayName: "", posts: PostArrayObject(userID: ""))
    }
}
