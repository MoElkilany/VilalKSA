//
//  CanceledMyReservationView.swift
//  VilalKSA
//
//  Created by Elkilany on 08/02/2024.
//

import SwiftUI

struct CanceledMyReservationContainerView: View {
    
    let model: MyReservationModel
    let rebooking: (()->())?
    
    var body: some View {
        CanceledMyReservationView(model: model,rebooking: rebooking)
            .background(RoundedRectangle(cornerRadius: 15.0)
                .fill(Color.white)
                .shadow(color:Color.gray.opacity(0.2) ,radius: 10))
            .padding(.horizontal, 15)
            .padding(.top, 15)
    }
}


struct CanceledMyReservationView: View {
    let model: MyReservationModel
    let rebooking: (()->())?
    
    @State private var isFav: Bool =  false
    
    var body: some View {
        
        VStack{
            HStack {
                
                ZStack{
                    URLImage(imageUrl:model.imageUrl ?? "")
                        .cornerRadius(12)
                    
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
                        HStack(spacing:0) {
                            Text(model.rate ?? "0.0")
                                .font(Font.custom(FontName.cairoMedium.rawValue, size: 14))
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                        Spacer()
                        Spacer()
                        RealStateTypeView(realStateTypeName: (model.category ?? "") )
                    }
                    
                    TextBold14(text:(model.name ?? "") , textColor: R.color.color172B4D.name.getColor())
                    LocationInfoView(locationName: (model.location ?? "Vilal KSA" ) )
                    HStack{
                        VilalIconWithValueView(icon: R.image.bed_icon.name, value: (model.room ?? ""))
                        VilalIconWithValueView(icon: R.image.view_icon.name, value: (model.space ?? ""))
                        HStack{
                            TextBold12(text:(model.price ?? ""), textColor: R.color.colorPrimary.name.getColor())
                                .padding(.horizontal,-4)
                            TextBold12(textKey:R.string.localizable.saR.localized, textColor: R.color.colorPrimary.name.getColor())
                            TextBold12(text:"/", textColor: R.color.colorPrimary.name.getColor())
                            TextBold12(text:(model.rental ?? ""), textColor: R.color.colorPrimary.name.getColor())
                        }
                    }
                }
            }
            
            DefaultBoarderButtonWithIcon(title: R.string.localizable.rebooking.localized,borderColor: R.color.colorE2E8F0.name.getColor() ,backgroundColor:.clear, titleColor:R.color.colorPrimary.name.getColor() ,actionButton: {
                rebooking?()
            })
            .frame(height: 40)
            
        }
        .onAppear {
            isFav = model.favourite ?? false
        }
        .padding()
    }
}
