//
//  DiscoverView.swift
//  LikeHere
//
//  Created by Taishi Kusunose on 2021/06/11.
//

import SwiftUI
import WaterfallGrid

struct DiscoverView: View {
    @ObservedObject var posts: PostArrayObject
    @State var postImage: UIImage = UIImage(named:"logo.loading")!
    @State var selection: Int = 0
    
    var body: some View {
        
        VStack(alignment: .leading){
            //search feeling
            Text("search feeling")
                .foregroundColor(Color.MyTheme.blueColor)
                .font(.headline)
                .textCase(.uppercase)
                .padding(.leading,20)
            
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack(spacing:20){
                    ForEach((0..<7), id: \.self) { index in
                        VStack{
                            Image("category\(index)")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .onTapGesture {
                                    selection = index
                                }
                            
                            Text(categoryName(index))
                                .font(.caption)
                            Circle()
                                .frame(width: 5, height: 5, alignment: .center)
                                .foregroundColor(.yellow)
                                .opacity(selection == index ? 1.0 : 0)
                        }
                    }
                }
            })
            .offset(y:-10)
            Divider()
            
            //browse all
            Text(categoryName($selection.wrappedValue))
                .font(.headline)
                .foregroundColor(Color.MyTheme.blueColor)
                .padding(.leading,20)
                .padding(.top,10)

            ScrollView(showsIndicators: true) {
                WaterfallGrid(posts.dataArray, id: \.self) { index in
                    PostView(post: index, showHeaderAndFooter: false)
                }
                .gridStyle(
                    columns: 2,
                    animation: .easeInOut(duration: 0.5)
                )
            }
        }
        .navigationBarTitle("discover")
        .navigationBarTitleDisplayMode(.large)
    }
        
    func categoryName(_ index:Int) -> String{
        switch index {
        case 0:
          return "BROWSE ALL"
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

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            DiscoverView(posts: PostArrayObject(shuffled: false))
        }
    }
}
