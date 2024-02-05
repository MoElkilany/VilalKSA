//
//  TodayAdsCardView.swift
//  VilalKSA
//
//  Created by Elkilany on 31/01/2024.
//

import SwiftUI

struct TodayAdsCardView: View {
    let todayModel:todayAdsValue? 
    var body: some View {
        TodayAdsContentView(todayModel: todayModel)
            .background(RoundedRectangle(cornerRadius: 15.0)
                .fill(Color.white)
                .shadow(color:Color.gray.opacity(0.2) ,radius: 10))
            .padding(.horizontal, 15)
            .padding(.top, 15)
    }
}



struct TodayAdsContentView: View {
    let todayModel:todayAdsValue?
    @State private var isFav: Bool =  false
    
    var body: some View {
        
        HStack {
            
            ZStack{
                URLImage(imageUrl:todayModel?.image ?? "")
                
                Button(action: {
                    isFav.toggle()
                }, label: {
                    Image(isFav ?  R.image.redHeart.name :  R.image.heart.name)
                    
                        .padding(6)
                        .background(Color.white)
                        .cornerRadius(30)
                        .shadow(color: .gray.opacity(0.2) ,radius: 10)
                        .padding(.trailing,60)
                        .padding(.bottom,60)
                })
            }
            
            
            
            VStack(alignment: .leading,spacing: 0){
                HStack{
                    HStack {
                        Text(String(todayModel?.rate ?? 0))
                            .font(Font.custom(FontName.cairoBold.rawValue, size: 14))
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }
                    Spacer()
                    Spacer()
                    RealStateTypeView(realStateTypeName: LocalizedStringKey(todayModel?.category ?? "") )
                    
                }
                
                TextBold14(text:LocalizedStringKey(todayModel?.name ?? "") , textColor: R.color.color172B4D.name.getColor())
                LocationInfoView()
                HStack{
                    VilalIconWithValueView(icon: R.image.bed_icon.name, value: LocalizedStringKey(todayModel?.room ?? ""))
                    VilalIconWithValueView(icon: R.image.view_icon.name, value: LocalizedStringKey(String(todayModel?.space ?? 0.0)))
                    HStack{
                        TextBold12(text:LocalizedStringKey(todayModel?.price ?? ""), textColor: R.color.colorPrimary.name.getColor())
                            .padding(.horizontal,-4)
                        TextBold12(text:R.string.localizable.saR.localized, textColor: R.color.colorPrimary.name.getColor())
                    }
                    
                    
                }
            }
            
        }
        .onAppear {
                       isFav = todayModel?.favourite ?? false
                   }
        .padding()
    }
}

