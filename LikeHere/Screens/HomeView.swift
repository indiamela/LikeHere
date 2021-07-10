//
//  HomeView.swift
//  LikeHere
//
//  Created by Taishi Kusunose on 2021/06/08.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var posts:PostArrayObject
    @State var showAlert: Bool = false
    @State var showImagePicker: Bool = false
    @State var imageSelected: UIImage = UIImage(named: "logo")!
    @State var sourceType: UIImagePickerController.SourceType = .camera
    @State var showPostImageView: Bool = false
    
    var body: some View {
        ZStack(alignment:.trailing){
            ScrollView(.vertical,showsIndicators: false){
                LazyVStack{
                    ForEach(posts.dataArray, id: \.self) { post in
                        PostView(post: post, showHeaderAndFooter: true)
                    }
                }
            }
            
            VStack{
                Spacer()
                Button(action: {
                    showAlert.toggle()
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(Color.MyTheme.orangeColor)
                })
                .padding(.bottom, 30)
                .padding(.trailing,40)
                .actionSheet(isPresented: $showAlert) {
                    ActionSheet(title: Text("Upload New Photo"), message: nil, buttons: [
                        .default(Text("Take Photo"),action:{
                            sourceType = UIImagePickerController.SourceType.camera
                            showImagePicker.toggle()
                        }),
                        .default(Text("Import Photo"),action:{
                            sourceType = UIImagePickerController.SourceType.photoLibrary
                            showImagePicker.toggle()
                        }),
                        .cancel()
                    ])
                }
                .sheet(isPresented: $showImagePicker, onDismiss: segueToPostImageView) {
                    ImagePicker(imageselected: $imageSelected, sourceType: $sourceType)
                }
            }
            .fullScreenCover(isPresented: $showPostImageView, content: {
                PostImageView(imageSelected: $imageSelected)
            })

        }
        .navigationBarHidden(true)
    }
    
    // MARK: - FUNCTIONS
    func segueToPostImageView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            showPostImageView.toggle()
        }
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView(posts: PostArrayObject(shuffled: true))
        }
    }
}
