//
//  PostView.swift
//  LikeHere
//
//  Created by Taishi Kusunose on 2021/06/08.
//

import SwiftUI

struct PostView: View {
    
    @State var post: PostModel
    @State var postImage: UIImage = UIImage(named:"circle.hexagonpath.fill")!
    @State var profileImage: UIImage = UIImage(named: "circle.hexagonpath.fill")!
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
                destination: DetailPictureView(post: post, postImage: postImage, postArray: PostArrayObject(userID: post.userID), profileImage: profileImage),
                label: {
                    Image(uiImage:postImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth:.infinity, maxHeight: showHeaderAndFooter ? 300 : nil)
                        .clipShape(Rectangle())
                        .edgesIgnoringSafeArea(.all)
                })
            
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
                
                HStack(alignment: .top, spacing: 20){
                    VStack{
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
                        .accentColor(Color.MyTheme.orangeColor)
                        Text(String(post.likeCount))
                            .font(.caption)
                            .foregroundColor(Color.MyTheme.orangeColor)
                    }
                    
                    VStack {
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
                        .accentColor(Color.MyTheme.blueColor)
                        Text(String(post.goneCount))
                            .font(.caption)
                            .foregroundColor(Color.MyTheme.blueColor)
                    }
                    
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
        Loading.defaults().start()
        ImageManager.instance.downloadingProfileImage(userID: post.userID) { (returnedImage) in
            if let image = returnedImage {
                self.profileImage = image
            }
        }
        ImageManager.instance.downloadPostImage(postID: post.postID) { (returnedImage) in
            if let image = returnedImage {
                self.postImage = image
            }
            Loading.defaults().stop()
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
    static var post = PostModel(tag: 1, postID: "", userID: "", username: "displayName",caption: "????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????",address: "Italy", dateCreated: Date(), likeCount: 5, goneCount: 2, likeByUser: true, goneByUser: true)
    static var previews: some View {
        PostView(post: post, showHeaderAndFooter: true)
            .previewLayout(.sizeThatFits)
    }
}
