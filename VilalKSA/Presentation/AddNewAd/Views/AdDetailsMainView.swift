//
//  AdDetailsMainView.swift
//  VilalKSA
//
//  Created by Elkilany on 23/02/2024.
//

import SwiftUI


struct AdDetailsMainView: View {
    
    let mainInfo: MainAdDetails?
    let mapInfo: Map?
    
    init(mainInfo: MainAdDetails?, mapInfo: Map?) {
        self.mainInfo = mainInfo
        self.mapInfo = mapInfo
    }
    
    var body: some View {
        HStack{
            
            VStack(alignment:.leading){
                PropertyCategoryView(propertyCategory: (mainInfo?.category ?? "") )
                TextBold16(text: (mainInfo?.name ?? "" ), textColor: R.color.colorPrimary.name.getColor())
                HStack{
                    TextBold12(text:(mainInfo?.price ?? ""), textColor: R.color.colorPrimary.name.getColor())
                        .padding(.horizontal,-4)
                    TextBold12(textKey:R.string.localizable.saR.localized, textColor: R.color.colorPrimary.name.getColor())
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


