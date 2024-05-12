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
    @EnvironmentObject var favoritePilot: UIPilot<FavoritesDestination>
    
    @State var showCalendelView: Bool = false
    @StateObject var viewModel = AdsDetailsViewModel()
    @ObservedObject var locationManager = LocationManager()
    @State var mapDetails: Map?
    @State var videoUrl: String?
    
    var requestID: String
    var navigationType: AdDetailsTypes
    @State private var isShowingShareSheet = false
    @State private var isFav: Bool =  false
    @State var shareUrl: String?
    
    @State var rentalDate: LocalizedStringKey?
    @State var propertyRentalDateFrom: String?
    @State var propertyRentalDateTo: String?
    @State var rentalDays: String?
    @State private var isSelectRentalDate: Bool =  false
    @State private var showActionSheet = false
    @State private var showContactActionSheet = false
    
    @State var isAdOwner: Bool = false
    
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
            case .favorite:
                favoritePilot.pop()
            }
        }  ,content: {
            ZStack{
                ScrollView(showsIndicators:false){
                    ScrollViewReader { scrollView in
                        VStack {
                            Color.clear.frame(height: 0).id(0)
                            //                        HStack{
                            //                            Spacer()
                            //                            HStack(spacing:0){
                            //                                TextBold12(textKey: R.string.localizable.share_Ads.localized, textColor: R.color.colorPrimary.name.getColor())
                            //                                Button {
                            //                                    self.isShowingShareSheet.toggle()
                            //                                } label: {
                            //                                    Image(R.image.shareIcon.name)
                            //                                }
                            //                            }
                            //                        }
                            //                        .padding(.horizontal)
                            
                            VStack{
                                if viewModel.imageUrls != nil {
                                    HStack{
                                        TextBold14(textKey: R.string.localizable.property_Images.localized, textColor: R.color.color172B4D.name.getColor())
                                        Spacer()
                                        HStack(spacing:0){
                                            TextBold12(textKey: R.string.localizable.share_Ads.localized, textColor: R.color.colorPrimary.name.getColor())
                                            Image(R.image.shareIcon.name)
                                        }
                                        .onTapGesture {
                                            self.isShowingShareSheet.toggle()
                                        }
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
                                if self.isAdOwner == false {
                                    RequestOwnerView(ownerInfo: viewModel.adDetails?.owner) {
                                        switch navigationType {
                                        case .ads:
                                            pilot.push(.propertyOwnerInformationPage(userId: String(viewModel.adDetails?.owner?.id ?? 0 ), type: navigationType))
                                        case .main:
                                            mainPilot.push(.propertyOwnerInformationPage(userId: String(viewModel.adDetails?.owner?.id ?? 0 ), type: navigationType))
                                        case .toDaysAds:
                                            servicesPilot.push(.propertyOwnerInformationPage(userId: String(viewModel.adDetails?.owner?.id ?? 0 ), type: navigationType))
                                        case .favorite:
                                            favoritePilot.push(.propertyOwnerInformationPage(userId: String(viewModel.adDetails?.owner?.id ?? 0 ), type: navigationType))
                                        }
                                    }
                                }
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
                                                Button {
                                                    if let url = URL(string: "https://www.google.com/maps?q=\(self.mapDetails?.lat ?? ""),\(self.mapDetails?.lon ?? "")") {
                                                                UIApplication.shared.open(url)
                                                            }
                                                } label: {
                                                    TextBold14(textKey: R.string.localizable.openLocation.localized, textColor: R.color.colorPrimary.name.getColor())

                                                }

                                                
                                           
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
                            
                            
                            if self.isAdOwner == true {
                                
                                VStack{
                                    TextBold18(textKey:R.string.localizable.isPropertySale.localized, textColor: R.color.colorPrimary.name.getColor())
                                        .multilineTextAlignment(.center)
                                    TextRegular16(textKey:R.string.localizable.ifYES.localized, textColor: R.color.color868583.name.getColor())
                                        .multilineTextAlignment(.center)
                                    
                                    HStack{
                                        DefaultBoarderButtonWithIcon(title: R.string.localizable.oK.localized,borderColor:.clear ,backgroundColor:R.color.colorPrimary.name.getColor(), titleColor:.white ,actionButton: {
                                            viewModel.changeStatus(id:String(self.viewModel.adDetails?.main?.id ?? 0))
                                            
                                        })
                                        .frame(width: 150, height: 60)
                                    }
                                    .padding(.horizontal,12)
                                }
                                .customCardStyle()
                            }else{
                                VStack{
                                    HStack{
                                        VStack(spacing:0){
                                            TextBold16(textKey: R.string.localizable.property_Price.localized,textColor: R.color.color172B4D.name.getColor())
                                            HStack{
                                                TextBold16(text: viewModel.adDetails?.main?.price ?? "" , textColor: R.color.colorPrimary.name.getColor())
                                                TextBold16(textKey:R.string.localizable.thousand.localized, textColor: R.color.colorPrimary.name.getColor())
                                            }
                                        }
                                        Spacer()
                                        DefaultBoarderButtonWithIcon(title:R.string.localizable.contact_Advertiser.localized  ,borderColor: .clear ,backgroundColor:R.color.colorPrimary.name.getColor(), titleColor:.white ,actionButton: {
                                            showContactActionSheet = true
                                            
                                            
                                            //                                    let summaryModel = SummaryModel(imageUrl:  viewModel.imageUrls?.first ?? "", rate: "", category:  viewModel.adDetails?.main?.category ?? "", name:  viewModel.adDetails?.main?.name ?? "", room:  " ", space:  viewModel.adDetails?.main?.estateSpace ?? "", price:  viewModel.adDetails?.main?.price ?? "", favourite:  viewModel.adDetails?.main?.favourite ?? false , location:  viewModel.adDetails?.map?.address ?? "", rental:  viewModel.adDetails?.main?.rental ?? "",type:  viewModel.adDetails?.main?.type ?? "",phoneNumber:viewModel.adDetails?.owner?.phone ?? "" ,whatsApp:viewModel.adDetails?.owner?.whatsapp ?? "")
                                            //
                                            //                                    switch navigationType {
                                            //                                    case .ads:
                                            //                                        pilot.push(.propertySummaryPage(model:summaryModel, type: self.navigationType))
                                            //                                    case .main:
                                            //                                        mainPilot.push(.propertySummaryPage(model:summaryModel, type: self.navigationType))
                                            //                                    case .toDaysAds:
                                            //                                        servicesPilot.push(.propertySummaryPage(model:summaryModel, type: self.navigationType))
                                            //                                    case .favorite:
                                            //                                        favoritePilot.push(.propertySummaryPage(model:summaryModel, type: self.navigationType))
                                            //                                    }
                                        })
                                        .frame(width: 200, height: 50)
                                    }
                                }
                                .customCardStyle()
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
                            
                            //                        if viewModel.adDetails?.main?.type == "1" {
                            
                            //                        }else{
                            
                            //                            RentalView(propertyPrice: viewModel.adDetails?.main?.price ?? "", showCalender: {
                            //                                if isSelectRentalDate == false {
                            //                                    self.showCalendelView = true
                            //                                }else{
                            //                                    if let propertyPrice = Double(viewModel.adDetails?.main?.price ?? ""), let propertyPriceForOneDay = Double(rentalDays ?? "" ) {
                            //                                        let price = propertyPrice * propertyPriceForOneDay
                            //                                        let reservationModel = RentalReservationModel(checkIn: propertyRentalDateFrom ?? "" , checkOut: propertyRentalDateTo ?? "" , numberOfNight:rentalDays ?? "" , totalPrice: String(price))
                            //                                        switch navigationType {
                            //                                        case .ads:
                            //                                            pilot.push(.rentalReservationPage(type: navigationType, model: reservationModel))
                            //                                        case .main:
                            //                                            mainPilot.push(.rentalReservationPage(type: navigationType, model: reservationModel))
                            //                                        case .toDaysAds:
                            //                                            servicesPilot.push(.rentalReservationPage(type: navigationType, model: reservationModel))
                            //                                        case .favorite:
                            //                                            favoritePilot.push(.rentalReservationPage(type: navigationType, model: reservationModel))
                            //                                        }
                            //                                    }
                            //                                }
                            //                            } , propertyPriceForOneDay: $rentalDays, propertyRentalDateFrom: $propertyRentalDateFrom, propertyRentalDateTo: $propertyRentalDateTo)
                            //                        }
                            //
                            
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
        .onReceive(self.viewModel.$isAdOwner, perform: { isAdOwner in
            self.isAdOwner = isAdOwner ?? false
        })
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
        
        .actionSheet(isPresented: $showContactActionSheet) {
            getActionSheet()
        }
        .onReceive(self.viewModel.$isSucessDeleteAd) { changeStatus in
            if changeStatus == true  {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5 , execute: {
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
                })
            }
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
            ToastBottomSecond(title: R.string.localizable.ad_Deleted_Successfully.localized, subTitle:self.viewModel.succesChangeStatus ?? "", subTitleLocalized:  "")
            
        } customize: {
            $0
                .type(.floater())
                .position(.bottom)
                .animation(.spring())
                .autohideIn(5)
        }
        
    }
    
    func getActionSheet() -> ActionSheet {
        
        return ActionSheet(
            title: Text(R.string.localizable.contact_Advertiser.localized),
            message: nil,
            buttons: [
                
                .default(Text(R.string.localizable.whatsApp.localized)) {
                    VilalHelper.openWhatsApp(urlString: viewModel.adDetails?.owner?.whatsapp ?? "")
                    showContactActionSheet = false
                },
                .default(Text(R.string.localizable.call.localized)) {
                    VilalHelper.makePhoneCall(phoneNumber:viewModel.adDetails?.owner?.phone ?? "" )
                    showContactActionSheet = false
                },
                .cancel()
            ]
        )
    }
}


enum AdDetailsTypes {
    case ads
    case main
    case toDaysAds
    case favorite
}


struct ActivityViewController: UIViewControllerRepresentable {
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return activityViewController
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}


struct SummaryModel: BaseModel {
    var imageUrl: String?
    var rate: String?
    var category: String?
    var name: String?
    var room: String?
    var space: String?
    var price: String?
    var favourite: Bool?
    var location: String?
    var rental: String?
    var type:String?
    var phoneNumber: String?
    var whatsApp: String?
}

struct VideoPlayes: View {
    @State private var player: AVPlayer? // State object to manage the player

    var videoURL: URL // URL of the video to play

    var body: some View {
        VideoPlayer(player: player)
            .onAppear {
                // Initialize the player when the view appears
                player = AVPlayer(url: videoURL)
                player?.play() // Start playing the video
            }
            .onDisappear {
                // Pause the player when the view disappears
                player?.pause()
            }
    }
}
