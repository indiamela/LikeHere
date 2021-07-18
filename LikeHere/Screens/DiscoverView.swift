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
    @State var postImage: UIImage = UIImage(named:"circle.hexagonpath.fill")!
    @State var selection: Int = 0
    
    var body: some View {
        
        VStack(alignment: .leading){
            //search feeling
            Text("search feeling")
                .foregroundColor(Color.MyTheme.orangeColor)
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
                                    posts.filterWithTag(tagID: index)
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
            
            Text(categoryName($selection.wrappedValue))
                .font(.headline)
                .foregroundColor(Color.MyTheme.orangeColor)
                .padding(.leading,20)
                .padding(.top,10)

            ScrollView(showsIndicators: true) {
                RefreshControl(coordinateSpaceName: "RefreshControl", onRefresh: {
                    posts.filterWithTag(tagID: $selection.wrappedValue)
                })
                WaterfallGrid(posts.dataArray, id: \.self) { index in
                    PostView(post: index, showHeaderAndFooter: false)
                }
                .gridStyle(
                    columns: 2,
                    animation: .easeInOut(duration: 0.5)
                )
            }
            .coordinateSpace(name: "RefreshControl")
        }
        .navigationBarTitle("Discover")
        .navigationBarTitleDisplayMode(.large)
    }
        
    func categoryName(_ index:Int) -> String{
        switch index {
        case 0:
          return "BROWSE ALL"
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
            return "Joyful"
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
