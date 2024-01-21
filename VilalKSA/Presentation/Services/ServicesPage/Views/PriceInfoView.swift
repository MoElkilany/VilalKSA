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
        TextSemiBold14(text:price ?? "$340 - $500", textColor: R.color.colorPrimary.name.getColor())
    }
}

#Preview {
    PriceInfoView()
}
