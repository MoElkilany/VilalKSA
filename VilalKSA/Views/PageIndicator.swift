//
//  PageIndicator.swift
//  SCISP
//
//  Created by Mohamed Abdulrahman on 13/06/2023.
//

import SwiftUI

struct PageIndicator: View {
    @Binding var currentIndex: Int
    var numberOfPages: Int
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            ForEach(0..<numberOfPages, id: \.self) { index in
                RoundedRectangle(cornerRadius: index == currentIndex ? 4 : 8)
                    .frame(width: index == currentIndex ? 16 : 8, height: 8)
//                    .foregroundColor(index == currentIndex ? ColorName.color342643.color : ColorName.color342643.color)
            }
        }
        .padding(.vertical, 8)
        .animation(.easeInOut(duration: 0.3))
    }
    
}
