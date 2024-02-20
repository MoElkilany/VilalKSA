//
//  CustomerRequestsPage.swift
//  VilalKSA
//
//  Created by Elkilany on 21/01/2024.
//

import SwiftUI
import UIPilot

struct CustomerRequestsPage: View {
    
    @StateObject var viewModel = CustomerRequestsViewModel()
    @EnvironmentObject var pilot: UIPilot<ServicesDestination>
    
    var body: some View {
        
        VilalKSAContainer(state: self.$viewModel.state,titlePage: R.string.localizable.customer_Orders.localized, tryAgainAction: {
            viewModel.getCustomerRequests()
        },backAction:{
            pilot.pop()
        } ,content: {
            ScrollView{
                ForEach(self.viewModel.customerRequestsList, id: \.id) { modelValue in
                    Button(action: {
                        pilot.push(.customeRequestDetails(id: String(modelValue.id ?? 1)))
                    }, label: {
                        CustomerOrdersCard(customerOrderModel: modelValue)
                    })
                }
            }
            .padding(.bottom,50)
        })
        .edgesIgnoringSafeArea(.all)
        .padding(.top,20)
        .onAppear(perform: {
            if self.viewModel.customerRequestsList.isEmpty == true{
                viewModel.getCustomerRequests()
            }
         
        })
        
    }
}

#Preview {
    CustomerRequestsPage()
}


