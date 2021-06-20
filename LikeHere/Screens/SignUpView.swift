//
//  SignUpView.swift
//  LikeHere
//
//  Created by Taishi Kusunose on 2021/06/07.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    @State var showError = false
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
                VStack{
                    //Like Here
                    Text("Like Here")
                        .font(.custom("Georgia-BoldItalic", size: 48))
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    //旅に出よう。好きな居場所を見つけよう。
                    Text("旅に出よう。好きな居場所を見つけよう。").font(.custom("Comfortaa bold", size: 15))
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .tracking(-0.22)
                        .padding()
                }
                .padding(.top,150)
                Spacer()
                VStack(spacing:20){
                    Button(action: {
                        SignInWithApple.instance.startSignInWithAppleFlow(view: self)
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
                .alert(isPresented: $showError, content: {
                    return Alert(title: Text("Error signing in 😢"))
                })
                .padding(.horizontal,20)
                .padding(.bottom,50)
            }
        }
    }
    
    func connectToFirebase(name: String, email: String, provider: String, credential: AuthCredential){
        
        AuthService.instance.logInUserToFirebase(credential: credential) { (returnedProviderID, isError) in
            
            if let providerID = returnedProviderID, !isError {
                //success
            } else {
                //error
                print("Error getting into from log in user to Firebase")
                self.showError.toggle()
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
