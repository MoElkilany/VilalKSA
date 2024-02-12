//
//  SelectedImagesCard.swift
//  VilalKSA
//
//  Created by Elkilany on 12/02/2024.
//


import SwiftUI

struct SelectedImagesCard: View {
    
    @Binding var images: [UIImage]
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(images.indices, id: \.self) { index in
                        ZStack(alignment: .topTrailing) {
                            Image(uiImage: images[index])
                                .resizable()
                                .frame(width: 100, height: 100)
                                .cornerRadius(10)
                            
                            removeButton(for: index)
                                .padding(.top, -5)
                                .padding(.trailing, -5)
                        }
                        .frame(width: 100, height: 110)

                    }
                }
                .padding(.horizontal)
            }
            .frame(width: 350, height: 150)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
            .padding(.horizontal)
        }
        
    }
    
     func removeButton(for index: Int) -> some View {
        Button(action: {
        images.remove(at: index)
        }) {
            Image(systemName: "minus.circle.fill")
                .foregroundColor(.red)
        }
//        .offset(x: 45, y: -45)
    }
}


#Preview {
    SelectedImagesCard(images: .constant([UIImage(named: "digital_library_image")!]))
}
