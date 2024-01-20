//
//  ServicesPage.swift
//  VilalKSA
//
//  Created by Elkilany on 13/01/2024.
//

import SwiftUI

struct ServicesPage: View {
    
    @StateObject var viewModel = ServicesViewModel()
    
    let columns: [GridItem] = [
          GridItem(.flexible()),
          GridItem(.flexible())
      ]
    
    var body: some View {
        VilalKSAContainer(state: self.$viewModel.state, title: "ss",localizeTitle: "ss",padding: 10, action: {
            viewModel.getServices()
        }) {
 
            VStack{
                TextBold16(text: R.string.localizable.services.localized, textColor: R.color.colorPrimary.name.getColor())
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.servicesList,id: \.id) { item in
                        GridViewItem(icon: item.icon ?? "", title: item.name ?? "") {

                        }
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .padding(.top)
        .onAppear(perform: {
            viewModel.getServices()
            print("the services array is \(viewModel.servicesList)")
        })
    }
}

#Preview {
    ServicesPage()
}
