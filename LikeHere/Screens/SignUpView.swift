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
    @State var showRegisterView = false
    @State var showProfileView = false
    @State var displayName: String = ""
    @State var email: String = ""
    @State var providerID: String = ""
    @State var provider: String = ""
    
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    @AppStorage(CurrentUserDefaults.displayName) var currentUserDisplayName: String?
    
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
                    Image("logotitle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, alignment: .center)
                    //旅に出よう。好きな居場所を見つけよう。
                    Text("旅に出よう。好きな居場所を見つけよう。")
                        .font(.custom("Comfortaa bold", size: 15))
                        .foregroundColor(Color.MyTheme.grayColor)
                        .tracking(-0.22)
                        .padding()
                }
                .padding(.top,150)
                Spacer()
                VStack(spacing:20){
                    // Apple Sign in
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
                    
                    // Google Sign in
                    Button(action: {
                        SignInWithGoogle.instance.startSignInGoogleFlow(view: self)
                        
                    }, label: {
                        HStack{
                            Image(systemName: "globe")
                            Text("Sign in with Google")
                        }
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(Color(.sRGB, red: 222/255, green: 82/255, blue: 70/255, opacity: 1.0))
                        .cornerRadius(6)
                        .font(.system(size: 25, weight: .medium, design: .default))
                    })
                    .accentColor(Color.white)
                }
                .alert(isPresented: $showError, content: {
                    return Alert(title: Text("Error signing in 😢"))
                })
                .fullScreenCover(isPresented: $showRegisterView, content: {
                    RegisterView(displayName: $displayName, email: $email, providerID: $providerID, provider: $provider)
                })
                .fullScreenCover(isPresented: $showProfileView, content: {
                    if let userID = currentUserID, let displayName = currentUserDisplayName{
                        ProfileView(isMyProfile: true, profileUserID: userID, userDisplayName: displayName, posts: PostArrayObject(userID: userID))
                    }
                })
                .padding(.horizontal,20)
                .padding(.bottom,50)
            }
        }
    }
    
    func connectToFirebase(name: String, email: String, provider: String, credential: AuthCredential){
        
        AuthService.instance.logInUserToFirebase(credential: credential, handler: {(returnedProviderID, isError,isNewUser,returnedUserId) in
            
            if let newUser = isNewUser {
                
                if newUser {
                    // NEW USER
                    if let providerID = returnedProviderID, !isError {
                        // SUCCESS
                        
                        // New User, continue to the onboading part2
                        self.displayName = name
                        self.email = email
                        self.providerID = providerID
                        self.provider = provider
                        self.showRegisterView.toggle()
                    } else {
                        // ERROR
                        print("Error getting into from log in user to Firebase")
                        self.showError.toggle()
                    }
                    
                } else {
                    // EXISTING USER
                    if let userID = returnedUserId {
                        // SUCCESS, LOG IN TO APP
                        AuthService.instance.logInUserToApp(userID: userID) { (success) in
                            if success {
                                print ("Successful log in existing user")
                                self.showProfileView.toggle()
                            } else {
                                print("Error getting into from log in user to Firebase")
                                self.showError.toggle()
                            }
                        }
                    } else {
                        // ERROR
                        print("Error getting into from log in user to Firebase")
                        self.showError.toggle()
                    }
                }
            } else {
                // ERROR
                print("Error getting into from log in user to Firebase")
                self.showError.toggle()
            }
        })
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
