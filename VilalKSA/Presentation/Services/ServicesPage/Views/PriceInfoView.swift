//
//  PriceInfoView.swift
//  VilalKSA
//
//  Created by Elkilany on 21/01/2024.
//

import SwiftUI

struct PriceInfoView: View {
    
    var price:  LocalizedStringKey?
    var body: some View {
        HStack{
            TextBold12(text:price ?? "$340 - $500", textColor: R.color.colorPrimary.name.getColor())
                .padding(.horizontal,-4)
            TextBold12(text:R.string.localizable.saR.localized, textColor: R.color.colorPrimary.name.getColor())
        }
    }
}

#Preview {
    PriceInfoView()
}
