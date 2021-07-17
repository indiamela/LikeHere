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
    
    var body: some View {
        ZStack {
            Image("backImage")
                .resizable()
                .scaledToFit()
                .frame(width: 250, alignment: .center)
                .offset(y: 10.0)
            VStack{
                //ProfileImage
                Image(uiImage: displayPicture)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 128, height: 128)
                    .clipShape(Circle())
                    .padding(.top,30)
                
                //Jane
                Text(displayName)
                    .font(.custom("Comfortaa Regular", size: 30))
                    .tracking(-0.54)
                    .multilineTextAlignment(.center)
                
                //San francisco, ca
                Text(displayAddress)
                    .font(.custom("Roboto Black", size: 15))
                    .tracking(0.52)
                    .multilineTextAlignment(.center)
                    .textCase(.uppercase)
                
                
                HStack(alignment: .center, spacing: 20, content: {
                    
                    //MARK: POSTS
                    VStack(alignment: .center, spacing: 5, content: {
                        Text("0")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Capsule()
                            .fill(Color.gray)
                            .frame(width: 20, height: 2, alignment: .center)
                        
                        Text("Posts")
                            .font(.callout)
                            .fontWeight(.regular)
                    })
                    
                    //MARK: LIKES
                    VStack(alignment: .center, spacing: 5, content: {
                        
                        Text("0")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Capsule()
                            .fill(Color.gray)
                            .frame(width: 20, height: 2, alignment: .center)
                        
                        Text("Likes")
                            .font(.callout)
                            .fontWeight(.regular)
                    })
                    
                })
                .padding(.top,10)
                
            }
        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(profileUserID: "", userDisplayName: "", posts: PostArrayObject(userID: ""))
    }
}
