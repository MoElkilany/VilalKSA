//
//  ActivityIndicator.swift
//  SCISP
//
//  Created by Mohamed Abdulrahman on 11/07/2023.
//

import SwiftUI
import ActivityIndicatorView


var LoaderGenericSize = 70
struct Loader: View {
    
    var size: Double = 70
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Spacer()
                ActivityIndicatorView(isVisible: .constant(true), type:.rotatingDots(count: 4))
                    .frame(width: size, height: size)
                    .foregroundColor(R.color.colorPrimary.name.getColor().opacity(0.5))
                Spacer()
            }
        }
    }
}

struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        Loader()
    }
}
