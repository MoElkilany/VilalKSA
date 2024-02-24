//
//  SimilarAdsView.swift
//  VilalKSA
//
//  Created by Elkilany on 23/02/2024.
//

import SwiftUI

struct SimilarAdsView: View {
    @State private var isFav: Bool =  false
    var similarAdModel: SimilarAd?

    var body: some View {
        VStack(spacing: 5) {
            
            ZStack{
                URLImage(imageUrl:similarAdModel?.image ?? "" ,imageWidth: 100,imageHeight: 100)
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

            HStack{
                RealStateTypeView(realStateTypeName: similarAdModel?.category ?? ""  )
                Spacer()
                TextBold14(text:similarAdModel?.name ?? ""  , textColor: R.color.color172B4D.name.getColor())
            }
            .padding(.horizontal,2)
            LocationInfoView(locationName: similarAdModel?.address ?? ""  )
                
            HStack{
                VilalIconWithValueView(icon: R.image.bed_icon.name, value: similarAdModel?.room ?? "" )
                
                HStack(spacing:2){
                    VilalIconWithValueView(icon: R.image.view_icon.name, value: similarAdModel?.estateSpace ?? "" )
                    TextMeduim10(textKey:R.string.localizable.one_Thousand_Meters.localized, textColor: R.color.color172B4D.name.getColor())
                }
                
                HStack(spacing:4){
                    TextBold12(text:similarAdModel?.price ?? "" , textColor: R.color.colorPrimary.name.getColor())
                        .padding(.horizontal,-4)
                    TextBold12(textKey:R.string.localizable.saR.localized, textColor: R.color.colorPrimary.name.getColor())
                }

            }
        }
        .customCardStyle(corner: 20)
        .padding(.horizontal, 10)
        .padding(.vertical, 20)

  
    }
}

#Preview {
    SimilarAdsView()
}
