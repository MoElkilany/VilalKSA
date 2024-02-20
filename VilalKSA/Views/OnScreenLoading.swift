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
        
        VStack(spacing: 5) {
            Loader(size: 80)
            TextRegular12(textKey: R.string.localizable.loading.localized, textColor: R.color.colorPrimary.name.getColor())
        }
    }
    .frame(width: 140, height: 140)
}



struct AppLoader<Content: View>: View {
    
    var size: Double = 70
    var content: Content
    
    @StateObject var loading = Loading()
    
    init(size: Double = 70, content: () -> Content) {
        self.content = content()
        self.size = size
    }
    
    var body: some View {
        ZStack {
            content
                .environmentObject(loading)
            
            if loading.isLoading ?? false {
                HStack {
                    OnScreenLoading
                }
                .frame(width: 100, height: 100)
                .background(Color.white.opacity(0.5))
                .cornerRadius(20)
            }
            
        }
    }
}

class Loading: ObservableObject {
    @Published var isLoading: Bool? {
        didSet {
            print("isLoading updated to: \(String(describing: isLoading))")
        }
    }
}
