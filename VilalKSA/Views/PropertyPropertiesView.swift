//
//  PropertyPropertiesView.swift
//  VilalKSA
//
//  Created by Elkilany on 06/02/2024.
//

import SwiftUI

struct PropertyPropertiesView: View {
    
    let items: [ProperitesModel]?
    
    init(items: [ProperitesModel]?) {
        self.items = items
    }
    
    let columns = [
        GridItem(.fixed(50)),
        GridItem(.fixed(50)),
    ]
    
    var body: some View {
        VStack{
            HStack{
                TextMeduim12(textKey: R.string.localizable.properties.localized, textColor: R.color.color42526E.name.getColor())
                Spacer()
            }
            VStack{
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: columns, alignment: .center, spacing: 15) {
                        ForEach(items ?? [],id:\.name ){ item in
                            PropertyPropertiesItem(item: item)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            .padding(.vertical, 20)
            .padding(.horizontal, 20)
            .background(RoundedRectangle(cornerRadius: 10.0)
                .fill(R.color.colorF1F5F9.name.getColor()))
        }
        .frame(maxWidth: .infinity)
        
        .padding(.vertical, 20)
        .padding(.horizontal, 20)
        .background(RoundedRectangle(cornerRadius: 10.0)
            .fill(Color.white)
            .shadow(color:Color.gray.opacity(0.2) ,radius: 10))
    }
}



private struct PropertyPropertiesItem: View {
    var item: ProperitesModel?
    
    var body: some View {
        HStack(alignment:.center) {
            URLImage(imageUrl: item?.icon
                     ,imageWidth: 15,imageHeight: 15)
            TextBold12(text: item?.name ?? "" , textColor: R.color.color42526E.name.getColor())
        }
        .cornerRadius(8)
    }
}


