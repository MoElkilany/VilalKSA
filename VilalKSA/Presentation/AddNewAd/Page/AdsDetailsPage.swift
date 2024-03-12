//
//  AdsDetailsPage.swift
//  VilalKSA
//
//  Created by Elkilany on 23/02/2024.
//
import SwiftUI
import UIPilot
import AVFoundation
import _AVKit_SwiftUI

struct AdsDetailsPage: View {
    
    @EnvironmentObject var pilot: UIPilot<AddRequestDestination>
    @EnvironmentObject var mainPilot: UIPilot<MainDestination>
    @EnvironmentObject var servicesPilot: UIPilot<ServicesDestination>
    
    @StateObject var viewModel = AdsDetailsViewModel()
    @ObservedObject var locationManager = LocationManager()
    @State var mapDetails: Map?
    @State var videoUrl: String?

    var requestID: String
    var navigationType: AdDetailsTypes = .ads
    
    var body: some View {
        
        VilalKSAContainer(state: self.$viewModel.state,titlePage: R.string.localizable.ads_Details.localized, tryAgainAction: {
            self.viewModel.getAdDetails(requestID: self.requestID)
        },backAction:{
            switch navigationType {
            case .ads:
                pilot.pop()
            case .main:
                mainPilot.pop()
            case .toDaysAds:
                servicesPilot.pop()
            case .mainList:
                mainPilot.pop()
            }
            
        }  ,content: {
            ScrollView(showsIndicators:false){
                ScrollViewReader { scrollView in
                    
                    VStack {
                        Color.clear.frame(height: 0).id(0)
                        
                        VStack{
                            if viewModel.imageUrls != nil {
                                HStack{
                                    TextBold14(textKey: R.string.localizable.property_Images.localized, textColor: R.color.color172B4D.name.getColor())
                                    Spacer()
                                }
                                
                                ImageSlideshowView(imageUrls: viewModel.imageUrls ?? [])
                                    .frame(height: 200)
                            }else{
                                TextBold14(textKey: R.string.localizable.no_Ads_Images.localized, textColor: R.color.color172B4D.name.getColor())
                            }
                            
                        }
                        .customCardStyle()
                        .padding(.top, 10)
                        
                        if  self.videoUrl != nil {
                            
                            VStack{
                                HStack{
                                    TextBold14(textKey: R.string.localizable.video_Ad.localized, textColor: R.color.color172B4D.name.getColor())
                                    Spacer()
                                }
                                
                                VideoPlayerView(videoURL: URL(string:  self.videoUrl  ?? "" )!)
                                    .frame(width: 200, height: 200)
                            }
                            .customCardStyle()
                            .padding(.top, 10)
                            
                        }else{
                            
                            
                        }
                        
                        
                        VStack{
                            AdDetailsMainView(mainInfo: viewModel.adDetails?.main , mapInfo: viewModel.adDetails?.map)
                                .padding(.bottom,4)
                            RequestOwnerView(ownerInfo: viewModel.adDetails?.owner)
                            PropertyKeyValueDetailsView(propertiesDetailsArray: viewModel.adDetails?.details)
                            PropertyPropertiesView(items: viewModel.adDetails?.properites)
                            
                            VStack{
                                HStack{
                                    TextMeduim12(textKey: R.string.localizable.property_Details.localized, textColor: R.color.color42526E.name.getColor())
                                    Spacer()
                                }
                                
                                VStack{
                                    TextRegular14(text: self.viewModel.adDetails?.description ?? "" , textColor: R.color.color42526E.name.getColor())
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 20)
                                .padding(.horizontal, 20)
                                .background(RoundedRectangle(cornerRadius: 10.0)
                                    .fill(R.color.colorF1F5F9.name.getColor()))
                            }
                            .frame(maxWidth: .infinity)
                            .customCardStyle()
                            
                        }
                        
                        ZStack{
                            
                            VStack{
                                
                            }
                            .frame(height: 350)
                            .customCardStyle()
                            VStack{
                                GeometryReader { geometry in
                                    VStack(alignment: .leading,spacing: 5) {
                                        HStack{
                                            TextBold14(textKey: R.string.localizable.customer_Details_Location.localized, textColor: R.color.colorPrimary.name.getColor())
                                            Spacer()
                                        }
                                        if self.mapDetails != nil {
                                            ShowLocationOnGoogleMapsView(locationManager: locationManager, lat:  Double(self.mapDetails?.lat ?? "") ?? 30.114892203308475 , lng: Double(self.mapDetails?.lon ?? "") ?? 31.352332457900047 )
                                                .frame(width: geometry.size.width, height: 300)
                                                .padding(4)
                                                .cornerRadius(30)
                                        }
                                    }
                                }
                            }
                            .padding()
                        }

                        VStack(spacing:0){
                            HStack{
                                TextBold14(textKey: R.string.localizable.similar_Ads.localized, textColor: R.color.colorPrimary.name.getColor())
                                Spacer()
                            }
                            ScrollView(.horizontal,showsIndicators:false){
                                HStack {
                                    ForEach( viewModel.adDetails?.similarAds ?? [] , id: \.self) { item in
                                        Button(action: {
                                            withAnimation {
                                                scrollView.scrollTo(0)
                                            }
                                            self.viewModel.getAdDetails(requestID: String(item.id ?? 0))
                                        }, label: {
                                            SimilarAdsView(isFav:item.favourite ?? false ,similarAdModel: item, favAction: {
                                                self.viewModel.addOrRemoveFav(id: String(item.id ?? 0))
                                            })
                                        })
                                    }
                                }
                            }
                        }
                        .customCardStyle()

                        VStack{
                            HStack{
                                VStack{
                                    TextBold14(textKey: R.string.localizable.total_Price.localized,textColor: R.color.color172B4D.name.getColor())
                                    HStack{
                                        TextBold18(text: viewModel.adDetails?.main?.price ?? "" , textColor: R.color.colorPrimary.name.getColor())
                                        TextBold18(textKey:R.string.localizable.thousand.localized, textColor: R.color.colorPrimary.name.getColor())
                                    }
                                }
                                Spacer()
                                DefaultBoarderButtonWithIcon(title: R.string.localizable.contact_Advertiser.localized,borderColor: .clear ,backgroundColor:R.color.colorPrimary.name.getColor(), titleColor:.white ,actionButton: {
                                })
                                .frame(width: 200, height: 50)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 20)
                        .background(RoundedRectangle(cornerRadius: 10.0)
                            .fill(Color.white)
                            .shadow(color:Color.gray.opacity(0.2) ,radius: 10))
                        Spacer()
                    }
                    .onAppear {
                        scrollView.scrollTo(0, anchor: .top)
                    }
                    
                    
                }
            }
            
        })
        .edgesIgnoringSafeArea(.all)
        .padding(.bottom,30)
        .task {
            viewModel.getAdDetails(requestID:  self.requestID)
        }
        .onReceive(self.viewModel.$mapDetails) { mapDetails in
            self.mapDetails = mapDetails
        }
        .onReceive(self.viewModel.$videoUrl) { url in
            self.videoUrl = url
        }
    }
}



enum AdDetailsTypes {
    case ads
    case main
    case toDaysAds
    case mainList
}

