//
//  SquareAnimate.swift
//  VilalKSA
//
//  Created by Elkilany on 13/03/2024.
//

import SwiftUI

enum Animation {
    
    case first (CGFloat)
    case second (CGFloat)
    case third (CGFloat)
    
    mutating func next() {
        switch self {
        case .first:
            self = .second(200)
        case .second:
            self = .third(300)
        case .third:
            self = .first(400)
        }
    }
    
    var resize: CGFloat {
        switch self {
        case    .first(let resize),
                .second(let resize),
                .third(let resize) :
            return resize
        }
    }
    
    var isSecond: Bool {
        switch self {
        case .second:
            return true
        default:
            return false
        }
    }
    
    var isThird: Bool {
        switch self {
        case .third:
            return true
        default:
            return false
        }
    }
}

struct SquareAnimate: View {
    @Binding var Height: CGFloat
    @Binding var heightSecond: CGFloat
    
    @State var animation: Animation = .first(200)
    
    var body: some View {

        ZStack {
            
            RoundedRectangle(cornerRadius: 2, style: .circular)
                .frame(width: 30, height: 25)
                .foregroundColor(.black)
                //.cornerRadius(5)
            
            Rectangle()
                .frame(width: 30, height: 2)
                .offset(x: animation.isSecond ? 0 : 30)
            Rectangle()
                .frame(width: 2, height: 20)
                .offset(y: animation.isSecond ? 0 : 25)
            
            Rectangle()
                .frame(width: 2, height: 20)
                .offset(x: 5, y: animation.isThird ? 0 : 25)
            Rectangle()
                .frame(width: 2, height: 20)
                .offset(x: -5, y: animation.isThird ? 0 : -25)
            
            Rectangle()
                .frame(width: 30, height: 2)
                .offset(x: animation.isThird ? 0 : 30)
            
        }
        .clipped()
        .mask({
            RoundedRectangle(cornerRadius: 5, style: .continuous)
        })
        .foregroundColor(.white)
        .onTapGesture {
            
            withAnimation {
                animation.next()
                Height = animation.resize
                if Height == 200 {
                    heightSecond = 200
                } else if Height == 120 {
                    heightSecond = 150
                } else {
                    heightSecond = 120
                }
            }
        }
    }
}

#Preview {
    SquareAnimate(Height: .constant(200), heightSecond: .constant(200))
}
