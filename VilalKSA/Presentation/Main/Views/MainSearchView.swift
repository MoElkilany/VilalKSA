//
//  MainSearchView.swift
//  VilalKSA
//
//  Created by Elkilany on 10/03/2024.
//

import SwiftUI

struct MainSearchView : View {
    @State private var searchText = ""

    var body: some View {
        HStack {
            TextField(R.string.localizable.search_by_Title_or_City.localized, text: $searchText)
                .padding(8)
                .font(Font.custom(FontName.cairoRegular.rawValue, size: 15))
                .foregroundColor(R.color.colorPrimary.name.getColor())
                .padding(.horizontal, 24)
                .background(.white)
                .cornerRadius(10)
                .overlay(
                    HStack {
                        Button(action: {
                            print("make search")
                        }, label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(R.color.colorPrimary.name.getColor())
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                                .padding(.trailing, 8)
                        })
                    }
                )
                .foregroundColor(.white)
            
        }
        .frame(height: 60)
    }
}
