//
//  MyAdsContainerView.swift
//  VilalKSA
//
//  Created by Elkilany on 08/02/2024.
//
import SwiftUI

struct MyAdsContainerView: View {
    
    let imageUrl: String?
    let category: String?
    let name: String?
    let room: String?
    let space: String?
    let price: String?
    let location: String?
    let rental: String?
    let delete: (()->())?
    let edit: (()->())?
    
    var body: some View {
        MyAdsBarView(imageUrl: imageUrl, category: category, name: name, room: room, space: space, price: price, location: location, rental: rental,delete: delete,edit: edit )
        
            .background(RoundedRectangle(cornerRadius: 15.0)
                .fill(Color.white)
                .shadow(color:Color.gray.opacity(0.2) ,radius: 10))
            .padding(.horizontal, 15)
            .padding(.top, 15)
    }
}


struct MyAdsBarView: View {
    let imageUrl: String?
    let category: String?
    let name: String?
    let room: String?
    let space: String?
    let price: String?
    let location: String?
    let rental: String?
    let delete: (()->())?
    let edit: (()->())?
    
    var body: some View {
        
        VStack{
            HStack {
                
                ZStack{
                    URLImage(imageUrl:imageUrl ?? "")
                        .cornerRadius(12)
                }
                
                VStack(alignment: .leading,spacing: 0){
                    HStack{
                        RealStateTypeView(realStateTypeName: (category ?? "") )
                        Spacer()
                        Spacer()
                    }
                    
//                    TextBold14(text:(name ?? "") , textColor: R.color.color172B4D.name.getColor())
                    LocationInfoView(locationName: (location ?? "Vilal KSA" ) )
                    HStack{
                        VilalIconWithValueView(icon: R.image.bed_icon.name, value: (room ?? ""))
                        VilalIconWithValueView(icon: R.image.view_icon.name, value: (space ?? ""))
                        HStack{
                            TextBold12(text:(price ?? ""), textColor: R.color.colorPrimary.name.getColor())
                                .padding(.horizontal,-4)
                            TextBold12(textKey:R.string.localizable.saR.localized, textColor: R.color.colorPrimary.name.getColor())
                            if rental == " " || rental?.isEmpty == true  {
                                
                            }else{
                                TextBold12(text:"/", textColor: R.color.colorPrimary.name.getColor())
                                TextBold12(text:(rental ?? ""), textColor: R.color.colorPrimary.name.getColor())
                            }
                            
                        }
                    }
                }
            }
            HStack{
                
//                DefaultBoarderButtonWithIcon(title: R.string.localizable.edit.localized,borderColor: R.color.colorE2E8F0.name.getColor() ,backgroundColor:.clear, titleColor:R.color.colorPrimary.name.getColor() ,actionButton: {
//                    edit?()
//                })
//                .frame(height: 40)
                
                DefaultBoarderButtonWithIcon(title: R.string.localizable.delete.localized,borderColor: R.color.colorE2E8F0.name.getColor() ,backgroundColor:.clear, titleColor:.red ,actionButton: {
                    delete?()
                })
                .frame(height: 40)
            }
        }
        .padding()
    }
}


