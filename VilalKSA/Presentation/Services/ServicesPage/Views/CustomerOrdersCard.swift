//
//  CustomerOrdersCard.swift
//  VilalKSA
//
//  Created by Elkilany on 21/01/2024.
//

import SwiftUI

struct CustomerOrdersCard: View {
    var body: some View {

        CardContent()
            .background(RoundedRectangle(cornerRadius: 15.0)
                .fill(Color.white)
                .shadow(radius: 4))
            .padding(.horizontal, 20)
            .padding(.top, 15)
    }
}

struct CardContent: View {
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                RentalInfoHeaderView()
                LocationInfoView()
                PriceInfoView(price: nil)
            }
            .padding([.leading, .top, .bottom])
        }
    }
    
}






struct CustomerOrdersCard_Previews: PreviewProvider {
    static var previews: some View {
        CustomerOrdersCard()
    }
}
