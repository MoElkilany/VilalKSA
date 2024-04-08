//
//  RentalView.swift
//  VilalKSA
//
//  Created by Elkilany on 27/03/2024.
//

import SwiftUI

struct RentalView: View {
    var propertyPrice:String? = nil
    var showCalender: () -> Void
    @Binding var propertyPriceForOneDay:String?
    @Binding var propertyRentalDateFrom:String?
    @Binding var propertyRentalDateTo:String?

    var body: some View {
        VStack{
            if propertyPriceForOneDay == nil {
                TextBold14(textKey: R.string.localizable.please_Select_Arravial_Departure_Date.localized ,textColor: R.color.colorPrimary.name.getColor())
                    .multilineTextAlignment(.center)
            }else{
                VStack{
                    HStack(spacing:0){
                        TextBold16(textKey: R.string.localizable.duration_From.localized,textColor: R.color.color172B4D.name.getColor())
                        TextBold16(text:" ",textColor: R.color.color172B4D.name.getColor())
                        TextBold16(text:propertyRentalDateFrom, textColor: R.color.colorPrimary.name.getColor())
                        TextBold16(text:" ",textColor: R.color.color172B4D.name.getColor())
                        TextBold16(textKey: R.string.localizable.to.localized,textColor: R.color.color172B4D.name.getColor())
                        TextBold16(text:" ",textColor: R.color.color172B4D.name.getColor())
                        TextBold16(text:propertyRentalDateTo, textColor: R.color.colorPrimary.name.getColor())
                    }
                    
                    
//                    HStack(spacing:0){
//                        TextBold16(textKey: R.string.localizable.number_OF_Days.localized,textColor: R.color.color172B4D.name.getColor())
//                        TextBold16(text:" : ", textColor: R.color.colorPrimary.name.getColor())
//                        TextBold16(text:propertyPriceForOneDay, textColor: R.color.colorPrimary.name.getColor())
//                    }
                    
//                    if let propertyPrice = Double(propertyPrice ?? ""), let propertyPriceForOneDay = Double(propertyPriceForOneDay ?? "" ) {
//                        let price = propertyPrice * propertyPriceForOneDay
//                        TextBold16(text: String(price)  , textColor: R.color.colorPrimary.name.getColor())
//                        
//                    }
                }
            }
            
            DefaultBoarderButtonWithIcon(title:propertyPriceForOneDay == nil ? R.string.localizable.select_Date.localized  : R.string.localizable.book.localized  ,borderColor: .clear ,backgroundColor:R.color.colorPrimary.name.getColor(), titleColor:.white ,actionButton: {
                showCalender()
            })
            .frame(width: 200, height: 50)
        }
        .customCardStyle()
    }
}
