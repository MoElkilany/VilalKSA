//
//  CalenderPage.swift
//  VilalKSA
//
//  Created by Elkilany on 25/03/2024.
//

import SwiftUI
import UIPilot

struct CalenderPage: View {
    
    
    @EnvironmentObject var pilot: UIPilot<AddRequestDestination>
    @EnvironmentObject var mainPilot: UIPilot<MainDestination>
    @EnvironmentObject var servicesPilot: UIPilot<ServicesDestination>
    @EnvironmentObject var favoritePilot: UIPilot<FavoritesDestination>
    
    var onClose: () -> Void
    var onTap : (String,String,String) -> Void
    @State private var cardNumber: String = ""
    @State private var arrivalDate   = Date()
    @State private var departureDate = Date()
    @State private var arrivalStringDate: String = ""
    @State private var departureStringDate: String = ""
    
    @State private var selectArrivalDate: Bool = false
    @State private var selectDepartureDate: Bool = false
    
    @State var submitButton = false
    @State var isDateError = false
    @State  var dateError: String = ""

    
    var body: some View {
        ActionSheetView(bgColor: .white) {
            ScrollView {
                VStack{
                    HStack{
                        TextBold18(textKey: R.string.localizable.select_Date.localized, textColor: R.color.colorPrimary.name.getColor())
                        Spacer()
                    }
                    
                    HStack {
                        VStack(alignment: .leading,spacing: 0) {
                            TextBold14(textKey: R.string.localizable.arrival_Date.localized, textColor: R.color.colorPrimary.name.getColor())
                                .padding(.bottom,0)
                                .padding(.leading)
                            Button {
                                
                                selectArrivalDate = true
                            } label: {
                                VilalTextField(text: $arrivalStringDate, placeholder:  R.string.localizable.arrival_Date.localized, imageName:"" , keyboardType: .asciiCapableNumberPad, validationInput: .word, submitButton: submitButton, onSubmit: { isValid in
                                })
                                .disabled(true)
                            }
                        }
                        
                        
                        VStack(alignment: .leading,spacing: 0) {
                            TextBold14(textKey: R.string.localizable.departure_Date.localized, textColor: R.color.colorPrimary.name.getColor())
                                .padding(.bottom,0)
                                .padding(.leading)
                            Button {
                                selectDepartureDate = true
                            } label: {
                                VilalTextField(text: $departureStringDate, placeholder:  R.string.localizable.departure_Date.localized, imageName:"" , keyboardType: .asciiCapableNumberPad, validationInput: .word, submitButton: submitButton, onSubmit: { isValid in
                                    
                                })
                                .disabled(true)
                            }
                        }
                    }
                    .padding(.vertical,20)
                    VilalDivider()
                    
                    HStack{
                        DefaultBoarderButtonWithIcon(title: R.string.localizable.book.localized,borderColor: .clear ,backgroundColor:R.color.colorPrimary.name.getColor(), titleColor:.white ,actionButton: {
                            self.submitButton = true
                            
                            
                            if arrivalStringDate < departureStringDate || arrivalStringDate == departureStringDate {
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "yyyy-MM-dd"
                                if let startDate = dateFormatter.date(from: arrivalStringDate),
                                    let endDate = dateFormatter.date(from: departureStringDate) {
                                    let days = numberOfDaysBetween(startDate: startDate, endDate: endDate)
                                    if days == "0"{
                                        onTap(self.arrivalStringDate,self.departureStringDate,"1")
                                    }else{
                                        onTap(self.arrivalStringDate,self.departureStringDate,days)
                                    }
                                   
                                } else {
                                    return
                                }
                            }else{
                                isDateError = true
                            }
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

            .sheet(isPresented: $selectArrivalDate,onDismiss: {
                arrivalStringDate = dateToString(date: arrivalDate)
            }) {
                VStack{
                    VStack(alignment:.trailing){
                        TextBold14(textKey: R.string.localizable.arrival_Date.localized ,textColor: R.color.colorPrimary.name.getColor())
                        DatePicker("Select a Date", selection: $arrivalDate, in: Date()..., displayedComponents: .date)
                            .environment(\.locale, Locale(identifier:  UserDefaults.standard.string(forKey: UserDefaultKeys.currentLanguage.rawValue) ?? "ar"))
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .padding()
                    }
                    .padding()
                    
                    DefaultButton(title:  R.string.localizable.choose_Option.localized, backgroundColor: R.color.colorPrimary.name.getColor() ,action: {
                        selectArrivalDate = false
                    }, fontWeight: .bold)
                }
            }
            .sheet(isPresented: $selectDepartureDate,onDismiss: {
                departureStringDate = dateToString(date: departureDate)
            }) {
                VStack{
                    VStack(alignment:.trailing){
                        TextBold14(textKey: R.string.localizable.departure_Date.localized ,textColor: R.color.colorPrimary.name.getColor())
                        DatePicker("Select a Date", selection: $departureDate, in: Date()..., displayedComponents: .date)
                            .environment(\.locale, Locale(identifier:  UserDefaults.standard.string(forKey: UserDefaultKeys.currentLanguage.rawValue) ?? "ar"))
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .padding()
                    }
                    .padding()
                    DefaultButton(title:  R.string.localizable.choose_Option.localized, backgroundColor: R.color.colorPrimary.name.getColor() ,action: {
                        selectDepartureDate = false
                    }, fontWeight: .bold)
                }
            }
            
            .popup(isPresented: $isDateError) {
                ErrorToast(title: R.string.localizable.end_Date_Must_Be_Greater.localized)
            } customize: {
                $0
                    .type(.floater())
                    .position(.top)
                    .animation(.spring())
                    .autohideIn(5)
            }
        }
    }

    func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "En")
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    
    func numberOfDaysBetween(startDate: Date, endDate: Date) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        return String(components.day ?? 0)
    }
   
}

