//
//  PopupMiddle.swift
//  VilalKSA
//
//  Created by Elkilany on 11/12/2023.
//

import SwiftUI


class SomeItem: Equatable {
    
    let image : String?
    let mainTitle: LocalizedStringKey
    let subTitle: LocalizedStringKey?

    init(mainTitle: LocalizedStringKey,subTitle: LocalizedStringKey?,image:String?) {
        self.mainTitle = mainTitle
        self.subTitle = subTitle
        self.image = image
    }
    
    static func == (lhs: SomeItem, rhs: SomeItem) -> Bool {
        return lhs.mainTitle == rhs.mainTitle && lhs.subTitle == rhs.subTitle && lhs.image == rhs.image
    }
}



struct PopupMiddle: View {

    let item: SomeItem?
    var onClose: () -> Void

    var body: some View {
        
        VStack(spacing: 12) {
            Image(item?.image ??  R.image.noInternet.name)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 100, maxHeight: 100)
            
            TextBold18(textKey: item?.mainTitle ?? "" , textColor: R.color.color42526E.name.getColor())
                .padding(.top, 12)
            TextRegular14(textKey: item?.subTitle ?? R.string.localizable.service_Not_Available.localized , textColor: R.color.color7A869A.name.getColor())
                .multilineTextAlignment(.center)
        }
        
        .onTapGesture {
            onClose()
        }
        
        .frame(width: 300, height: 300, alignment: .center)
        .padding(EdgeInsets(top: 37, leading: 24, bottom: 40, trailing: 24))
        .background(Color.white.cornerRadius(20))
        .shadow(radius: 0.5)
        .padding(.horizontal, 40)
    }
}






