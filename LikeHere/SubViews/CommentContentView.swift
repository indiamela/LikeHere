//
//  CommentContentView.swift
//  LikeHere
//
//  Created by Taishi Kusunose on 2021/06/10.
//

import SwiftUI

struct CommentContentView: View {
    @State var comment:CommentModel
    var body: some View {
        HStack {
            
            //MARK: PROFILE IMAGE
            Image("dog1")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40, alignment: .center)
                .cornerRadius(20)
            VStack(alignment: .leading, spacing: 4, content: {
                //MARK: USER NAME
                Text(comment.username)
                    .font(.caption)
                    .foregroundColor(.gray)
                //MARK: CONTENT
                Text(comment.content)
                    .padding(.all,10)
                    .foregroundColor(.primary)
                    .background(Color.gray)
                    .cornerRadius(10)
            })
            
            Spacer(minLength: 0)
        }
        .onAppear{
            getProfileImage()
        }
    }
    
    func getProfileImage() {

    }
}

struct CommentContentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentContentView(comment: CommentModel(commentID: "", userID: "", username: "userName", content: "かわいい！", dataCreated: Date()))
            .previewLayout(.sizeThatFits)
    }
}
