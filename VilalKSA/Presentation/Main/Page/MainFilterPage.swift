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
    
    @StateObject var viewModel = MainViewModel()
    @State var categorysList: [LookUpModel] = []
    @State var price: String = ""
    @State var propertyArea: String = ""
    @State var bedrooms: Int  = 1
    @State var bathroom: Int  = 1
    var onClose: () -> Void
    var onDismiss: (FilterModel) -> Void
    
    @State private var openPlacesSheet: Bool = false
    @State var category: String = ""
    @State var categoryID: String? = ""
    @State var sortByID: String  = ""

    
    
    let sortByArray: [SortByModel] = [
        SortByModel(id: 1, name: R.string.localizable.lowest_Price.localized, isSelected: false),
        SortByModel(id: 2, name: R.string.localizable.highest_Price.localized, isSelected: false),
        SortByModel(id: 3, name: R.string.localizable.nearest.localized, isSelected: false)
    ]
    
    var body: some View {
        ActionSheetView(bgColor: .white) {
            
            StateOnContentView(state: $viewModel.state, stateError: viewModel.categorysError) {
                ScrollView {
                    VStack{
                        HStack{
                            TextBold18(textKey: R.string.localizable.classification.localized, textColor: R.color.colorPrimary.name.getColor())
                            Spacer()
                        }
                        .padding()
                        
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

                        
                        .popover(isPresented: $openPlacesSheet) {
                            NavigationView {
                                VStack{
                                    Text("ــــ")
                                        .bold()
                                    List{
                                        ForEach(self.categorysList ,id: \.self) { item in
                                            Button(action: {
                                                openPlacesSheet = false
                                                self.category = item.name ?? ""
                                                self.categoryID = String(item.id ?? 0)
                                            }, label: {
                                                Text(item.name ?? "")
                                                    .foregroundColor(Color.black)
                                                    .multilineTextAlignment(.center)
                                            })
                                            .padding()
                                        }
                                    }
                                }
                            }
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
                        SortByCollectionView( title: R.string.localizable.sort_By.localized, items: self.sortByArray) { sortById in
                            print("the sortById is ", sortById)
                            self.sortByID = sortById
                        }
                                                
                        VilalDivider()
                        
                        HStack{
                            DefaultBoarderButtonWithIcon(title: R.string.localizable.apply.localized,borderColor: .clear ,backgroundColor:R.color.colorPrimary.name.getColor(), titleColor:.white ,actionButton: {
                                self.onDismiss(FilterModel(category: self.categoryID ?? "" , price: self.price  , area: self.propertyArea, bedRoom: self.bedrooms, bathRoom: self.bathroom, sortby: self.sortByID))
                                self.onClose()
                            })
                            .frame(height: 50)
                            
                            DefaultBoarderButtonWithIcon(title: R.string.localizable.cancel.localized,borderColor: .clear ,backgroundColor:R.color.colorF5F5F5.name.getColor(), titleColor:R.color.color42526E.name.getColor() ,actionButton: {
                                self.onClose()
                            })
                            .frame(height: 50)
                        }
                        .padding(.top)
                        
                    }
                    .padding(.horizontal,20)
                }
            }
        }
        .task {
            self.viewModel.getMainCategory()
        }
        .onReceive(self.viewModel.$categorysList) { category in
            self.categorysList = category
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

