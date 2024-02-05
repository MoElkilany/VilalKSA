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
                ActivityIndicatorView(isVisible: .constant(true), type: .arcs())
                    .frame(width: size, height: size)
                    .foregroundColor(.gray.opacity(0.6))
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
