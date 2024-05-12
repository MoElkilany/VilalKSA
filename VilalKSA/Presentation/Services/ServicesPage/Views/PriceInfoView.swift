//
//  PriceInfoView.swift
//  VilalKSA
//
//  Created by Elkilany on 21/01/2024.
//

import SwiftUI

struct PriceInfoView: View {
    
    var price:  String?
    var body: some View {
        HStack{
            TextBold16(text:price ?? "$340 - $500", textColor: R.color.colorPrimary.name.getColor())
          
            TextBold16(textKey:R.string.localizable.saR.localized, textColor: R.color.colorPrimary.name.getColor())
        }
    }
}

#Preview {
    PriceInfoView()
}
