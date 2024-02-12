//
//  AlertDialog.swift
//  VilalKSA
//
//  Created by Elkilany on 09/02/2024.
//



import Foundation
import SwiftUI

class AlertContent: Equatable {
    
    let image : String?
    let mainTitle: LocalizedStringKey?
    let subTitle: LocalizedStringKey?
    let trueAction: (()-> Void)?
    
    
    init(image: String?, mainTitle: LocalizedStringKey?, subTitle: LocalizedStringKey?, trueAction: ( () -> Void)?) {
        self.image = image
        self.mainTitle = mainTitle
        self.subTitle = subTitle
        self.trueAction = trueAction
    }
    
    
    
    static func == (lhs: AlertContent, rhs: AlertContent) -> Bool {
        return lhs.image == rhs.image &&
        lhs.mainTitle == rhs.mainTitle &&
        lhs.subTitle == rhs.subTitle
    }
}


struct AlertDialog: View {
    
    let item: AlertContent?
    var onClose: () -> Void
    
    var body: some View {
        
        VStack {
            Image(item?.image ?? "" )
                .resizable()
                .frame(width: 25, height: 25)
            
            TextBold18(text: item?.mainTitle ?? "" , textColor: R.color.colorPrimary.name.getColor())
            TextRegular16(text: item?.subTitle ?? "", textColor: R.color.color172B4D.name.getColor())
            
            HStack{
                DefaultBoarderButtonWithIcon(title: R.string.localizable.oK.localized,borderColor: R.color.colorE2E8F0.name.getColor() ,backgroundColor:.clear, titleColor:R.color.colorPrimary.name.getColor() ,actionButton: {
                    item?.trueAction?()
                })
                .frame(height: 40)
                
                DefaultBoarderButtonWithIcon(title: R.string.localizable.cancel.localized,borderColor: R.color.colorE2E8F0.name.getColor() ,backgroundColor:.clear, titleColor:.red ,actionButton: {
                    onClose()
                })
                .frame(height: 40)
            }
            .padding(.horizontal,12)
            
        }
        
       
        .frame(height: 200)
        .background(Color.white.cornerRadius(15))
        .shadowedStyle()
        .padding(.horizontal,20)
    }
}


