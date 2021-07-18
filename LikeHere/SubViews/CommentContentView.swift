//
//  CommentContentView.swift
//  LikeHere
//
//  Created by Taishi Kusunose on 2021/06/10.
//

import SwiftUI

struct CommentContentView: View {
    @State var comment:CommentModel
    @State var profileImage: UIImage = UIImage(named: "circle.hexagonpath.fill")!
    var body: some View {
        HStack {
            
            //MARK: PROFILE IMAGE
            Image(uiImage: profileImage)
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40, alignment: .center)
                .cornerRadius(20)
            VStack(alignment: .leading, spacing: 4, content: {
                //MARK: USER NAME
                Text(comment.username)
                    .font(.caption)
                    .foregroundColor(.black)
                //MARK: CONTENT
                Text(comment.content)
                    .padding(.all,10)
                    .foregroundColor(.primary)
                    .background(Color.MyTheme.grayColor)
                    .cornerRadius(10)
            })
            
            Spacer(minLength: 0)
        }
        .onAppear{
            getProfileImage()
        }
    }
    
    func getProfileImage() {
        ImageManager.instance.downloadingProfileImage(userID: comment.userID) { (returnedImage) in
            if let image = returnedImage {
                profileImage = image
            }
        }
    }
}

struct CommentContentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentContentView(comment: CommentModel(commentID: "", userID: "", username: "userName", content: "かわいい！", dataCreated: Date()))
            .previewLayout(.sizeThatFits)
    }
}
