//
//  PostView.swift
//  LikeHere
//
//  Created by Taishi Kusunose on 2021/06/08.
//

import SwiftUI

struct PostView: View {
    
    @State var post: PostModel
    @State var postImage: UIImage = UIImage(named:"logo.loading")!
    @State var profileImage: UIImage = UIImage(named: "logo.loading")!
    @AppStorage(CurrentUserDefaults.userID) var currentUserID:String?
    var showHeaderAndFooter:Bool
    @State var showDatailPicture = false
    
    var body: some View {
        VStack(alignment:.leading){
            // MARK: - HEADER
            if showHeaderAndFooter {
                HStack{
                    NavigationLink(
                        destination: ProfileView(isMyProfile: false, profileUserID: post.userID, userDisplayName: post.username, posts: PostArrayObject(userID: post.userID)),
                        label: {
                            Image(uiImage: profileImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 30, height: 30)
                                .clipShape(Circle())
                        })
                    VStack(alignment: .leading){
                        Text(post.username)
                            .font(.custom("Roboto Bold", size: 20))
                            .foregroundColor(.black)
                        Text(post.tagName())
                            .font(.custom("Roboto Regular", size: 14))
                            .foregroundColor(.black)
                    }
                }
                .padding(.horizontal,20)
                .padding(.top,20)
            }
            
            // MARK: - IMAGE
            NavigationLink(
                destination: DetailPictureView(postImage: postImage, profileImage: profileImage, post: post),
                label: {
                    Image(uiImage:postImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth:.infinity, maxHeight: showHeaderAndFooter ? 300 : nil)
                        .clipShape(Rectangle())
                        .edgesIgnoringSafeArea(.all)
                })
//            Image(uiImage:postImage)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(maxWidth:.infinity, maxHeight: showHeaderAndFooter ? 300 : nil)
//                .clipShape(Rectangle())
//                .edgesIgnoringSafeArea(.all)
//                .onTapGesture {
//                    showDatailPicture.toggle()
//                }
            
            if showHeaderAndFooter {
                // MARK: - FOOTER
                if let address = post.address {
                    HStack{
                        Image(systemName: "mappin.and.ellipse")
                            .font(.title3)
                            .accentColor(.black)
                        Text(address)
                            .font(.custom("Roboto Regular", size: 14))
                    }
                    .padding(.horizontal,20)
                    .padding(.top,5)
                }
                
                HStack(alignment: .bottom, spacing: 20){
                    Button(action: {
                        //like
                        if post.likeByUser {
                            unlikePost()
                        } else {
                            likePost()
                        }
                    }, label: {
                        Image(systemName: post.likeByUser ? "hand.thumbsup.fill" : "hand.thumbsup")
                            .font(.title2)
                    })
                    .accentColor(.red)
                    
                    Button(action: {
                        //gone
                        if post.goneByUser {
                            notGonePost()
                        } else {
                            gonePost()
                        }
                    }, label: {
                        Image(systemName: post.goneByUser ? "flag.fill" : "flag")
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
                        sharePost()
                    }, label: {
                        Image(systemName: "paperplane")
                            .font(.title2)
                    })
                    .accentColor(.black)
                }
                .padding(.horizontal,20)
                .padding(.top,5)
                
                if let caption = post.caption{
                    HStack{
                        Text(caption)
                            .font(.custom("Roboto Regular", size: 14))
                            .foregroundColor(Color(#colorLiteral(red: 0.11, green: 0.11, blue: 0.16, alpha: 1)))
                            .padding(.top,5)
                        Spacer(minLength: 0)
                    }
                    .padding(.horizontal,20)
                    .padding(.top,5)
                }
            }
        }
        .onAppear{
            getImages()
        }
//        .fullScreenCover(isPresented: $showDatailPicture, content: {
//            DetailPictureView(postImage: postImage, profileImage: profileImage, post: post)
//        })
    }
    
    func likePost() {
        guard let userID = currentUserID else {
            print("Cannot find userID while liking post")
            return
        }
        let updatePost = PostModel(tag: post.tag, postID: post.postID, userID: post.userID, username: post.username, caption: post.caption, address: post.address, dateCreated: post.dateCreated, likeCount: post.likeCount + 1, goneCount: post.goneCount, likeByUser: true, goneByUser: post.goneByUser)
        
        self.post = updatePost
        DataService.instance.likePost(postID: post.postID, currentUserID: userID)
    }
    
    func unlikePost() {
        guard let userID = currentUserID else {
            print("Cannot find userID while liking post")
            return
        }
        let updatePost = PostModel(tag: post.tag, postID: post.postID, userID: post.userID, username: post.username, caption: post.caption, address: post.address, dateCreated: post.dateCreated, likeCount: post.likeCount - 1, goneCount: post.goneCount, likeByUser: false, goneByUser: post.goneByUser)
        
        self.post = updatePost
        DataService.instance.unlikePost(postID: post.postID, currentUserID: userID)
    }
    
    func gonePost() {
        guard let userID = currentUserID else {
            print("Cannot find userID while liking post")
            return
        }
        let updatePost = PostModel(tag: post.tag, postID: post.postID, userID: post.userID, username: post.username, caption: post.caption, address: post.address, dateCreated: post.dateCreated, likeCount: post.likeCount, goneCount: post.goneCount + 1, likeByUser: post.likeByUser, goneByUser: true)
        
        self.post = updatePost
        DataService.instance.gonePost(postID: post.postID, currentUserID: userID)
    }
    
    func notGonePost() {
        guard let userID = currentUserID else {
            print("Cannot find userID while liking post")
            return
        }
        let updatePost = PostModel(tag: post.tag, postID: post.postID, userID: post.userID, username: post.username, caption: post.caption, address: post.address, dateCreated: post.dateCreated, likeCount: post.likeCount, goneCount: post.goneCount - 1, likeByUser: post.likeByUser, goneByUser: false)
        
        self.post = updatePost
        DataService.instance.notGonePost(postID: post.postID, currentUserID: userID)
    }
    
    func getImages() {
        ImageManager.instance.downloadingProfileImage(userID: post.userID) { (returnedImage) in
            if let image = returnedImage {
                self.profileImage = image
            }
        }
        
        ImageManager.instance.downloadPostImage(postID: post.postID) { (returnedImage) in
            if let image = returnedImage {
                self.postImage = image
            }
        }
    }
    
    func sharePost() {
        let message = "Check out this post on LikeHere!"
        let image = postImage
        let address = post.address ?? ""
        
        let activityViewController = UIActivityViewController(activityItems: [message,image,address], applicationActivities: nil)
        
        let viewController = UIApplication.shared.windows.first?.rootViewController
        viewController?.present(activityViewController, animated: true, completion: nil)
    }
}

struct PostView_Previews: PreviewProvider {
    static var post = PostModel(tag: 1, postID: "", userID: "", username: "displayName",caption: "小さなお子様連れの旅行では、持ち物がたくさんあるのでつい忘れてしまう物も出てきます。館内にコンビニや売店があれば、もしもの時にすぐに買い物ができるので便利です。",address: "Italy", dateCreated: Date(), likeCount: 5, goneCount: 2, likeByUser: true, goneByUser: true)
    static var previews: some View {
        PostView(post: post, showHeaderAndFooter: true)
            .previewLayout(.sizeThatFits)
    }
}
