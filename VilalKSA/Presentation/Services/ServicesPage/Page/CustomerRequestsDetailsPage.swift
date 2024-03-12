//
//  CustomerRequestsDetailsPage.swift
//  VilalKSA
//
//  Created by Elkilany on 30/01/2024.
//

import SwiftUI
import UIPilot
import CoreLocation

struct CustomerRequestsDetailsPage: View {
    
    @EnvironmentObject var pilot: UIPilot<ServicesDestination>
    @StateObject var viewModel = CustomerRequestsDetailsViewModel()
    @ObservedObject var locationManager = LocationManager()
    @State var mapDetails: Map?
    
    var requestID: String
    
    var body: some View {
        
        VilalKSAContainer(state: self.$viewModel.state,titlePage: R.string.localizable.customer_Orders_Details.localized, tryAgainAction: {
            self.viewModel.getCustomerRequestDetails(requestID: self.requestID)
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
                }
                
                VStack{
                    
                    GeometryReader { geometry in
                        VStack(alignment: .leading,spacing: 0) {
                            HStack{
                                TextBold14(textKey: R.string.localizable.customer_Details_Location.localized, textColor: R.color.colorPrimary.name.getColor())
                                Spacer()
                            }
                            if self.mapDetails != nil {
                                ShowLocationOnGoogleMapsView(locationManager: locationManager, lat:  Double(self.mapDetails?.lat ?? "") ?? 30.114892203308475 , lng: Double(self.mapDetails?.lon ?? "") ?? 31.352332457900047 )
                                    .frame(width: geometry.size.width, height: 300)
                                    .padding(4)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .padding(.horizontal, 20)
                .background(RoundedRectangle(cornerRadius: 10.0)
                    .fill(Color.white)
                    .shadow(color:Color.gray.opacity(0.2) ,radius: 10))
                .padding(.bottom,350)
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
            
        })
        .edgesIgnoringSafeArea(.all)
        .padding(.bottom,30)
        .task {
            viewModel.getCustomerRequestDetails(requestID:  self.requestID)
        }
        .onReceive(self.viewModel.$mapDetails) { mapDetails in
            self.mapDetails = mapDetails
        }
    }
}


#Preview{
    CustomerRequestsDetailsPage(requestID: "1")
}
