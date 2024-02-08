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
            ScrollView(showsIndicators:false){
                VStack{
                    CustomerOrderDetailsMainView(mainInfo: viewModel.customerRequestDetailsModel.main , mapInfo: viewModel.customerRequestDetailsModel.map)
                        .padding(.bottom,4)
                    RequestOwnerView(ownerInfo: viewModel.customerRequestDetailsModel.owner)
                    PropertyKeyValueDetailsView(propertiesDetailsArray: viewModel.customerRequestDetailsModel.details)
                    PropertyPropertiesView(items: viewModel.customerRequestDetailsModel.properites)
                    
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
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 20)
                    .background(RoundedRectangle(cornerRadius: 10.0)
                        .fill(Color.white)
                        .shadow(color:Color.gray.opacity(0.2) ,radius: 10))
                    
                    VStack{
                        DefaultBoarderButtonWithIcon(title: R.string.localizable.contact_Advertiser.localized,borderColor: .clear ,backgroundColor:R.color.colorPrimary.name.getColor(), titleColor:.white ,actionButton: {
                        })
                        .frame(height: 50)
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 20)
                    .background(RoundedRectangle(cornerRadius: 10.0)
                        .fill(Color.white)
                        .shadow(color:Color.gray.opacity(0.2) ,radius: 10))
                    Spacer()
                }
            }
            
        })
        .edgesIgnoringSafeArea(.all)
        .padding(.bottom,30)
        .onAppear(perform: {
            viewModel.getCustomerRequestDetails(requestID:  self.requestID)
        })
    }
    
}



#Preview{
    CustomerRequestsDetailsPage(requestID: "1")
}
