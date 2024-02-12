//
//  MyRequestsContainerView.swift
//  VilalKSA
//
//  Created by Elkilany on 08/02/2024.
//

import SwiftUI

struct MyRequestsContainerView: View {
    let propertyName: String?
    let propertyCategory: String?
    let propertyAddress: String?
    let propertyPrice: String?
    let propertyRental: String?
    let cancelRequest: (()->())?
    
    var body: some View {
        
        MyRequestsCardContent(propertyName: propertyName, propertyCategory: propertyCategory, propertyAddress: propertyAddress, propertyPrice: propertyPrice, propertyRental: propertyRental,cancelRequest: cancelRequest)
            .background(RoundedRectangle(cornerRadius: 15.0)
                .fill(Color.white)
                .shadow(color:Color.gray.opacity(0.2) ,radius: 10))
            .padding(.horizontal, 20)
            .padding(.top, 5)
    }
}

struct MyRequestsCardContent: View {
    let propertyName: String?
    let propertyCategory: String?
    let propertyAddress: String?
    let propertyPrice: String?
    let propertyRental: String?
    let cancelRequest: (()->())?
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    RentalInfoHeaderView(name: LocalizedStringKey(propertyName ?? ""), realStateCategory: LocalizedStringKey(propertyCategory ?? ""))
                    LocationInfoView(locationName: LocalizedStringKey(propertyAddress ?? "الرياض"))
                    HStack{
                        TextBold12(text:LocalizedStringKey(propertyPrice ?? ""), textColor: R.color.colorPrimary.name.getColor())
                        TextBold12(text:R.string.localizable.saR.localized, textColor: R.color.colorPrimary.name.getColor())
                        TextBold12(text:"/", textColor: R.color.colorPrimary.name.getColor())
                        TextBold12(text:LocalizedStringKey(propertyRental ?? ""), textColor: R.color.colorPrimary.name.getColor())
                    }
                }
            }
            
            DefaultBoarderButtonWithIcon(title: R.string.localizable.edit.localized,borderColor: R.color.colorE2E8F0.name.getColor() ,backgroundColor:.clear, titleColor:.red ,actionButton: {
               cancelRequest?()
            })
            .frame(height: 40)
        }
        .padding()
    }
}


#Preview{
    MyRequestsContainerView(propertyName: "شقة للايجار ", propertyCategory: "فيلا", propertyAddress: "المنصورة المشاية كوبري طلخا", propertyPrice: "837", propertyRental: "Daily") {
        
    }
}
