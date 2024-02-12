//
//  MyAdsPage.swift
//  VilalKSA
//
//  Created by Elkilany on 08/02/2024.
//

import SwiftUI
import UIPilot

struct MyAdsPage: View {
    
    @StateObject var viewModel = MyAdsViewModel()
    @EnvironmentObject var pilot: UIPilot<MyAccountDestination>
    
    var body: some View {
        
        VilalKSAContainer(state: self.$viewModel.state,titlePage: R.string.localizable.my_Ads.localized, tryAgainAction: {
            //            viewModel.getTodayAds()
        },backAction:{
            pilot.pop()
        },haveAnotherButton: true ,buttonAction:{
            print("Hello")
        },iconButton: R.image.addCircle.name ,content: {
            ScrollView(showsIndicators:false){
                ForEach(0..<10, id: \.self ) { item in
                    MyAdsContainerView(imageUrl: "https://verasign.se/ammr/public/assets/images/faces/1.jpg", category: "فيلا للبيع", name: "فيلا ميت غراب", room: "4", space: "120", price: "2400", location: "المنصورة ", rental: "شهري",delete: {
                        print("delete")
                    } ,edit: {
                        print("edit")
                    } )
                }
            }
        })
        .ignoresSafeArea(.all)
        .padding(.bottom,30)
        .onAppear(perform: {
            //            viewModel.getTodayAds()
        })
        
    }
}
