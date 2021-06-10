//
//  DiscoverView.swift
//  LikeHere
//
//  Created by Taishi Kusunose on 2021/06/11.
//

import SwiftUI
import WaterfallGrid

struct DiscoverView: View {
    @State var selection: Int = 1
    var body: some View {
        
        ScrollView(.vertical){
            ScrollView(.horizontal, showsIndicators: true, content: {
                ForEach((1..<5), id: \.self) { index in
                    Image("category\(index)")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                }
            })
//            Scroll(selection: $selection,
//                    content:  {
//                        ForEach(1..<4) { count in
//                            Image("dog\(count)")
//                                .resizable()
//                                .scaledToFill()
//                                .tag(count)
//                        }
//                    })
//                .tabViewStyle(PageTabViewStyle())
//                .frame(height:300)
//                .animation(.default)
            
            ScrollView(showsIndicators: true) {
                LazyVStack{
                    WaterfallGrid((1..<8), id: \.self) { index in
                        Image("place\(index)")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    .gridStyle(
                        columns: 2,
                        animation: .easeInOut(duration: 0.5)
                    )
                }
            }
        }
        
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
        
    }
}
