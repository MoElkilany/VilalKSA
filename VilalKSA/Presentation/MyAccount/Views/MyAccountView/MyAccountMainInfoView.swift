//
//  MyAccountMainInfoView.swift
//  VilalKSA
//
//  Created by Elkilany on 07/02/2024.
//

import SwiftUI

struct MyAccountMainInfoView: View {
    var body: some View {
        HStack{
            URLImage(imageUrl:"https://verasign.se/ammr/public/assets/images/faces/1.jpg",imageWidth: 60, imageHeight: 60, isCliped: true )
            
            VStack(alignment: .leading, spacing:0){
                TextBold14(text:"Mohamed Elkilany", textColor: R.color.color172B4D.name.getColor())
                TextRegular12(text: LocalizedStringKey("sedikahmed@gmail.com"), textColor: R.color.color42526E.name.getColor())
            }
            Spacer()
            
            Button(action: {
                
            }, label: {
                Image(R.image.profileEdit.name)
            })
            
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

#Preview {
    MyAccountMainInfoView()
}
