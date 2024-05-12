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
            
            TextBold18(textKey: item?.mainTitle ?? "" , textColor: R.color.colorPrimary.name.getColor())
            TextRegular16(textKey: item?.subTitle ?? "", textColor: R.color.color172B4D.name.getColor())
            
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
        .padding(.horizontal,20)
    }
}





struct GuestAlertDialog: View {
    
    var onClose: () -> Void
    let trueAction: (()-> Void)?
    var haveCancelButton: Bool = false
    var body: some View {
        
        VStack {
            Image(R.image.noInternet.name)
                .resizable()
                .frame(width: 25, height: 25)
            
            TextBold18(textKey: R.string.localizable.youAreNotRegister.localized , textColor: R.color.colorPrimary.name.getColor())
            TextRegular16(textKey: R.string.localizable.doYouWantLogin.localized, textColor: R.color.color172B4D.name.getColor())

            HStack{
                DefaultBoarderButtonWithIcon(title: R.string.localizable.login.localized,borderColor: R.color.colorE2E8F0.name.getColor() ,backgroundColor:.clear, titleColor:R.color.colorPrimary.name.getColor() ,actionButton: {
                    trueAction?()
                })
                .frame(height: 40)
                if haveCancelButton {
                                    DefaultBoarderButtonWithIcon(title: R.string.localizable.cancel.localized,borderColor: R.color.colorE2E8F0.name.getColor() ,backgroundColor:.clear, titleColor:.red ,actionButton: {
                                        onClose()
                                    })
                                    .frame(height: 40)
                }

            }
            .padding(.horizontal,12)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.cornerRadius(15))
//        .padding(.horizontal,20)
    }
}


