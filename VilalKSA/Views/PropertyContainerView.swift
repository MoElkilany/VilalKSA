//
//  PropertyContainerView.swift
//  VilalKSA
//
//  Created by Elkilany on 31/01/2024.
//

import SwiftUI

struct PropertyContainerView: View {
    
    let imageUrl: String?
    let rate: String?
    let category: String?
    let name: String?
    let room: String?
    let space: String?
    let price: String?
    let favourite: Bool?
    let location: String?
    let rental: String?
    let addOrRemoveFavouriteAction: (()->())?

    var body: some View {
        PropertyBarView(imageUrl: imageUrl, rate: rate, category: category, name: name, room: room, space: space, price: price, favourite: favourite, location: location, rental: rental,addOrRemoveFavouriteAction: addOrRemoveFavouriteAction)
        
            .background(RoundedRectangle(cornerRadius: 15.0)
                .fill(Color.white)
                .shadow(color:Color.gray.opacity(0.2) ,radius: 10))
            .padding(.horizontal, 15)
            .padding(.top, 15)
    }
}


struct PropertyBarView: View {
    let imageUrl: String?
    let rate: String?
    let category: String?
    let name: String?
    let room: String?
    let space: String?
    let price: String?
    let favourite: Bool?
    let location: String?
    let rental: String?
    let addOrRemoveFavouriteAction: (()->())?
    
    init(imageUrl: String?, rate: String?, category: String?, name: String?, room: String?, space: String?, price: String?, favourite: Bool?, location: String?, rental: String?, addOrRemoveFavouriteAction: ( () -> Void)?) {
        self.imageUrl = imageUrl
        self.rate = rate
        self.category = category
        self.name = name
        self.room = room
        self.space = space
        self.price = price
        self.favourite = favourite
        self.location = location
        self.rental = rental
        self.addOrRemoveFavouriteAction = addOrRemoveFavouriteAction
    }
    
    @State private var isFav: Bool =  false
    
    var body: some View {
        
        HStack {
            
            ZStack{
                URLImage(imageUrl:imageUrl ?? "")
                    .cornerRadius(12)
            
                Button(action: {
                    isFav.toggle()
                    addOrRemoveFavouriteAction?()
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
//                    HStack(spacing:0) {
//                        Text(rate ?? "0.0")
//                            .font(Font.custom(FontName.cairoMedium.rawValue, size: 14))
//                        Image(systemName: "star.fill")
//                            .foregroundColor(.yellow)
//                    }
                    Spacer()
                    Spacer()
                    RealStateTypeView(realStateTypeName: (category ?? "") )
                }
                
                TextBold14(text:(name ?? "") , textColor: R.color.color172B4D.name.getColor())
                LocationInfoView(locationName: (location ?? "Vilal KSA" ) )
                HStack{
                    VilalIconWithValueView(icon: R.image.bed_icon.name, value: (room ?? ""))
                    
                    HStack(spacing:0){
                        VilalIconWithValueView(icon: R.image.view_icon.name, value: (space ?? ""))
                        TextMeduim10(textKey:R.string.localizable.one_Thousand_Meters.localized, textColor: R.color.color172B4D.name.getColor())
                    }
                    HStack{
                        TextBold12(text:(price ?? ""), textColor: R.color.colorPrimary.name.getColor())
                            .padding(.horizontal,-4)
                        TextBold12(textKey:R.string.localizable.saR.localized, textColor: R.color.colorPrimary.name.getColor())
                        
                        if self.rental?.isEmpty == true ||  self.rental == " " ||  self.rental == "" {
                            
                        }else{
                            TextBold12(text:"/", textColor: R.color.colorPrimary.name.getColor())
                            TextBold12(text:(rental ?? " - "), textColor: R.color.colorPrimary.name.getColor())
                        }
                    }
                }
            }
            .padding(.horizontal,4)
        }
        
        .onAppear {
            isFav = favourite ?? false
        }
        .padding()
    }
}




