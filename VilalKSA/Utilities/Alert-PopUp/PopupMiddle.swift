//
//  PopupMiddle.swift
//  VilalKSA
//
//  Created by Elkilany on 11/12/2023.
//

import SwiftUI


class SomeItem: Equatable {
    
    let value: String
    
    init(value: String) {
        self.value = value
    }
    
    static func == (lhs: SomeItem, rhs: SomeItem) -> Bool {
        lhs.value == rhs.value
    }
}



struct PopupMiddle: View {

    let item: SomeItem
    var onClose: () -> Void

    var body: some View {
        
        VStack(spacing: 12) {
            Image("Apple-icon")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 226, maxHeight: 226)
            
            Text("Congratulations!")
                .foregroundColor(.black)
                .font(.system(size: 24))
                .padding(.top, 12)
            
            Text(item.value)
                .foregroundColor(.black)
                .font(.system(size: 16))
                .opacity(0.6)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
            
            Button("Thanks") {
                onClose()
            }
            .buttonStyle(.plain)
            .font(.system(size: 18, weight: .bold))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .padding(.horizontal, 24)
            .foregroundColor(.white)
            .background(R.color.colorPrimary.name.getColor())
            .cornerRadius(12)
        }
        .padding(EdgeInsets(top: 37, leading: 24, bottom: 40, trailing: 24))
        .background(Color.white.cornerRadius(20))
        .shadow(radius: 0.5)
        .padding(.horizontal, 40)
    }
}






