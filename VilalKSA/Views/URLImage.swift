//
//  URLImage.swift
//  VilalKSA
//
//  Created by Elkilany on 05/02/2024.
//

import SwiftUI
import Kingfisher

struct URLImage: View {
    
    let imageUrl:String?
    var imageWidth: CGFloat = 100
    var imageHeight: CGFloat = 100
    var isCliped = false
    
    var body: some View {
        
        KFImage.url(URL(string: imageUrl ?? ""))
        
        
        //                   .placeholder(Image("logo"))
        //                  .setProcessor(processor)
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .onProgress { receivedSize, totalSize in  }
            .onSuccess { result in  }
            .onFailure { error in }
            .placeholder({ _ in
                if isCliped == true {
                    Image(R.image.logo.name)
                        .frame(width: imageWidth, height: imageHeight, alignment: .center)
                        .cornerRadius(imageWidth / 2 )
                }else{
                    Image(R.image.logo.name)
                        .frame(width: imageWidth, height: imageHeight, alignment: .center)
                        .cornerRadius(12)
                }
            })
            .resizable()
            .frame(width: imageWidth, height: imageHeight, alignment: .center)

        
        //        AsyncImage(url: URL(string: imageUrl ?? "")) { phase in
        ////
        //            switch phase {
        //
        //            case .success(let image):
        //
        //                if isCliped == true {
        //                    image
        //                        .resizable()
        //                        .frame(width: imageWidth, height: imageHeight, alignment: .center)
        //                        .cornerRadius(imageWidth / 2 )
        //                }else{
        //                    image
        //                        .resizable()
        //                        .frame(width: imageWidth, height: imageHeight, alignment: .center)
        //                }
        //
        //
        //            case .failure(_):
        //                if isCliped == true {
        //                    Image(R.image.logo.name)
        //                        .frame(width: imageWidth, height: imageHeight, alignment: .center)
        //                        .cornerRadius(imageWidth / 2 )
        //                }else{
        //                    Image(R.image.logo.name)
        //                        .frame(width: imageWidth, height: imageHeight, alignment: .center)
        //                        .cornerRadius(12)
        //                }
        //            case .empty:
        //                ProgressView()
        //
        //            @unknown default:
        //                if isCliped == true {
        //                    Image(R.image.logo.name)
        //                        .frame(width: imageWidth, height: imageHeight, alignment: .center)
        //                        .cornerRadius(imageWidth / 2 )
        //                }else{
        //                    Image(R.image.logo.name)
        //                        .frame(width: imageWidth, height: imageHeight, alignment: .center)
        //                        .cornerRadius(12)
        //                }
        //            }
        //        }
    }
}
