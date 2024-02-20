//
//  MyAccountOptionsMenuView.swift
//  VilalKSA
//
//  Created by Elkilany on 07/02/2024.
//

import SwiftUI

struct MyAccountOptionsMenuView: View {
    let items: [IconAndTitleWithActionModel]?
    var body: some View {
 
        ForEach(items ?? [] ,id: \.id ){ item in
            Button(action: {
                item.action?()
            }, label: {
                OptionsItemView(item: item)
            })
        }
    }
}


struct OptionsItemView: View {
    var item: IconAndTitleWithActionModel?

    var body: some View {
        HStack{
            Image(item?.icon ?? "" )
                .frame(width: 20, height: 20, alignment: .center)
            
            TextRegular14(textKey: item?.text ?? "" , textColor: R.color.color172B4D.name.getColor())
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

#Preview {
    OptionsItemView()
}
