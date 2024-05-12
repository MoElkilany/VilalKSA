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
    @EnvironmentObject var myAccountPilot: UIPilot<MyAccountDestination>

    @StateObject var viewModel = CustomerRequestsDetailsViewModel()
    @ObservedObject var locationManager = LocationManager()
    @State var mapDetails: Map?
    @State private var showPassportActionSheet = false
    var requestID: String
    var isMyResuest = false
    
    var body: some View {
        
        VilalKSAContainer(state: self.$viewModel.state,titlePage: R.string.localizable.customer_Orders_Details.localized, tryAgainAction: {
            self.viewModel.getCustomerRequestDetails(requestID: self.requestID)
        },backAction:{
            if isMyResuest {
                myAccountPilot.pop()
            }else{
                pilot.pop()
            }
            
        } ,content: {
            ScrollView(showsIndicators:false){
                VStack{
                    CustomerOrderDetailsMainView(mainInfo: viewModel.customerRequestDetailsModel.main , mapInfo: viewModel.customerRequestDetailsModel.map)
                        .padding(.bottom,4)
                    RequestOwnerView(ownerInfo: viewModel.customerRequestDetailsModel.owner)
                    PropertyKeyValueDetailsView(propertiesDetailsArray: viewModel.customerRequestDetailsModel.details)
                    PropertyPropertiesView(items: viewModel.customerRequestDetailsModel.properites)
                }
                
                ZStack{
                    VStack{
                    }
                    .frame(height: 350)
                    .customCardStyle()

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
                                        .cornerRadius( 40)
                                }
                            }
                        }
                    }
                    .padding()
                }

                if isMyResuest == false {
                    VStack{
                        DefaultBoarderButtonWithIcon(title: R.string.localizable.contact_Advertiser.localized,borderColor: .clear ,backgroundColor:R.color.colorPrimary.name.getColor(), titleColor:.white ,actionButton: {
                            self.showPassportActionSheet = true
                        })
                        .frame(height: 50)
                    }
                    .customCardStyle()
                    Spacer()
                }
            }
        })
        .edgesIgnoringSafeArea(.all)
        .padding(.bottom,30)
        .onAppear {
            viewModel.getCustomerRequestDetails(requestID:  self.requestID)
        }
        .onReceive(self.viewModel.$mapDetails) { mapDetails in
            self.mapDetails = mapDetails
        }
        .actionSheet(isPresented: $showPassportActionSheet) {
            getActionSheet()
        }
    }
    
    private func getActionSheet() -> ActionSheet {
        
        return ActionSheet(
            title: Text(R.string.localizable.contact_Advertiser.localized),
            message: nil,
            buttons: [

                .default(Text(R.string.localizable.whatsApp.localized)) {
                    VilalHelper.openWhatsApp(urlString: viewModel.customerRequestDetailsModel.owner?.whatsapp ?? "")
                    showPassportActionSheet = false
                },
                .default(Text(R.string.localizable.call.localized)) {
                    VilalHelper.makePhoneCall(phoneNumber:viewModel.customerRequestDetailsModel.owner?.phone ?? "" )
                    showPassportActionSheet = false
                },
                .cancel()
            ]
        )
    }
}

#Preview {
    CustomerRequestsDetailsPage(requestID: "1")
}
