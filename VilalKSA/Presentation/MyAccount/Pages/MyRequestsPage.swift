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
    @State var myRequestsList: [MyRequestModel]? = nil

    var body: some View {
        
        VilalKSAContainer(state: self.$viewModel.state,titlePage: R.string.localizable.my_Requests.localized, tryAgainAction: {
         viewModel.getMyRequest()
        },backAction:{
            pilot.pop()
        },haveAnotherButton: true ,buttonAction:{
            print("Hello")
        },iconButton: R.image.addCircle.name ,content: {
            ZStack{
                
                ScrollView(showsIndicators:false){
                    ForEach(self.myRequestsList ?? [] , id: \.self ) { item in
                        MyRequestsContainerView(propertyName: item.name ?? "" , propertyCategory: item.category ?? "", propertyAddress: item.address ?? "" , propertyPrice: "\(item.price?.from ?? "") - \(item.price?.to ?? "")" , propertyRental: item.rental ?? "") {
                            self.viewModel.deleteMyRequest(id: String(item.id ?? 0 ) )
                        } edit: {
                            print("edit")
                        }
                        
                    }
                }
                
                if self.viewModel.deleteState == .loading {
                    OnScreenLoading
                }
            }
            
        })
        .ignoresSafeArea(.all)
        .padding(.bottom,20)

        .onReceive(self.viewModel.$myRequestList, perform: { list in
            self.myRequestsList = list
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
            viewModel.getMyRequest()
        }
        
    }
}
