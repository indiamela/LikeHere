//
//  SignInWithAppleButtonCustom.swift
//
//  Created by Taishi Kusunose on 2021/02/22.
//

import Foundation
import SwiftUI
import AuthenticationServices

struct SignInWithAppleButtonCustom: UIViewRepresentable{

    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton{
        return ASAuthorizationAppleIDButton(authorizationButtonType: .default, authorizationButtonStyle: .black)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) { }
    
}
