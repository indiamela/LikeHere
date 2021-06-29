//
//  PostImageView.swift
//  LikeHere
//
//  Created by Taishi Kusunose on 2021/06/12.
//

import SwiftUI

struct PostImageView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage(CurrentUserDefaults.userID) var userID: String?
    @AppStorage(CurrentUserDefaults.displayName) var displayName: String?
    @State var selection: Int = 0
    @State var captionText = ""
    @State var addressText = ""
    @Binding var imageSelected: UIImage
    @State var successPostImage = false
    @State var showAlart = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 0, content: {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                        .font(.title)
                        .padding()
                })
                .accentColor(.primary)
                Spacer()
            }
            
            ScrollView(.vertical, showsIndicators: false, content: {
                Image(uiImage: imageSelected)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth:.infinity, maxHeight: 300)
                    .clipped()
                
                HStack{
                    Image(systemName: "mappin.and.ellipse")
                        .font(.title3)
                        .accentColor(.black)
                    //Plaece Addless
                    TextField("address", text: $addressText)
                        .font(.custom("Roboto Regular", size: 14))
                        .foregroundColor(Color(#colorLiteral(red: 0.78, green: 0.8, blue: 0.83, alpha: 1)))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal,20)
                .padding(.top,5)
                    
                Text("feeling tag")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .textCase(.uppercase)
                    .padding(.leading,20)
                    .padding(.top,20)
                
                ScrollView(.horizontal, showsIndicators: false, content: {
                    HStack(spacing:5){
                        ForEach((0..<7), id: \.self) { index in
                            VStack{
                                
                                ZStack{
                                    Image("category\(index)")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 70, height: 70)
                                        .clipShape(Circle())
                                        .onTapGesture {
                                            selection = index
                                        }
                                    Circle()
                                        .foregroundColor(.yellow)
                                        .opacity(selection == index ? 0.7 : 0)
                                }
                                
                                Text(categoryName(index))
                                    .font(.caption2)
                            }
                        }
                    }
                })
                .offset(y:-10)
                .padding(.horizontal)
                
                VStack{
                    Text("caption")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .textCase(.uppercase)
                        .padding(.leading,20)
                        .padding(.top,20)
                    
                    TextField("Add your caption here...", text: $captionText)
                        .padding()
                        .background(Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)))
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .font(.headline)
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .autocapitalization(.sentences)
                }

                                
                Button(action: {
                    postPicture()
                }, label: {
                    Text("Post Picture!".uppercased())
                        .font(.title3)
                        .foregroundColor(Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)))
                        .fontWeight(.bold)
                        .padding()
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .font(.headline)
                        .cornerRadius(12)
                        .padding(.horizontal)
                })
            })
        })
        .alert(isPresented: $showAlart) { () -> Alert in
            getAlert()
        }
    }
    
    func postPicture(){
        print("POST PICTURE TO DATABASE HERE")
        guard let currentUserID = userID, let CurrentUserDisplayName = displayName else {
            print("Error getting userID & displayname")
            return
        }
        DataService.instance.uploadPost(image: imageSelected, address: addressText, tag: selection, caption: captionText, displayName: CurrentUserDisplayName, userID: currentUserID) { (success) in
            successPostImage = true
            showAlart.toggle()
            print("Succcess post picture")
        }
    }
    
    func getAlert() -> Alert {
        if successPostImage {
            return Alert(title: Text("投稿しました"),dismissButton: .default(Text("OK"), action: {
                presentationMode.wrappedValue.dismiss()
            }))
        } else {
            return Alert(title: Text("投稿できませんでした"),message: Text("通信環境を確認して再度お試しください"),dismissButton: .default(Text("OK"), action: {
                presentationMode.wrappedValue.dismiss()
            }))
        }
    }

    func categoryName(_ index:Int) -> String{
        switch index {
        case 0:
          return "No tag"
        case 1:
          return "Reluxing"
        case 2:
            return "Loving"
        case 3:
            return "Intersting"
        case 4:
            return "Freedom"
        case 5:
            return "Peaceful"
        case 6:
            return "Jouful"
        default:
            return "BROWSE ALL"
        }
    }
}

struct PostImageView_Previews: PreviewProvider {
    @State static var image = UIImage(named: "place4")!
    static var previews: some View {
        PostImageView(imageSelected: $image)
    }
}
