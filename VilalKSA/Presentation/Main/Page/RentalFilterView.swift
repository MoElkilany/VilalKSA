//
//  RentalFilterView.swift
//  VilalKSA
//
//  Created by Elkilany on 21/04/2024.
//

import SwiftUI

struct Rent: Hashable {
    var name: LocalizedStringKey
    var id: String
    var image: String
    var selectedImage: String
    
    func hash(into hasher: inout Hasher) {
           hasher.combine(image)
           hasher.combine(selectedImage)
       }
}

struct SegmentedView: View {

    let rentalArr: [Rent] = [
        Rent(name: R.string.localizable.all.localized, id: "", image: R.image.allAds_Filter.name, selectedImage:  R.image.allAds_Filter_Blue.name),
        Rent(name: R.string.localizable.for_Rent.localized, id: "2", image: R.image.forRental_Filter.name, selectedImage:  R.image.forRental_Filter_blue.name),
        Rent(name: R.string.localizable.for_Sale.localized, id: "1", image: R.image.forSale_Filter.name, selectedImage:  R.image.forSale_Filter_blue.name)
    ]

    @State private var selected: LocalizedStringKey = R.string.localizable.all.localized
    @Namespace var name
    var getFilterID: ((String)->Void)
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(rentalArr, id: \.self) { segment in
                Button {
                    getFilterID(segment.id)
                    selected = segment.name
                } label: {
                    VStack(spacing: 4){
                        HStack{
                            TextBold14(textKey:segment.name, textColor:selected == segment.name ?  R.color.colorPrimary.name.getColor() : Color(uiColor: .systemGray)  )
                            Image(selected == segment.name ?  segment.selectedImage : segment.image )
                                .resizable()
                                .frame(width: 20 , height: 20, alignment: .center)
                        }
                        ZStack {
                            Capsule()
                                .fill(Color.clear)
                                .frame(height: 2)
                            if selected == segment.name {
                                Capsule()
                                    .fill(R.color.colorPrimary.name.getColor())
                                    .frame(height: 2)
                                    .matchedGeometryEffect(id: "Tab", in: name)
                            }
                        }
                    }
                }
            }
        }
    }
}
