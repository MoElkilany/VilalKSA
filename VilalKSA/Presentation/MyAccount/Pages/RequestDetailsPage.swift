//
//  RequestDetailsPage.swift
//  VilalKSA
//
//  Created by Elkilany on 02/04/2024.
//



import SwiftUI
import UIPilot
import AVFoundation
import _AVKit_SwiftUI

struct RequestDetailsPage: View {
    
    @EnvironmentObject var pilot: UIPilot<MyAccountDestination>
    
    
    @State var showCalendelView: Bool = false
    @StateObject var viewModel = AdsDetailsViewModel()
    @ObservedObject var locationManager = LocationManager()
    @State var mapDetails: Map?
    @State var videoUrl: String?
    
    var requestID: String
    @State private var isShowingShareSheet = false
    @State private var isFav: Bool =  false
    @State var shareUrl: String?
    
    @State var rentalDate: LocalizedStringKey?
    @State var propertyRentalDateFrom: String?
    @State var propertyRentalDateTo: String?
    @State var rentalDays: String?
    @State private var isSelectRentalDate: Bool =  false
    
    var body: some View {
        
        VilalKSAContainer(state: self.$viewModel.state,titlePage: R.string.localizable.ads_Details.localized, tryAgainAction: {
            self.viewModel.getAdDetails(requestID: self.requestID)
        },backAction:{
            pilot.pop()
        }  ,content: {
            ZStack{
            ScrollView(showsIndicators:false){
                    ScrollViewReader { scrollView in
                        VStack {
                            Color.clear.frame(height: 0).id(0)
                            HStack{
                                Spacer()
                                HStack(spacing:0){
                                    TextBold12(textKey: R.string.localizable.share_Ads.localized, textColor: R.color.colorPrimary.name.getColor())
                                    Button {
                                        self.isShowingShareSheet.toggle()
                                    } label: {
                                        Image(R.image.shareIcon.name)
                                    }
                                }
                            }
                            .padding(.horizontal)
                            
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
                                }
                                .customCardStyle()
                                .padding(.top, 10)
                            }
                            
                            VStack{
                                AdDetailsMainView(mainInfo: viewModel.adDetails?.main , mapInfo: viewModel.adDetails?.map)
                                    .padding(.bottom,4)
//                                RequestOwnerView(ownerInfo: viewModel.adDetails?.owner) {
//                                    
//                                }
//                                .disabled(true)
                                
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
                                                    .cornerRadius(40)
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
                            
                            if self.viewModel.adDetails?.main?.status == "0" {
                                VStack{
                                    TextBold18(textKey:R.string.localizable.hiddenAdvertisement.localized, textColor: R.color.colorPrimary.name.getColor())
                                    TextRegular16(textKey:R.string.localizable.doYouWantToShowItAgain.localized, textColor: R.color.color868583.name.getColor())

                                    HStack{
                                        DefaultBoarderButtonWithIcon(title: R.string.localizable.oK.localized,borderColor:.clear ,backgroundColor:R.color.colorPrimary.name.getColor(), titleColor:.white ,actionButton: {
                                            viewModel.changeStatus(id:String(self.viewModel.adDetails?.main?.id ?? 0))
                                        })
                                        .frame(width: 150, height: 60)
                                    }
                                    .padding(.horizontal,12)
                                }
                                .customCardStyle()
                            }
                            
                            Spacer()
                        }
                        .onAppear {
                            scrollView.scrollTo(0, anchor: .top)
                        }
                    }
                }
                if self.viewModel.otherSatate == .loading {
                    OnScreenLoading
                }
            }
        })
        .edgesIgnoringSafeArea(.all)
        .padding(.bottom,30)
        .onAppear {
            //            if viewModel.adDetails == nil {
            viewModel.getAdDetails(requestID:  self.requestID)
            //            }
        }
        .onReceive(self.viewModel.$isSucessDeleteAd) { changeStatus in
            if changeStatus == true  {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5 , execute: {
                    pilot.pop()
                })
            }
        }
        
        
        
        .onReceive(self.viewModel.$mapDetails) { mapDetails in
            self.mapDetails = mapDetails
        }
        .onReceive(self.viewModel.$videoUrl) { url in
            self.videoUrl = url
        }
        .onReceive(viewModel.$shareAds, perform: { shareUrl in
            self.shareUrl = shareUrl
        })
        .sheet(isPresented: $isShowingShareSheet) {
            ActivityViewController(activityItems: [self.shareUrl ?? "" ])
        }
        .popup(isPresented: $showCalendelView) {
            CalenderPage(onClose: {
                showCalendelView = false
            }, onTap: { (arrivalDate,departureDate,days)   in
                self.propertyRentalDateFrom = arrivalDate
                self.propertyRentalDateTo = departureDate
                self.rentalDays = days
                isSelectRentalDate = true
                showCalendelView = false
                
            })
        } customize: {
            $0
                .position(.bottom)
                .closeOnTap(false)
                .closeOnTapOutside(true)
                .backgroundColor(.black.opacity(0.4))
        }
        
        .popup(isPresented: self.$viewModel.isSucessDeleteAd) {
            if self.viewModel.adDetails?.main?.status == "0" {
                ToastBottomSecond(title: R.string.localizable.ad_Appear_Successfully.localized, subTitle:self.viewModel.succesChangeStatus ?? "", subTitleLocalized:  "")
            }else{
                ToastBottomSecond(title: R.string.localizable.ad_Deleted_Successfully.localized, subTitle:self.viewModel.succesChangeStatus ?? "", subTitleLocalized:  "")

            }
        } customize: {
            $0
                .type(.floater())
                .position(.bottom)
                .animation(.spring())
                .autohideIn(5)
        }
        
    }
}
