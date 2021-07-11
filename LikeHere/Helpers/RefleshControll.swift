//
//  RefleshControll.swift
//  LikeHere
//
//  Created by Taishi Kusunose on 2021/07/12.
//

import Foundation
import SwiftUI

struct RefreshControl: View {
    
    @State private var isRefreshing = false
    var coordinateSpaceName: String
    var onRefresh: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            if geometry.frame(in: .named(coordinateSpaceName)).midY > 50 {
                Spacer()
                    .onAppear() {
                        print("refleshing = true")
                        isRefreshing = true
                    }
            } else if geometry.frame(in: .named(coordinateSpaceName)).maxY < 10 {
                Spacer()
                    .onAppear() {
                        if isRefreshing {
                            isRefreshing = false
                            print("refleshing = false")
                            onRefresh()
                        }
                    }
            }
            HStack {
                Spacer()
                if isRefreshing {
                    ProgressView()
                } else {
                    Text("離して更新")
                }
                Spacer()
            }
        }.padding(.top, -50)
    }
}
