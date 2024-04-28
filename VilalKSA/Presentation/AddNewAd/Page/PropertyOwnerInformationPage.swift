//
//  PropertyOwnerInformationPage.swift
//  VilalKSA
//
//  Created by Elkilany on 28/03/2024.
//

import SwiftUI
import UIPilot

struct PropertyOwnerInformationPage: View {
    
    var userID:String
    var navigationType: AdDetailsTypes
    @StateObject var viewModel = PropertyOwnerViewModel()
    
    @EnvironmentObject var pilot: UIPilot<AddRequestDestination>
    @EnvironmentObject var mainPilot: UIPilot<MainDestination>
    @EnvironmentObject var servicesPilot: UIPilot<ServicesDestination>
    @EnvironmentObject var favoritePilot: UIPilot<FavoritesDestination>
    
    var body: some View {
        
        VilalKSAContainer(state: self.$viewModel.state,titlePage: R.string.localizable.property_Owner.localized, tryAgainAction: {
            viewModel.getPropertyOwnerInfo(id: self.userID)
        },backAction:{
            switch navigationType {
            case .ads:
                pilot.pop()
            case .main:
                mainPilot.pop()
            case .toDaysAds:
                servicesPilot.pop()
            case .favorite:
                favoritePilot.pop()
            }
        } ,content: {
            ScrollView {
                    VStack{
                        URLImage(imageUrl: viewModel.propertyOwnerData.image ?? "" ,isCliped: true )
                        VStack(spacing:-4){
                            TextBold14(text:  viewModel.propertyOwnerData.name ?? ""  , textColor: R.color.color172B4D.name.getColor())
                            TextRegular14(text:   viewModel.propertyOwnerData.email ?? "", textColor: R.color.color7A869A.name.getColor())
                        }
                        
                        HStack(spacing:20){
                            Button(action: CallAction) {
                                ContactView(name: R.string.localizable.call.localized, image: R.image.call.name)
                            }
                            Button(action: wathsAppAction){
                                ContactView(name: R.string.localizable.whatsApp.localized, image: R.image.whatsapp.name)
                            }
                        }
                        
                        HStack{
                            HStack(spacing:10){
                                SubInfoView(name:  viewModel.propertyOwnerData.active ?? "",subName: R.string.localizable.active_Since.localized ,image:R.image.clock.name)
                    
                                SubInfoView(name:  viewModel.propertyOwnerData.join ?? "",subName: R.string.localizable.joined_Since.localized, image:R.image.calendar.name)
                             
                                SubInfoView(name: " ",subName: R.string.localizable.committed_Fees.localized ,image:R.image.committed_Fees.name)
                                
                            }
                        }
                        .frame(maxWidth:300,maxHeight: 60, alignment: .center)
                        .padding(.vertical, 20)
//                        .padding(.horizontal, 30)
                        .background(RoundedRectangle(cornerRadius: 10.0)
                            .fill(R.color.colorF1F5F9.name.getColor()))
                        .padding()
                        
                        MemberAnnouncementsView()
                        
                        ForEach(viewModel.propertyOwnerData.ads ?? [] , id: \.self ) { item in
                            
                            PropertyContainerView(imageUrl: item.image ?? "" , rate: String(item.rate ?? 0), category: item.category ?? "" , name: item.name ?? "" , room: item.room ?? "", space: String(item.space ?? 0) , price: item.price ?? "" , favourite: item.favourite ?? false, location: item.address ?? "", rental: item.rental ?? "", addOrRemoveFavouriteAction: {
                                self.viewModel.addOrRemoveFav(id: String(item.id ?? 0))
                            })
                            .onTapGesture {
//                                pilot.push(.adsDetailsPage(id: String(item.id ?? 0 ), type: navigationType))
                            }
                        }
                        
                        
                        Spacer()
                    }
                
            }
            .padding(.bottom,30)
            .onAppear {
                viewModel.getPropertyOwnerInfo(id: self.userID)
            }
        })
        
    }
    
}

extension PropertyOwnerInformationPage {
    private func CallAction() {
        VilalHelper.makePhoneCall(phoneNumber: viewModel.propertyOwnerData.phone ?? ""  )
    }
    
    
    private func wathsAppAction() {
        VilalHelper.openWhatsApp(urlString: viewModel.propertyOwnerData.whatsapp ?? "")
    }
}



struct ContactView: View {
    
    var name: LocalizedStringKey
    var image: String
    
    var body: some View {
        HStack{
            Image(image)
                .resizable()
                .frame(width: 20,height: 20)
            TextBold14(textKey: name  , textColor: R.color.color00CC21.name.getColor())
        }
        .frame(height: 20)
        .padding(10)
        .background( RoundedRectangle(cornerRadius: 20)
            .stroke(R.color.color00CC21.name.getColor(), lineWidth: 1))
      
    }
}

struct SubInfoView: View {
    var name: String
    var subName: LocalizedStringKey? = ""
    var image: String
    
    var body: some View {
        VStack(spacing:0){
            Image(image)
                .resizable()
                .frame(width: 30,height: 30)
            HStack(spacing:4){
                TextMeduim(textKey:subName, textColor: R.color.color7A869A.name.getColor())
          
                TextMeduim(text:name, textColor: R.color.color7A869A.name.getColor())
            }
        }
    }
}

struct MemberAnnouncementsView: View {
    var body: some View {
        HStack{
            HStack{
                Image(R.image.owner_Ads.name)
                    .resizable()
                    .frame(width: 30,height: 30)
                TextBold12(textKey: R.string.localizable.member_Announcements.localized  , textColor: R.color.colorPrimary.name.getColor())
                
            }
            Spacer()
        }
        .customCardStyle()
        .padding(.horizontal,15)
    }
}
