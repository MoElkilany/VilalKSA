//
//  MainFilterPage.swift
//  VilalKSA
//
//  Created by Elkilany on 07/03/2024.
//

import SwiftUI

struct ActionSheetView<Content: View>: View {
    @StateObject private var keyboard = KeyboardResponder()
    
    let content: Content
    let topPadding: CGFloat
    let fixedHeight: Bool
    let bgColor: Color
    
    init(topPadding: CGFloat = 100, fixedHeight: Bool = true  , bgColor: Color = .white, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.topPadding = topPadding
        self.fixedHeight = fixedHeight
        self.bgColor = bgColor
    }
    
    var body: some View {
        ZStack {
            bgColor.cornerRadius(40, corners: [.topLeft, .topRight])
            VStack {
                Color.black
                    .opacity(0.2)
                    .frame(width: 30, height: 6)
                    .clipShape(Capsule())
                    .padding(.top, 15)
                    .padding(.bottom, 10)
                content
                    .padding(.bottom, keyboard.currentHeight + 20 )
                    .onTapGesture {
                        hideKeyboard()
                    }
            }
        }
        .frame(maxHeight: 600)
    }
}


struct MainFilterPage: View {
    
    @State var savedData: MainAdRequest?
    @State var savedCategory:String?
    let categorysList: [LookUpModel]?
   
    var onClose: () -> Void
    var onDismiss: (MainAdRequest,String) -> Void
    var onCloseAfterSearch: () -> Void
    
    @State private var openPlacesSheet: Bool = false
    @State var category: String = ""
    @State var categoryID: String? = ""
    @State var sortByID: String  = ""
    
    @State var price: String = ""
    @State var propertyArea: String = ""
    @State var bedrooms: Int  = 0
    @State var bathroom: Int  = 0
    @State var livingRooms: Int  = 0
    
    @State var state: AppState = .success

    
    let sortByArray: [SortByModel] = [
        SortByModel(id: 1, name: R.string.localizable.lowest_Price.localized, isSelected: false),
        SortByModel(id: 2, name: R.string.localizable.highest_Price.localized, isSelected: false),
    ]
    
    var body: some View {
        ActionSheetView(bgColor: .white) {
            ScrollView {
                    VStack{
                        HStack{
                            TextBold18(textKey: R.string.localizable.classification.localized, textColor: R.color.colorPrimary.name.getColor())
                            Spacer()
                        }
                        .padding(.vertical,4)
                        
                        Button {
                            openPlacesSheet = true
                        } label: {
                            VStack(spacing: 4){
                                HStack{
                                    TextBold14(textKey:R.string.localizable.desired_Property_Type.localized, textColor: R.color.colorPrimary.name.getColor())
                                    Spacer()
                                }
                                
                                VilalTextField(text: $category, placeholder:  R.string.localizable.desired_Property_Type.localized, imageName:"" , keyboardType: .decimalPad, validationInput: .word, submitButton: false , onSubmit: { isValid in
                                })
                                .disabled(true)
                            }
                        }
                        
                        .sheet(isPresented: $openPlacesSheet) {
                            NavigationView {
                                    List{
                                        ForEach(self.categorysList ?? []  ,id: \.self) { item in
                                            Button(action: {
                                                openPlacesSheet = false
                                                self.category = item.name ?? ""
                                                self.categoryID = String(item.id ?? 0)
                                            }, label: {
                                                
                                                HStack{
                                                    TextBold14(text:item.name ?? "", textColor: R.color.colorPrimary.name.getColor())
                                                        .multilineTextAlignment(.center)
                                                    Spacer()
                                                }
                                            })
                                            .padding()
                                        }
                                    }
                            }
                            .multilineTextAlignment(.center)
//                            .presentationDetents([.medium, .large])
                        }
                        
                        VilalDivider()
                        
                        VStack(alignment: .leading,spacing: 0) {
                            TextBold14(textKey: R.string.localizable.price.localized, textColor: R.color.colorPrimary.name.getColor())
                                .padding(.bottom,0)
                            VilalTextField(text: $price, placeholder:  R.string.localizable.price.localized, imageName:"" , keyboardType: .decimalPad, validationInput: .word, submitButton: false , onSubmit: { isValid in
                            })
                        }
                        
                        VilalDivider()
                        VStack(alignment: .leading,spacing: 0) {
                            TextBold14(textKey: R.string.localizable.property_Area.localized, textColor: R.color.colorPrimary.name.getColor())
                                .padding(.bottom,0)
                            
                            VilalTextField(text: $propertyArea, placeholder:  R.string.localizable.property_Area.localized, imageName:"" , keyboardType: .decimalPad, validationInput: .word, submitButton: false , onSubmit: { isValid in
                            })
                        }
                        
                        VilalDivider()
                        PlusMinusView(localizedTitle:  R.string.localizable.bedrooms.localized, defualtValue: 0, finalValue: { bedrooms in
                            self.bedrooms = bedrooms
                        })
                        VilalDivider()
                        PlusMinusView(localizedTitle:  R.string.localizable.bathroom.localized, defualtValue: 0, finalValue: { bathroom in
                            self.bathroom = bathroom
                        })
                        VilalDivider()
//                        PlusMinusView(localizedTitle:  R.string.localizable.living_Rooms.localized, defualtValue: 0, finalValue: { livingRooms in
//                            self.livingRooms = livingRooms
//                        })
//                        VilalDivider()
                        SortByCollectionView( title: R.string.localizable.sort_By.localized, items: self.sortByArray) { sortById in
                            print("the sortById is ", sortById)
                            self.sortByID = sortById
                        }
                        VilalDivider()
                        HStack{
                            DefaultBoarderButtonWithIcon(title: R.string.localizable.search.localized,borderColor: .clear ,backgroundColor:R.color.colorPrimary.name.getColor(), titleColor:.white ,actionButton: {
                                self.onDismiss(MainAdRequest(categoryID: self.categoryID ?? "", lat: "", lon: "", price: self.price, room: String(self.bedrooms), bathrooms: String(self.bathroom), lounges: String(self.livingRooms), sort: String(self.sortByID)), self.category)
                                self.onCloseAfterSearch()
                            })
                            .frame(height: 50)
                            
                            DefaultBoarderButtonWithIcon(title: R.string.localizable.edit.localized,borderColor: .clear ,backgroundColor:R.color.colorF5F5F5.name.getColor(), titleColor:R.color.color42526E.name.getColor() ,actionButton: {
                                self.savedData = nil
                                self.savedCategory  = ""
                                self.onClose()
                            })
                            .frame(height: 50)
                        }
                        .padding(.top)
                        
                    }
                    .padding(.horizontal,20)
                }
                .padding(.bottom,25)
                .onAppear {
                    
                    self.category = self.savedCategory ?? ""
                    self.categoryID = self.savedData?.categoryID ?? ""
                    self.sortByID = self.savedData?.sort ?? ""
                    self.price  = self.savedData?.price ?? ""
                    self.propertyArea  = self.savedData?.space ?? ""
                    self.bedrooms  = Int(self.savedData?.room ?? "") ?? 0
                    self.bathroom  = Int(self.savedData?.bathrooms ?? "") ?? 0
                    self.livingRooms  = Int(self.savedData?.lounges ?? "") ?? 0
                }
        }
      
    }
}


struct FilterModel {
    var category: String?
    var price: String?
    var area: String?
    var bedRoom: Int?
    var bathRoom: Int?
    var sortby: String?
}

