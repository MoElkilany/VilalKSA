//
//  CustomerOrdersCard.swift
//  VilalKSA
//
//  Created by Elkilany on 21/01/2024.
//

import SwiftUI

struct CustomerOrdersCard: View {
    
    var customerOrderModel: CustomerRequestsValueModel
    var body: some View {
        CardContent(customerOrderModel: customerOrderModel)
            .background(RoundedRectangle(cornerRadius: 15.0)
                .fill(Color.white)
                .shadow(color:Color.gray.opacity(0.2) ,radius: 10))
            .padding(.horizontal, 20)
            .padding(.top, 5)
    }
}

struct CardContent: View {
    var customerOrderModel: CustomerRequestsValueModel
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                RentalInfoHeaderView(name: LocalizedStringKey(customerOrderModel.name ?? ""), realStateCategory: LocalizedStringKey(customerOrderModel.category ?? ""))
                LocationInfoView(locationName: "")
                PriceInfoView(price: VilalHelper.getFromToPrice(fromPrice: customerOrderModel.price?.from ?? "", toPrice:  customerOrderModel.price?.to ?? ""))
            }
            .padding([.leading, .top, .bottom])
        }
    }
    
}


