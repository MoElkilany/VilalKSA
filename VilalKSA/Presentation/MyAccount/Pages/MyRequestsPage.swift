//
//  MyRequestsPage.swift
//  VilalKSA
//
//  Created by Elkilany on 08/02/2024.
//
import SwiftUI
import UIPilot

struct MyRequestsPage: View {
    
    @StateObject var viewModel = MyRequestsViewModel()
    @EnvironmentObject var pilot: UIPilot<MyAccountDestination>
    
    var body: some View {
        
        VilalKSAContainer(state: self.$viewModel.state,titlePage: R.string.localizable.my_Requests.localized, tryAgainAction: {
            //            viewModel.getTodayAds()
        },backAction:{
            pilot.pop()
        },haveAnotherButton: true ,buttonAction:{
            print("Hello")
        },iconButton: R.image.addCircle.name ,content: {
            ScrollView(showsIndicators:false){
                ForEach(0..<10, id: \.self ) { item in
                    MyRequestsContainerView(propertyName: "شقة للايجار ", propertyCategory: "فيلا", propertyAddress: "المنصورة المشاية كوبري طلخا", propertyPrice: "837", propertyRental: "Daily") {
                        print("cancel request action ")
                    }
                }
            }
        })
        .ignoresSafeArea(.all)
        .padding(.bottom,50)
        .onAppear(perform: {
            //            viewModel.getTodayAds()
        })
        
    }
}
