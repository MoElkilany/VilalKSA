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
    
    @EnvironmentObject var pilot: UIPilot<ServicesDestination>
    @StateObject var viewModel = AdsDetailsViewModel()
    @ObservedObject var locationManager = LocationManager()
    @State var mapDetails: Map?
    var requestID: String
    
    var body: some View {
        
        VilalKSAContainer(state: self.$viewModel.state,titlePage: R.string.localizable.ads_Details.localized, tryAgainAction: {
            self.viewModel.getAdDetails(requestID: self.requestID)
        },backAction:{
            pilot.pop()
        } ,content: {
            ScrollView(showsIndicators:false){
                ScrollViewReader { scrollView in
                    
                    VStack {
                        Color.clear.frame(height: 0).id(0)
                        
                        VStack{
                            HStack{
                                TextBold14(textKey: R.string.localizable.property_Images.localized, textColor: R.color.color172B4D.name.getColor())
                                Spacer()
                            }
                            
                            ScrollView(.horizontal,showsIndicators:false){
                                HStack {
                                    ForEach( viewModel.adDetails.images ?? [] , id: \.self) { url in
                                        MediaView(url: url)
                                            .frame(width: 200, height: 150, alignment: .center)
                                    }
                                }
                            }
                        }
                        .customCardStyle()
                        .padding(.top, 10)
                        
                        
                        VStack{
                            AdDetailsMainView(mainInfo: viewModel.adDetails.main , mapInfo: viewModel.adDetails.map)
                                .padding(.bottom,4)
                            RequestOwnerView(ownerInfo: viewModel.adDetails.owner)
                            PropertyKeyValueDetailsView(propertiesDetailsArray: viewModel.adDetails.details)
                            PropertyPropertiesView(items: viewModel.adDetails.properites)
                            
                            
                            VStack{
                                HStack{
                                    TextMeduim12(textKey: R.string.localizable.property_Details.localized, textColor: R.color.color42526E.name.getColor())
                                    Spacer()
                                }
                                
                                VStack{
                                    TextRegular14(text: self.viewModel.adDetails.description ?? "" , textColor: R.color.color42526E.name.getColor())
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
                                    ForEach( viewModel.adDetails.similarAds ?? [] , id: \.self) { item in
                                        Button(action: {
                                            withAnimation {
                                                scrollView.scrollTo(0)
                                            }
                                            
                                            self.viewModel.getAdDetails(requestID: String(item.id ?? 0))
                                        }, label: {
                                            SimilarAdsView(similarAdModel: item)
                                        })
                                    }
                                }
                            }
                        }
                        .customCardStyle()
                        
                        VStack{
                            DefaultBoarderButtonWithIcon(title: R.string.localizable.contact_Advertiser.localized,borderColor: .clear ,backgroundColor:R.color.colorPrimary.name.getColor(), titleColor:.white ,actionButton: {
                            })
                            .frame(height: 50)
                            
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
    }
}


struct MediaView: View {
    let url: String
    
    var body: some View {
        VStack{
            if url.hasSuffix(".mp4") {
                VideoPlayer(player: AVPlayer(url: URL(string: url)!))
                    .frame(height: 100)
                    .cornerRadius(10)
            } else {
                
                
                AsyncImage(url: URL(string: url)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 150)
                            .cornerRadius(10)
                    case .failure(_):
                        Image(R.image.logo.name)
                            .frame(width: 200, height: 150, alignment: .center)
                            .cornerRadius(10)
                    case .empty:
                        ProgressView()
                    @unknown default:
                        EmptyView()
                    }
                }
                
                
            }
        }
    }
}
