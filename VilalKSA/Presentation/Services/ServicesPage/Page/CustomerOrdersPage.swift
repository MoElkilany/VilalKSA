//
//  CustomerOrdersPage.swift
//  VilalKSA
//
//  Created by Elkilany on 21/01/2024.
//

import SwiftUI
import UIPilot

struct CustomerOrdersPage: View {
    
    @StateObject var viewModel = CustomerOrdersViewModel()
    @EnvironmentObject var pilot: UIPilot<ServicesDestination>

    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        VilalKSAContainer(state: self.$viewModel.state,titlePage: R.string.localizable.customer_Orders.localized, tryAgainAction: {
            //            viewModel.getServices()
        },backAction:{
            pilot.pop()
        } ,content: {
            ScrollView{
                ForEach(0..<10, id: \.self) { _ in
                    CustomerOrdersCard()
                }
            }
            .padding(.bottom,50)
        })
        .edgesIgnoringSafeArea(.all)
        .padding(.top)
        .onAppear(perform: {
            //            viewModel.getServices()
        })
        
    }
}

#Preview {
    CustomerOrdersPage()
}


