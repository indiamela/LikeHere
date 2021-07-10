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
            
            Image(uiImage: imageSelected)
                .resizable()
                .scaledToFit()
                .frame(maxWidth:.infinity, maxHeight: 200)
                .clipped()
            
            HStack{
                Image(systemName: "mappin.and.ellipse")
                    .font(.title3)
                    .accentColor(.black)
                TextField("場所を追加", text: $addressText)
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal,20)
            .padding(.vertical,10)
            
            Divider()
            Text("feeling")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .textCase(.uppercase)
                .padding(.horizontal,20)
                .padding(.top,20)
            
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack(spacing:5){
                    ForEach((0..<7), id: \.self) { index in
                        VStack{
                            ZStack{
                                Image("category\(index)")
                                    .resizable()
                                    .frame(width: 70, height: 70)
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(Circle())
                                    .onTapGesture {
                                        selection = index
                                    }
                                Circle()
                                    .frame(width: 70, height: 70)
                                    .foregroundColor(Color.MyTheme.orangeColor)
                                    .opacity(selection == index ? 0.7 : 0)
                            }
                            .frame(width: 70, height: 70)
                            Text(categoryName(index))
                                .font(.caption2)
                                .fontWeight(.bold)
                        }
                    }
                }
            })
            .padding()
            
            TextField("キャプションを追加", text: $captionText)
                .padding()
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .font(.headline)
                .background(Color.MyTheme.grayColor)
                .cornerRadius(12)
                .padding(.horizontal)
                .padding(.top,20)
                .autocapitalization(.sentences)
            
            Spacer()
            
            Button(action: {
                postPicture()
            }, label: {
                Text("share!".uppercased())
                    .font(.title3)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.MyTheme.orangeColor)
                    .font(.headline)
                    .cornerRadius(12)
                    .padding()
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
            return Alert(title: Text("投稿しました!"),dismissButton: .default(Text("OK"), action: {
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
            return "Relux"
        case 2:
            return "Love"
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
