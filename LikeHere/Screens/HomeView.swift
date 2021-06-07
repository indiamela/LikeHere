//
//  HomeView.swift
//  LikeHere
//
//  Created by Taishi Kusunose on 2021/06/08.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            LazyVStack{
                PostView()
                PostView()
                PostView()
            }
        }
        .navigationBarTitle("title")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
        }
    }
}
