//
//  CreateAdsSuccessPage.swift
//  VilalKSA
//
//  Created by Elkilany on 19/02/2024.
//

import SwiftUI
import UIPilot

struct CreateAdsSuccessPage: View {

    @EnvironmentObject var pilot: UIPilot<AddRequestDestination>
     var title = R.string.localizable.ad_Added_Successfully.localized
    var subTitle = R.string.localizable.property_Data_Added_Successfully.localized
    
    var body: some View {

        VStack{
            Spacer()
            Image(R.image.add_New_Add.name)
                .resizable()
                .frame(maxWidth: 300, maxHeight:300, alignment: .center)
            
            TextExtraBold16(textKey:title, textColor: R.color.color172B4D.name.getColor())
                .padding(.bottom,1)
            
            TextRegular14(textKey:subTitle, textColor: R.color.color7A869A.name.getColor())
            
            DefaultBoarderButtonWithIcon(title: R.string.localizable.back_to_Home.localized,borderColor: R.color.colorPrimary.name.getColor() ,backgroundColor: .white, titleColor: R.color.colorPrimary.name.getColor() ,actionButton: {
                pilot.popTo(.addRequest)
            })
            .padding(12)
            .padding(.top, 20)
            Spacer()
        }
    }
}
