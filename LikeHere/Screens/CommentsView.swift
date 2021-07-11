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
    @State var profilePicture = UIImage(named: "logo.loading")
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    @AppStorage(CurrentUserDefaults.displayName) var currentDisplayName: String?
    
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
            Divider()
            HStack{
                Image(uiImage: profilePicture!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40, alignment: .center)
                    .cornerRadius(20)
                TextField("Add a comment here...", text: $submissionText)
                
                Button(action: {
                    addComment()
                }, label: {
                    Image(systemName: "paperplane.fill")
                        .font(.title2)
                })
            }
        }
        .padding()
        .onAppear(perform: {
            getProfilePicture()
            getComments()
        })
    }
    
    func getProfilePicture() {
        guard let userID = currentUserID else { return }
        ImageManager.instance.downloadingProfileImage(userID: userID) { (returnedImage) in
            if let image = returnedImage {
                self.profilePicture = image
            }
        }
    }
    
    func addComment() {
        guard let userID = currentUserID, let displayName = currentDisplayName else { return }
        guard submissionText.count > 0 else { return }
        DataService.instance.uploadComment(userID: userID, postID: post.postID, userName: displayName, comment: submissionText) { (success,returnedCommentID) in
            if success, let commentID = returnedCommentID {
                let newComment = CommentModel(commentID: commentID, userID: userID, username: displayName, content: submissionText, dataCreated: Date())
                self.commentsArray.append(newComment)
                self.submissionText = ""
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
    
    func getComments() {
        guard self.commentsArray.isEmpty else { return }
        print("get comments")
        if let caption = post.caption, caption.count > 1 {
            let captionComment = CommentModel(commentID: "", userID: post.userID, username: post.username, content: caption, dataCreated: post.dateCreated)
            self.commentsArray.append(captionComment)
        }
        DataService.instance.downloadComment(postID: post.postID) { (returnedComments) in
            self.commentsArray.append(contentsOf: returnedComments)
        }
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView(post: PostModel(tag: 1, postID: "", userID: "", username: "displayName", dateCreated: Date(), likeCount: 0, goneCount: 0, likeByUser: true, goneByUser: true))
    }
}

