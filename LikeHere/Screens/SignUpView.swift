//
//  SignUpView.swift
//  LikeHere
//
//  Created by Taishi Kusunose on 2021/06/07.
//

import SwiftUI

struct SignUpView: View {
    var body: some View {
        ZStack{
            Image("login")
                .resizable()
                .scaledToFill()
                .offset(x:80)
                .frame(width: UIScreen.main.bounds.width)
                .clipped()
                .edgesIgnoringSafeArea(.all)

            VStack(alignment:.center){
                Image("logotitle")
                    .padding(.top,200)
                Spacer()
                VStack(spacing:20){
                    Button(action: {
                    }, label: {
                        Text("Sign in / Sign up".uppercased())
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding()
                            .frame(height: 60)
                            .frame(maxWidth:.infinity)
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(radius: 12)
                    })
                    .accentColor(.black)
                    Button(action: {
                    }, label: {
                        Text("Continue as a guest".uppercased())
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding()
                            .frame(height: 60)
                            .frame(maxWidth:.infinity)
                            .background(Color.black)
                            .cornerRadius(12)
                            .shadow(radius: 12)
                    })
                    .accentColor(.white)
                }
                .padding(.horizontal,20)
                .padding(.bottom,50)
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
