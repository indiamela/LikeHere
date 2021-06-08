//
//  HomeView.swift
//  LikeHere
//
//  Created by Taishi Kusunose on 2021/06/08.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var posts:PostArrayObject
    
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            LazyVStack{
                ForEach(posts.dataArray, id: \.self) { post in
                    PostView(post: post)
                }
            }
        }
        .navigationBarTitle("title")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView(posts: PostArrayObject())
        }
    }
}
