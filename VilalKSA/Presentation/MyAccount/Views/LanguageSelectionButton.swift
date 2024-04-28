//
//  LanguageSelectionButton.swift
//  VilalKSA
//
//  Created by Elkilany on 09/02/2024.
//

import SwiftUI

struct LanguageSelectionButton: View {
    
    var title: LocalizedStringKey
    var imageName: String
    var isSelected: Bool
    var actionButton: (()->Void)
    let LARGE_CIRCLE = "largecircle.fill.circle"
    let CIRCLE  = "circle"
    
    var body: some View {
        Button{
            actionButton()
        } label: {
            HStack {
                Image(imageName)
                    .resizable()
                    .frame(width: 35,height: 35)
                    .cornerRadius(22.5)
                TextBold12(textKey: title, textColor: R.color.colorPrimary.name.getColor())
                Spacer()
                Image(systemName: isSelected ?  LARGE_CIRCLE: CIRCLE)
                    .foregroundColor(R.color.colorPrimary.name.getColor())
                    .font(.system(size: 20))
            }
            
            .frame(width: 310, height: 50)
            .padding(.horizontal,20)
            .background( Color.white )
            .cornerRadius(30)
            .overlay(
                Capsule()
                    .stroke(isSelected ? R.color.colorPrimary.name.getColor() : Color.clear  , lineWidth: isSelected ? 1 : 0)
            )
        }
    }
}
