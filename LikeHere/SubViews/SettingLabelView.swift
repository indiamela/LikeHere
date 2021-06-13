//
//  SettingLabelView.swift
//  LikeHere
//
//  Created by Taishi Kusunose on 2021/06/13.
//

import SwiftUI

struct SettingLabelView: View {
    var labelText: String
    var labelImage: String
    var body: some View {
        VStack {
            HStack{
                
                Text(labelText)
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: labelImage)
            }
            
            Divider()
                .padding(.vertical,4)
        }
    }
}

struct SettingLabelView_Previews: PreviewProvider {
    static var labelText = "Profile"
    static var icon = "person.fill"

    static var previews: some View {
        SettingLabelView(labelText: labelText, labelImage: icon)
    }
}
