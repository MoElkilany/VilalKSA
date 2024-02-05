//
//  CodeCountryView.swift
//  VilalKSA
//
//  Created by Elkilany on 14/12/2023.
//

import SwiftUI

 struct CodeCountryView: View {
    let  countryCode: String?
    let  countyFlag: UIImage?
    
    var body: some View {
        HStack{
            Text( countryCode  ?? "")
            
            Image(uiImage:  countyFlag  ?? UIImage() )
                .resizable()
                .scaledToFit()
                .frame(width: 32.0, height: 32.0)
            
            Image(R.image.dropDown_icon.name)
                .resizable()
                .frame(width: 18,height: 18)
            
        }
        .frame(maxWidth: 120, maxHeight: 50, alignment: .center)
        .background( R.color.colorF7F8F8.name.getColor() )
        .cornerRadius( 25)
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke( Color.clear )
        )
        .padding(.trailing)
    }
}
