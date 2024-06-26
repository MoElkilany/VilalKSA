//
//  PropertyKeyValueDetailsView.swift
//  VilalKSA
//
//  Created by Elkilany on 05/02/2024.
//

import SwiftUI

struct PropertyKeyValueDetailsView: View {
    
    let propertiesDetailsArray: [Detail]?
    
    init(propertiesDetailsArray: [Detail]?) {
        self.propertiesDetailsArray = propertiesDetailsArray
    }
    
    var body: some View {
        VStack{
            HStack{
                TextBold14(textKey: R.string.localizable.details.localized, textColor: R.color.color172B4D.name.getColor())
                Spacer()
            }

            HStack{
                TextMeduim12(textKey: R.string.localizable.building.localized, textColor: R.color.color42526E.name.getColor())
                Spacer()
            }
            
            VStack{
                ForEach(propertiesDetailsArray ?? [],id:\.self ){ item  in
                    KeyValueBarView(key: LocalizedStringKey(item.name ?? ""), value: (item.value ?? ""))
                }
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 20)
            .background(RoundedRectangle(cornerRadius: 10.0)
                .fill(R.color.colorF1F5F9.name.getColor()))
            }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .padding(.vertical, 20)
        .padding(.horizontal, 20)
        .background(RoundedRectangle(cornerRadius: 10.0)
            .fill(Color.white)
            .shadow(color:Color.gray.opacity(0.2) ,radius: 10))
    }
}


struct KeyValueBarView: View {
    let key: LocalizedStringKey?
    let value: String?

    var body: some View{
        VStack(spacing:5){
            HStack{
                TextBold12(textKey:key ?? "", textColor: R.color.color172B4D.name.getColor())
                Spacer()
                TextRegular14(text: value ?? "", textColor: R.color.color42526E.name.getColor())
            }
            
            Divider().background(R.color.colorE2E8F0.name.getColor())
        }
    }
}

