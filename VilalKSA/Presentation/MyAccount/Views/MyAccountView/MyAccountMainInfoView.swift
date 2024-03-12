//
//  MyAccountMainInfoView.swift
//  VilalKSA
//
//  Created by Elkilany on 07/02/2024.
//

import SwiftUI

struct MyAccountMainInfoView: View {
    
    let myAccountData: MyAccountModel?
    
    
    var body: some View {
        HStack{

            Image(R.image.logo.name)
                .frame(width: 60, height: 60, alignment: .center)
                .cornerRadius(30)
            
            VStack(alignment: .leading, spacing:0){
                let name = (myAccountData?.firstName ?? "  ") + (myAccountData?.secondName ?? "")
                TextBold14(text:name, textColor: R.color.color172B4D.name.getColor())
                TextRegular12(text: (myAccountData?.email ?? "  " ), textColor: R.color.color42526E.name.getColor())
                TextRegular12(text: (myAccountData?.phone ?? "  " ), textColor: R.color.color42526E.name.getColor())
            }
            Spacer()
            
//            Button(action: {
//                
//            }, label: {
//                Image(R.image.profileEdit.name)
//            })
            
        }
        
        .padding(.vertical, 20)
        .padding(.horizontal, 20)
        
        .background(RoundedRectangle(cornerRadius: 10.0)
            .fill(Color.white)
            .shadow(color:Color.gray.opacity(0.2) ,radius: 10))
        .padding(.horizontal, 20)
        .padding(.top, -80)
    }
}


