//
//  SaleOrRentPropertyPage.swift
//  VilalKSA
//
//  Created by Elkilany on 07/05/2024.
//

import SwiftUI
import UIPilot

struct SaleOrRentPropertyPage: View {

    @EnvironmentObject var pilot: UIPilot<AddRequestDestination>
    
    var body: some View {

        VStack{
            Spacer()
            Image(R.image.checkmark_Success.name)
                .resizable()
                .frame(maxWidth: 300, maxHeight:300, alignment: .center)
            
            TextExtraBold16(textKey: R.string.localizable.ad_Deleted_Successfully.localized, textColor: R.color.color172B4D.name.getColor())
                .padding(.bottom,1)

            DefaultBoarderButtonWithIcon(title: R.string.localizable.back_to_Home.localized,borderColor: R.color.colorPrimary.name.getColor() ,backgroundColor: .white, titleColor: R.color.colorPrimary.name.getColor() ,actionButton: {
                pilot.popTo(.addRequest)
            })
            .padding(12)
            .padding(.top, 20)
            Spacer()
        }
    }
}
