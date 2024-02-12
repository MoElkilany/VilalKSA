//
//  MyReservationTypesView.swift
//  VilalKSA
//
//  Created by Elkilany on 08/02/2024.
//

import SwiftUI

struct MyReservationTypesView: View {
    
    @StateObject var viewModel = MyReservationsViewModel()
    
    var myReservationTypes: MyReservationTypes
    
    var body: some View {
        ScrollView {
            VStack {
                switch myReservationTypes {
                case .onGoing:
                    OnGoingReservationContainerView(model: MyReservationModel( imageUrl: "https://verasign.se/ammr/public/assets/images/faces/1.jpg", rate: "3.5", category: "فيلا للبيع", name: "فيلا ميت غراب", room: "4", space: "120", price: "2400", favourite: false, location: "المنصورة ", rental: "شهري" )) {
                        print("cancel Request")
                    } receipt: {
                        print("receipt")
                        
                    }
                    
                case .completed:
                    
                    CompletedMyReservationContainerView(model: MyReservationModel( imageUrl: "https://verasign.se/ammr/public/assets/images/faces/1.jpg", rate: "3.5", category: "فيلا للبيع", name: "فيلا ميت غراب", room: "4", space: "120", price: "2400", favourite: false, location: "المنصورة ", rental: "شهري" )) {
                        print("cancel Request")
                    } receipt: {
                        print("receipt")
                        
                    }
                case .canceled:
                    CanceledMyReservationContainerView(model: MyReservationModel( imageUrl: "https://verasign.se/ammr/public/assets/images/faces/1.jpg", rate: "3.5", category: "فيلا للبيع", name: "فيلا ميت غراب", room: "4", space: "120", price: "2400", favourite: false, location: "المنصورة ", rental: "شهري" )) {
                        print("rebooking")
                    }
                }
            }
        }
        .onAppear(perform: {
            switch myReservationTypes {
            case .onGoing:
                print("onGoing")
            case .completed:
                print("completed")
            case .canceled:
                print("canceled")
            }
        })
        
        
    }
}

