//
//  PropertyInterfaceView.swift
//  VilalKSA
//
//  Created by Elkilany on 12/02/2024.
//


import SwiftUI

struct PropertyInterfaceView: View {
    
    @State private var selectedButton: Int? = nil
    
    let columns = [
        GridItem(.fixed(50)),
        GridItem(.fixed(50)),
        GridItem(.fixed(50)),
    ]
    
    var body: some View {
        VStack{
            HStack{
                TextMeduim12(text: R.string.localizable.properties.localized, textColor: R.color.color42526E.name.getColor())
                Spacer()
            }
            VStack{
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: columns, alignment: .center, spacing: 15) {
                        ForEach(0...20,id:\.self ){ item in
                            SelectableButton(title:"item",index: item,selectedButton: $selectedButton)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            .padding(.vertical, 20)
            .padding(.horizontal, 20)
            
        }
    }
}


struct SelectableButton: View {
    let title: String
    let index: Int
    @Binding var selectedButton: Int?

    var body: some View {
        Button(action: {
            // Toggle the selection state
            selectedButton = (selectedButton == index) ? nil : index
        }) {
            Text(title)
                .font(.system(size: 16)) // Adjust font size as needed
                .foregroundColor(selectedButton == index ? .white : .blue) // Text color depends on selection
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(selectedButton == index ? Color.blue : Color.white) // Background color depends on selection
                .cornerRadius(18) // Adjust the corner radius as needed
                .overlay(
                    RoundedRectangle(cornerRadius: 18) // Add a border with a rounded rectangle
                        .stroke(Color.blue, lineWidth: selectedButton == index ? 0 : 1) // Hide border when selected
                )
        }
    }
}

