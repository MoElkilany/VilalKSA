//
//  RequestOwnerView.swift
//  VilalKSA
//
//  Created by Elkilany on 05/02/2024.
//

import SwiftUI

struct RequestOwnerView: View {
    
    let ownerInfo: Owner?
    var goToProfile:(()->())?
    
    init(ownerInfo: Owner?, goToProfile: ( () -> Void)? = nil) {
        self.ownerInfo = ownerInfo
        self.goToProfile = goToProfile
    }
    var body: some View {
        VStack(spacing:6){
            HStack{
                TextBold14(textKey: R.string.localizable.request_Owner.localized, textColor: R.color.color172B4D.name.getColor())
                Spacer()
     
                    VStack(spacing:0){
                        TextBold12(textKey: R.string.localizable.profile.localized, textColor: R.color.colorPrimary.name.getColor())
                        Rectangle().frame(width: 80,height: 1)
                            .foregroundColor(R.color.colorPrimary.name.getColor())
                    }
                    .onTapGesture {
                        goToProfile?()
                    }
            }
            
            HStack{
                URLImage(imageUrl: ownerInfo?.image ?? "",imageWidth: 60, imageHeight: 60, isCliped: true)
                    .cornerRadius(30)

                VStack(spacing:-4){
                    TextBold14(text: (ownerInfo?.name ?? "") , textColor: R.color.colorPrimary.name.getColor())
                    TextRegular12(text:  (ownerInfo?.date ?? ""), textColor: R.color.color7A869A.name.getColor())
                }
                Spacer()
                HStack(spacing:20){
                    Button(action: {
                        VilalHelper.openWhatsApp(urlString: ownerInfo?.whatsapp ?? "")
                    }, label: {
                        Image(R.image.whatsapp.name)
                            .resizable()
                            .frame(width: 30,height: 30)
                    })

                    Button(action: {
                        VilalHelper.makePhoneCall(phoneNumber: ownerInfo?.phone ?? "" )
                    }, label: {
                        Image(R.image.call.name)
                            .resizable()
                            .frame(width: 30,height: 30)
                    })
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .padding(.horizontal, 20)
        .background(RoundedRectangle(cornerRadius: 10.0)
            .fill(Color.white)
            .shadow(color:Color.gray.opacity(0.2) ,radius: 10))
    }
}
