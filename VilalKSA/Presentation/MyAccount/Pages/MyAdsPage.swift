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
    @State var MyAdsList: [MyAdsModel]? = nil

    var body: some View {
        
        VilalKSAContainer(state: self.$viewModel.state,titlePage: R.string.localizable.my_Ads.localized, tryAgainAction: {
            viewModel.getMyAds()
        },backAction:{
            pilot.pop()
        },haveAnotherButton: true ,buttonAction:{
            print("Hello")
        },iconButton: R.image.addCircle.name ,content: {
            ZStack{
                ScrollView(showsIndicators:false){
                    ForEach(self.MyAdsList ?? [] , id: \.self ) { item in
                        MyAdsContainerView(imageUrl: item.image ?? "" , category: item.category ?? "" , name: item.name ?? "" , room: item.room ?? "" , space: String(item.space ?? 0.0), price: item.price ?? "" , location: item.address ?? "" , rental: item.rental ?? "" ,delete: {
                            self.viewModel.deleteMyAds(id: String(item.id ?? 0))
                        } ,edit: {
                            print("edit")
                        } )
                    }
                }
                if self.viewModel.deleteState == .loading {
                    OnScreenLoading
                }
            }
           
        })
        .ignoresSafeArea(.all)
        .padding(.bottom,30)
        
        .onReceive(self.viewModel.$MyAdsList, perform: { list in
            self.MyAdsList = list
        })
        .popup(isPresented: $viewModel.successBottomSheet) {
            ToastBottomSecond(title: R.string.localizable.success.localized, subTitle: viewModel.successTitle)
        } customize: {
            $0
                .type(.floater())
                .position(.bottom)
                .animation(.spring())
                .autohideIn(5)
        }
        .task {
            self.viewModel.getMyAds()
        }
        
    }
}
