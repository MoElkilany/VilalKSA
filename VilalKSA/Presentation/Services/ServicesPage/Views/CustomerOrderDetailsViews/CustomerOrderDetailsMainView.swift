//
//  CustomerOrderDetailsMainView.swift
//  VilalKSA
//
//  Created by Elkilany on 05/02/2024.
//

import SwiftUI

struct CustomerOrderDetailsMainView: View {
    
    let mainInfo: Main?
    let mapInfo: Map?
    
    init(mainInfo: Main?, mapInfo: Map?) {
        self.mainInfo = mainInfo
        self.mapInfo = mapInfo
    }
    
    var body: some View {
        HStack{
            
            VStack(alignment:.leading){
                PropertyCategoryView(propertyCategory: (mainInfo?.category ?? "") )
                TextBold16(text: (mainInfo?.name ?? "" ), textColor: R.color.colorPrimary.name.getColor())
                HStack{
                    PriceInfoView(price: mainInfo?.price ?? "")

                    // VilalHelper.getFromToPrice(fromPrice: mainInfo?.price?.from ?? "", toPrice:  mainInfo?.price?.to ?? ""))
                    TextBold16(text:"/", textColor: R.color.colorPrimary.name.getColor())
                    TextBold16(text:(mainInfo?.rental ?? ""), textColor: R.color.colorPrimary.name.getColor())
                  }
                HStack{
                    TextBold16(textKey:R.string.localizable.resident.localized, textColor: R.color.colorPrimary.name.getColor())
                    TextBold16(text:"/", textColor: R.color.colorPrimary.name.getColor())
                    TextBold16(text:(mainInfo?.resident ?? ""), textColor: R.color.colorPrimary.name.getColor())
                }
                HStack{
                    LocationInfoView(locationName: (mapInfo?.address ?? "الرياض"))
                    Spacer()
                    TextRegular12(text:( mainInfo?.createdAt ?? "" ), textColor: R.color.color42526E.name.getColor())
                }
                .padding(.top,-4)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)

        .padding(.vertical, 20)
        .padding(.horizontal, 20)
        .background(RoundedRectangle(cornerRadius: 10.0)
            .fill(Color.white)
            .shadow(color:Color.gray.opacity(0.2) ,radius: 10))
       
        
    }
}




