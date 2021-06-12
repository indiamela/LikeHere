//
//  PostView.swift
//  LikeHere
//
//  Created by Taishi Kusunose on 2021/06/08.
//

import SwiftUI

struct PostView: View {
    
    @State var post: PostModel
    
    var body: some View {
        VStack(alignment:.leading){
            // MARK: - HEADER
            HStack{
                //Ellipse 12
                Image("dog1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                VStack(alignment: .leading){
                    //nkchaudhary01
                    Text(post.username)
                        .font(.custom("Avenir Next Bold", size: 14))
                        .foregroundColor(.black)
                    //心が落ち着く場所
                    Text("心が落ち着く場所")
                        .font(.custom("Avenir Next Regular", size: 10))
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal,20)
            .padding(.top,10)
            
            // MARK: - IMAGE
            Image("place6")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth:.infinity, maxHeight: 200)
                .clipShape(Rectangle())
                .edgesIgnoringSafeArea(.all)
            
            // MARK: - FOOTER
            HStack(alignment: .bottom, spacing: 20){
                Button(action: {
                    //want to go
                }, label: {
                    Image(systemName: "hand.thumbsup.fill")
                        .font(.title2)
                })
                .accentColor(.red)
                
                Button(action: {
                    //went
                }, label: {
                    Image(systemName: "flag.fill")
                        .font(.title2)
                })
                .accentColor(.green)
                
                    //comment
                NavigationLink(
                    destination: CommentsView(post: post),
                    label: {
                        Image(systemName: "bubble.middle.bottom")
                            .font(.title2)
                    })
                .accentColor(.black)
                
                Button(action: {
                    //share
                }, label: {
                    Image(systemName: "paperplane")
                        .font(.title2)
                })
                .accentColor(.black)
            }
            .padding(.horizontal,20)
            
            HStack{
                Image(systemName: "mappin.and.ellipse")
                    .font(.title3)
                    .accentColor(.black)
                //Plaece Addless
                Text(post.address ?? "")
                    .font(.custom("Roboto Regular", size: 14))
                    .foregroundColor(Color(#colorLiteral(red: 0.78, green: 0.8, blue: 0.83, alpha: 1)))
            }
            .padding(.horizontal,20)
            .padding(.top,5)
            
            //小さなお子様連れの旅行では、持ち物がたくさんあるので...
            if let caption = post.caption{
                HStack{
                    Text(caption)
                        .font(.custom("Avenir Next Regular", size: 10))
                        .foregroundColor(Color(#colorLiteral(red: 0.11, green: 0.11, blue: 0.16, alpha: 1)))
                        .padding(.horizontal,20)
                        .padding(.top,5)
                    Spacer(minLength: 0)
                }
            }
        }
        .padding(.vertical,5)
    }
}

struct PostView_Previews: PreviewProvider {
    static var post = PostModel(tag: "", postID: "", userID: "", username: "displayName", caption: "小さなお子様連れの旅行では、持ち物がたくさんあるのでつい忘れてしまう物も出てきます。館内にコンビニや売店があれば、もしもの時にすぐに買い物ができるので便利です。", dateCreated: Date(), wantCount: 5, goneCount: 2, wantByUser: true, goneByUser: true)
    static var previews: some View {
        PostView(post: post)
            .previewLayout(.sizeThatFits)
    }
}
