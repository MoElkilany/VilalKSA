//
//  MyAccountQuickAccessView.swift
//  VilalKSA
//
//  Created by Elkilany on 07/02/2024.
//

import SwiftUI


struct MyAccountQuickAccessView: View {
    
    let items: [IconAndTitleWithActionModel]?
    
    init(items: [IconAndTitleWithActionModel]?) {
        self.items = items
    }

    let columns = [
        GridItem(.fixed(50)),
    ]
    
    var body: some View {
        VStack{
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: columns, alignment: .center, spacing: 15) {
                    ForEach(items ?? [],id:\.id ){ item in
                        Button {
                            item.action?()
                        } label: {
                            QuickAccessItem(item: item)
                                .padding(.horizontal,10)
                        }
                    }
                }
            }
        }
        .frame(height: 70)
        .padding(.vertical, 20)
        .padding(.horizontal, 20)
        .background(RoundedRectangle(cornerRadius: 10.0)
            .fill(Color.white)
            .shadow(color:Color.gray.opacity(0.2) ,radius: 10))
    }
}


private struct QuickAccessItem: View {
    var item: IconAndTitleWithActionModel?
    
    var body: some View {
        VStack(alignment:.center) {
            Image(item?.icon ?? "" )
                .resizable()
                .frame(width: 40, height: 40, alignment: .center)
            TextRegular12(text: item?.text ?? "" , textColor: R.color.color42526E.name.getColor())
        }
        .cornerRadius(8)
    }
}
