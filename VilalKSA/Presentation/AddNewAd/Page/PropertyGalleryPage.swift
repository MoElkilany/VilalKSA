//
//  PropertyGalleryPage.swift
//  VilalKSA
//
//  Created by Elkilany on 11/02/2024.
//

import SwiftUI
import UIPilot
import LanguageManagerSwiftUI

struct PropertyGalleryPage: View {
    @EnvironmentObject var pilot: UIPilot<AddRequestDestination>
    @StateObject var viewModel = AddNewAdCategoryViewModel()
    var addNewAdRequestModel:AddNewAdRequestModel?
    @State private var showActionSheet = false
    @State private var showImagePicker = false
    @State private var imagePickerSourceType = UIImagePickerController.SourceType.photoLibrary
    @State private var images: [UIImage] = []

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

                        ChooseImageAndVideoView(title: R.string.localizable.add_Video.localized, image:  R.image.video_icon.name)
                    }
                    .padding(.bottom,25)
                    .padding(.horizontal,20)
                    
                    if !images.isEmpty  {
                        SelectedImagesCard(images: self.$images)
                    }
                    
                    TextRegular14(text: R.string.localizable.adding_a_video_to_your_ad_will_increase_its_visibility.localized, textColor: R.color.color7A869A.name.getColor())
                        .multilineTextAlignment(.center)
                        .padding(.bottom,25)
                    
                    DefaultButton(title:  R.string.localizable.next.localized, backgroundColor: R.color.colorPrimary.name.getColor() ,action: {
                        
                        if !images.isEmpty  {
                            pilot.push(.addNewAdsPage(model: AddNewAdRequestModel(categoryAdID: addNewAdRequestModel?.categoryAdID ?? "", addLat: addNewAdRequestModel?.addLat ?? "", addLng: addNewAdRequestModel?.addLng ?? "", addAddress: addNewAdRequestModel?.addAddress ?? "",images: self.viewModel.convertImageToData(images: self.images)  )))
                        }

                    }, fontWeight: .bold)
                    
                }
                .edgesIgnoringSafeArea(.all)
                .padding(.top,20)
                .onAppear(perform: {
                    print("the model is , ", addNewAdRequestModel)
                })
                
                .actionSheet(isPresented: $showActionSheet) {
                    ActionSheet(
                        title: Text(R.string.localizable.choose_Option.localized),
                        message: nil,
                        buttons: [
                            .default(Text(R.string.localizable.open_Camera.localized)) {
                                showImagePicker = true
                            },
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
        })
    }
}

#Preview {
    PropertyGalleryPage()
}


struct ChooseImageAndVideoView: View {
    
    let title: LocalizedStringKey
    let image: String
    
    var body: some View {
        HStack(alignment:.center){
            Image(image)
                .resizable()
                .frame(width: 35, height: 35, alignment: .center)
            TextBold12(text: title, textColor: R.color.color172B4D.name.getColor())
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

