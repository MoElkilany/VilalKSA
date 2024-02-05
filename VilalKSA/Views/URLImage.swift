//
//  URLImage.swift
//  VilalKSA
//
//  Created by Elkilany on 05/02/2024.
//

import SwiftUI

struct URLImage: View {
    
    let imageUrl:String?
    var imageWidth: CGFloat = 100
    var imageHeight: CGFloat = 100
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl ?? "")) { phase in
            switch phase {
            case .success(let image):
                image
                    .frame(width: imageWidth, height: imageHeight, alignment: .center)
            case .failure(_):
                Image(R.image.logo.name)
                    .frame(width: imageWidth, height: imageHeight, alignment: .center)
                    .cornerRadius(12)
            case .empty:
                ProgressView()
            @unknown default:
                Image(R.image.logo.name)
                    .frame(width: imageWidth, height: imageHeight, alignment: .center)
                    .cornerRadius(12)
            }
        }
    }
}
