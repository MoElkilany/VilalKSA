//
//  CustomerRequestsDetailsPage.swift
//  VilalKSA
//
//  Created by Elkilany on 30/01/2024.
//

import SwiftUI
import UIPilot

struct CustomerRequestsDetailsPage: View {
    
    @EnvironmentObject var pilot: UIPilot<ServicesDestination>
    @StateObject var viewModel = CustomerRequestsDetailsViewModel()
    var requestID: String
    
    var body: some View {
        VilalKSAContainer(state: self.$viewModel.state,titlePage: R.string.localizable.customer_Orders_Details.localized, tryAgainAction: {
        },backAction:{
            pilot.pop()
        } ,content: {
            ScrollView{
                VStack{
                    CustomerOrdersCard(customerOrderModel: self.viewModel.customerRequestDetailsModel)
                    VStack{
                        HStack{
                            TextBold14(text: R.string.localizable.customer_Details_Location.localized, textColor: R.color.colorPrimary.name.getColor())
                            Spacer()
                        }
                        Image(R.image.mapsicleMap.name)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(20)
                            .frame(width: 300, height: 200, alignment: .center)
                    }
                    .padding()
                    
                    HStack{
                        
                        DefaultBoarderButtonWithIcon(title: R.string.localizable.customer_Details_Submit_Offer.localized,borderColor: .clear ,backgroundColor:R.color.colorPrimary.name.getColor(), titleColor:.white ,actionButton: {
                        })
                        .frame(height: 40)
                        
                        
                        
                        DefaultBoarderButtonWithIcon(title: R.string.localizable.customer_Details_Skip.localized,borderColor: .gray.opacity(0.5) ,backgroundColor: .white, titleColor: R.color.color7A869A.name.getColor() ,actionButton: {
                        })
                        .frame(height: 40)
                        
                    }
                    .padding(.horizontal,25)
                }
            }
        })
        .edgesIgnoringSafeArea(.all)
        .padding(.top)
        .onAppear(perform: {
            viewModel.getCustomerRequestDetails(requestID: self.requestID)
        })
    }
}



#Preview{
    CustomerRequestsDetailsPage(requestID: "1")
}
