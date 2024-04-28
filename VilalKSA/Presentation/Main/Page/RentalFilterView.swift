//
//  RentalFilterView.swift
//  VilalKSA
//
//  Created by Elkilany on 21/04/2024.
//

import SwiftUI

struct RentalFilterView: View {

       var body: some View {
           HStack(spacing:40) {
               FilterIconWithValueView(icon: R.image.allAds_Filter.name, valueLocalized: R.string.localizable.all.localized, isSelected: true )
               FilterIconWithValueView(icon: R.image.forRental_Filter.name, valueLocalized: R.string.localizable.for_Rent.localized,isSelected: true )
               FilterIconWithValueView(icon: R.image.forSale_Filter.name, valueLocalized: R.string.localizable.for_Sale.localized ,isSelected: true )
           }
            .customCardStyle()
       }
    
}

#Preview {
    RentalFilterView()
}


struct FilterIconWithValueView: View {
    var icon:String?
    var valueLocalized:LocalizedStringKey?
    var isSelected:Bool
    var body: some View {
        VStack(spacing:4){
            HStack(spacing:4) {
                Image(icon ?? R.image.bed_icon.name)
                    .resizable()
                    .frame(width: 15, height: 15, alignment: .center)
                TextRegular14(textKey: valueLocalized ?? "0", textColor: R.color.color172B4D.name.getColor())
            }
            if isSelected {
                Rectangle()
                    .padding(.horizontal,8)
                          .frame(height: 2)
                          .cornerRadius(1)
                          .foregroundColor(R.color.colorPrimary.name.getColor())
            }
            
        }
    }
}

