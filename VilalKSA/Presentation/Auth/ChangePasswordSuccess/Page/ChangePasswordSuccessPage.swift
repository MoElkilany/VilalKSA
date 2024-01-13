//
//  ChangePasswordSuccessPage.swift
//  VilalKSA
//
//  Created by Elkilany on 15/12/2023.
//

import SwiftUI
import UIPilot

struct ChangePasswordSuccessPage: View {
    
    @EnvironmentObject var pilot: UIPilot<RootDestination>

    var body: some View {
        
        VStack{
            Spacer()
            Image(R.image.successVerifyIcon.name)
                .resizable()
                .frame(maxWidth: 300, maxHeight:300, alignment: .center)
            
            TextExtraBold16(text: "The password has been changed", textColor: R.color.color172B4D.name.getColor())
                .padding(.bottom,1)
            
            TextRegular14(text: "Your password has been successfully rese", textColor: R.color.color7A869A.name.getColor())
            
            DefaultBoarderButtonWithIcon(title: "Login",borderColor: R.color.colorPrimary.name.getColor() ,backgroundColor: .white, titleColor: R.color.colorPrimary.name.getColor() ,actionButton: {
                pilot.popTo(.login)
            })
            .padding(12)
            .padding(.top, 20)
            
            Spacer()
        }
    }
}

struct ChangePasswordSuccessPage_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordSuccessPage()
    }
}
