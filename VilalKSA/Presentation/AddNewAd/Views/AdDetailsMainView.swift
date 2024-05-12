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
                HStack{
                    PropertyCategoryView(propertyCategory: (mainInfo?.category ?? "") )
                    Spacer()
                    HStack{
                        Image(R.image.showPassword.name)
                        TextBold12(text:String(Int(mainInfo?.views ?? 0)), textColor: R.color.colorPrimary.name.getColor())
                    }
                }
//                TextBold16(text: (mainInfo?.name ?? "" ), textColor: R.color.colorPrimary.name.getColor())
                
                HStack{
                    TextBold16(text:(mainInfo?.price ?? ""), textColor: R.color.colorPrimary.name.getColor())
                        .padding(.horizontal,-4)
                    TextBold16(textKey:R.string.localizable.saR.localized, textColor: R.color.colorPrimary.name.getColor())
                }
                .padding(.horizontal)
                HStack{
                    LocationInfoView(locationName: (mapInfo?.address ?? "الرياض"))
                    Spacer()
                    TextRegular12(text:( mainInfo?.createdAt ?? "" ), textColor: R.color.color42526E.name.getColor())
                }
                .padding(.top,-4)
                
                if mainInfo?.resident != " " {
                    HStack{
                        TextBold12(textKey:R.string.localizable.rentalType.localized, textColor: R.color.colorPrimary.name.getColor())
                        TextBold12(text:"/", textColor: R.color.colorPrimary.name.getColor())
                        TextBold12(text:(mainInfo?.rental ?? ""), textColor: R.color.colorPrimary.name.getColor())
                    }
                    

                    HStack{
                        TextBold12(textKey:R.string.localizable.resident.localized, textColor: R.color.colorPrimary.name.getColor())
                        TextBold12(text:"/", textColor: R.color.colorPrimary.name.getColor())
                        TextBold12(text:(mainInfo?.resident ?? ""), textColor: R.color.colorPrimary.name.getColor())
                    }
                }
                
                
                HStack(spacing:2){
//                    TextRegular12(textKey:R.string.localizable.property_Area.localized, textColor: R.color.color172B4D.name.getColor())
//                    Spacer().frame(width: 5)
                    HStack(spacing:2) {
                        Image( R.image.view_icon.name)
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .center)
                        Spacer().frame(width: 2)
                        TextRegular12(text: mainInfo?.estateSpace ?? "" , textColor: R.color.color172B4D.name.getColor())
                    }
                    Spacer().frame(width: 2)
                    TextRegular12(textKey:R.string.localizable.one_Thousand_Meters.localized, textColor: R.color.color172B4D.name.getColor())
                    
                    
                    
                }
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


