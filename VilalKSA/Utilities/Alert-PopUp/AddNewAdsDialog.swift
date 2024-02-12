//
//  AddNewAdsDialog.swift
//  VilalKSA
//
//  Created by Elkilany on 10/02/2024.
//

import SwiftUI
import UIPilot

struct AddNewAdsDialog: View {
    @EnvironmentObject var pilot: UIPilot<AddRequestDestination>
    @EnvironmentObject var addNewAdsPilot: UIPilot<AddRequestDestination>

        var body: some View {
        
            VStack{
                Button(action: {
                    addNewAdsPilot.push(.addNewAdCategoryPage)
                }, label: {
                    AddNewAdsCellView(title: R.string.localizable.add_New_Ad.localized, subTitle: R.string.localizable.display_Your_Property.localized, image: R.image.location_add_home.name)
                        .padding(.horizontal,20)
                })

                Button(action: {
                    pilot.push(.services)
                }, label: {
                    AddNewAdsCellView(title: R.string.localizable.add_Request.localized, subTitle: R.string.localizable.register_Your_Request.localized, image: R.image.add_Request_home.name)
                        .padding(.horizontal,20)
                })
    }
            
        .frame(maxWidth: .infinity,maxHeight: 280)
        .background(Color.white.cornerRadius(15))
        .shadowedStyle()
        .padding(.horizontal,20)
    }
}

#Preview{
    AddNewAdsDialog()
}




struct AddNewAdsCellView: View {
    let title: LocalizedStringKey
    let subTitle: LocalizedStringKey
    let image: String
    var body: some View {
        HStack(alignment:.top){
            Image(image)
                .resizable()
                .frame(width: 35, height: 35, alignment: .center)
            VStack(alignment:.leading,spacing: 0){
                TextBold14(text: title, textColor: R.color.color172B4D.name.getColor())
                    .multilineTextAlignment(.leading)
                TextRegular14(text: subTitle, textColor: R.color.color7A869A.name.getColor())
                    .multilineTextAlignment(.leading)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(12)
        .border(Color.gray.opacity(0.4), width: 0.5)
//        background(
//        RoundedRectangle(cornerRadius: 10)
//            .stroke(Color.gray.opacity(0.4), lineWidth: 0.5))
        
    }
}
