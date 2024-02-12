//
//  MyReservationHeaderTabsView.swift
//  VilalKSA
//
//  Created by Elkilany on 08/02/2024.
//

import SwiftUI

struct MyReservationHeaderTabsView: View {
    @Binding var selection: Int
    private let buttonTitles = [R.string.localizable.on_Going, R.string.localizable.completed, R.string.localizable.canceled]
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                ForEach(0..<buttonTitles.count, id: \.self) { index in
                    Button(action: {
                        withAnimation {
                            self.selection = index
                        }
                        
                    }) {
                        TextBold14(text: buttonTitles[index].localized, textColor: index != selection ? R.color.color7A869A.name.getColor(): R.color.colorPrimary.name.getColor())
                            .frame(maxWidth: .infinity)
                            .padding(.top, 20)
                    }
                }
            }
            
            ZStack{
                Rectangle()
                    .frame(height: 2)
                    .frame(width: UIScreen.main.bounds.width / 3)
                    .foregroundColor(R.color.colorPrimary.name.getColor())
                    .offset(x: CGFloat(Double(selection - 1)) * (UIScreen.main.bounds.width / CGFloat(buttonTitles.count )), y: 0)
                    .animation(.default)
                
                Rectangle()
                    .frame(height: 2)
                    .frame(width: UIScreen.main.bounds.width )
                    .foregroundColor(R.color.color7A869A.name.getColor().opacity(0.2))
                
                
            }
        }
    }
}

