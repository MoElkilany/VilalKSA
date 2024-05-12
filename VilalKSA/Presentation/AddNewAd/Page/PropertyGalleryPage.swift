//
//  PropertyGalleryPage.swift
//  VilalKSA
//
//  Created by Elkilany on 11/02/2024.
//

import SwiftUI
import UIPilot
import LanguageManagerSwiftUI
import AVKit
import UIKit

struct PropertyGalleryPage: View {
    
    @EnvironmentObject var pilot: UIPilot<AddRequestDestination>
    @StateObject var viewModel = AddNewAdCategoryViewModel()
    var addNewAdRequestModel:AddNewAdRequestModel?
    @EnvironmentObject var pilotRoot: UIPilot<RootDestination>

    @State var showActionSheet = false
    @State var showImagePicker = false
    @State var imagePickerSourceType = UIImagePickerController.SourceType.photoLibrary
    @State var images: [UIImage] = []
    @State var isVideoPickerPresented = false
    @State var videoURL: URL?
    @State var nextButton: Bool = true
    @State var popups: Bool = false
    var body: some View {
        
        VilalKSAContainer(state: self.$viewModel.state,titlePage: R.string.localizable.property_Images.localized, tryAgainAction: {
        },backAction:{
            pilot.pop()
        } ,content: {
            ScrollView{
                VStack{
                    StepsBarView(stepNumber: "2", stepImage: R.image.step2_AddNewAds.name)
                        .padding(.bottom,50)
                    
                    HStack{
                        Button {
                            showActionSheet = true
                        } label: {
                            ChooseImageAndVideoView(title: R.string.localizable.attach_Image.localized, image:  R.image.image_icon.name)
                        }
                        
                        Button {
                            isVideoPickerPresented.toggle()
                        } label: {
                            ChooseImageAndVideoView(title: R.string.localizable.add_Video.localized, image:  R.image.video_icon.name)
                        }
                    }
                    .padding(.bottom,25)
                    .padding(.horizontal,20)
                    
                    if !images.isEmpty  {
                        SelectedImagesCard(images: self.$images)
                    }
                    
                    if nextButton == false {
                        ErrorTextView(errorText: R.string.localizable.pickAnAttachments.localized)
                    }
                    
                    if videoURL != nil {
                        TextBold12(text: "تم رفع فيديو بنجاح", textColor: R.color.color172B4D.name.getColor())
                    }
                    
                    TextRegular14(textKey: R.string.localizable.adding_a_video_to_your_ad_will_increase_its_visibility.localized, textColor: R.color.color7A869A.name.getColor())
                        .multilineTextAlignment(.center)
                        .padding(.bottom,25)
                    
                    DefaultButton(title:  R.string.localizable.next.localized, backgroundColor: R.color.colorPrimary.name.getColor() ,action: {
                        
                        if UserDefaults.standard.bool(forKey:Constants.asGuest.rawValue) {
                            popups = true
                        }else{
                            if !images.isEmpty {
                                nextButton = true
                                
                                if  self.videoURL == nil {
                                    pilot.push(.addNewAdsPage(model: AddNewAdRequestModel(categoryAdID: addNewAdRequestModel?.categoryAdID ?? "", addLat: addNewAdRequestModel?.addLat ?? "", addLng: addNewAdRequestModel?.addLng ?? "", addAddress: addNewAdRequestModel?.addAddress ?? "",images: Convert.imageToData(images: self.images), videosData: nil,addStatus:addNewAdRequestModel?.addStatus ?? ""  )))
                                }else{
                                    pilot.push(.addNewAdsPage(model: AddNewAdRequestModel(categoryAdID: addNewAdRequestModel?.categoryAdID ?? "", addLat: addNewAdRequestModel?.addLat ?? "", addLng: addNewAdRequestModel?.addLng ?? "", addAddress: addNewAdRequestModel?.addAddress ?? "",images: Convert.imageToData(images: self.images), videosData:   Convert.URLToData(URLString: self.videoURL ?? URL(fileURLWithPath: "") ) ?? Data() , addStatus:addNewAdRequestModel?.addStatus ?? ""  ) ))
                                }
                                
                                
                            }else{
                                nextButton = false
                            }
                        }
                        
                        
                    }, fontWeight: .bold)
                    
                }
                .onAppear{
                    print("the data is:- ", addNewAdRequestModel)
                }
                .edgesIgnoringSafeArea(.all)
                .padding(.top,20)
                
                .sheet(isPresented: $isVideoPickerPresented, content: {
                    VideoPickers(isPresented: self.$isVideoPickerPresented, videoURL: self.$videoURL)
                })
                .actionSheet(isPresented: $showActionSheet) {
                    ActionSheet(
                        title: Text(R.string.localizable.choose_Option.localized),
                        message: nil,
                        buttons: [
                            //                                           .default(Text(R.string.localizable.open_Camera.localized)) {
                            //                                               // Show image picker
                            //                                               showImagePicker = true
                            //                                           },
                            .default(Text(R.string.localizable.choose_Gallery.localized)) {
                                showImagePicker = true
                            },
                            .cancel()
                        ]
                    )
                }
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(selectedImages: $images)
                }
            }
            .popup(isPresented: $popups, view: {

                GuestAlertDialog(onClose: {
                    popups = false
                }, trueAction: {
                    pilotRoot.popTo(.login)
                }, haveCancelButton: true )
            }, customize: {
                $0
                    .dragToDismiss(false)
            })
        })
    }
  
}



struct ChooseImageAndVideoView: View {
    
    let title: LocalizedStringKey
    let image: String
    
    var body: some View {
        HStack(alignment:.center){
            Image(image)
                .resizable()
                .frame(width: 35, height: 35, alignment: .center)
            TextBold12(textKey: title, textColor: R.color.color172B4D.name.getColor())
                .multilineTextAlignment(.leading)
        }
        .padding(.horizontal,20)
        
        .frame(width: 162, height: 127, alignment: .center)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(R.color.colorPrimary.name.getColor(), lineWidth: 1))
    }
}


struct VideoPreview: UIViewRepresentable {
    var videoURL: URL
    func makeUIView(context: Context) -> UIView {
        let player = AVPlayer(url: videoURL)
        let playerLayer = AVPlayerLayer(player: player)
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 300))
        playerLayer.frame = view.bounds
        view.layer.addSublayer(playerLayer)
        player.play()
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}


import UIKit

struct VideoPickers: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    @Binding var videoURL: URL?
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.mediaTypes = ["public.movie"]
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Update any configuration here
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: VideoPickers
        
        init(parent: VideoPickers) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let url = info[.mediaURL] as? URL {
                parent.videoURL = url
            }
            parent.isPresented = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false
        }
    }
}

