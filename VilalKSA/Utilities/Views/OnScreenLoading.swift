//
//  OnScreenLoading.swift
//  VilalKSA
//
//  Created by Elkilany on 06/01/2024.
//

import Foundation
import SwiftUI

var OnScreenLoading: some View {
 
        
    ZStack {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.white)
            .shadow(color: Color.gray.opacity(0.5), radius: 4, x: 0, y: 4)
        
        VStack(spacing: 20) {
            Loader(size: 80)
            TextBold16(text: "Loading...", textColor: R.color.colorPrimary.name.getColor())
        }
    }
    .frame(width: 140, height: 140)

}
