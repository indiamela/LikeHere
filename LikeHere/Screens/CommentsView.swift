//
//  CommentsView.swift
//  LikeHere
//
//  Created by Taishi Kusunose on 2021/06/10.
//

import SwiftUI

struct CommentsView: View {
    @State var submissionText = ""
    @State var commentsArray = [CommentModel]()
    
    var post:PostModel
    
    var body: some View {
        VStack{
            // Messages
            LazyVStack{
                ForEach(commentsArray,id:\.self) { comment in
                    CommentContentView(comment: comment)
                }
            }
            Spacer()
            // SendButton
            HStack{
                Image("dog1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40, alignment: .center)
                    .cornerRadius(20)
                TextField("Add a comment here...", text: $submissionText)
                
                Button(action: {
                    // send comment
                }, label: {
                    Image(systemName: "paperplane.fill")
                        .font(.title2)
                })
            }
        }
        .padding()
        .navigationBarTitle(Text("Chats"))
        .onAppear(perform: {
            getComments()
        })
    }
    
    func getComments() {
        let array1 = CommentModel(commentID: "", userID: "", username: "userName", content: "かわいい！", dataCreated: Date())
        let array2 = CommentModel(commentID: "", userID: "", username: "userName", content: "おもしろい！", dataCreated: Date())
        let array3 = CommentModel(commentID: "", userID: "", username: "userName", content: "hahahaha！", dataCreated: Date())

        self.commentsArray.append(array1)
        self.commentsArray.append(array2)
        self.commentsArray.append(array3)

    }

}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView(post: PostModel(tag: 1, postID: "", userID: "", username: "displayName", dateCreated: Date(), likeCount: 0, goneCount: 0, likeByUser: true, goneByUser: true))
    }
}

