//
//  PropertyInterfaceView.swift
//  VilalKSA
//
//  Created by Elkilany on 12/02/2024.
//


import SwiftUI



struct PropertyInterfaceView: View {
    @State private var selectedItem: LookUpModel? = nil
    let items: [LookUpModel]
    let onSelected: ((String)->())
    
    var body: some View {

        let columns = [
            GridItem(.fixed(40)),
            GridItem(.fixed(40)),
        ]
        
        VStack(spacing:0){
            HStack{
                TextBold14(textKey:R.string.localizable.facade.localized, textColor: R.color.colorPrimary.name.getColor())
                Spacer()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: columns, alignment: .center, spacing: 10) {
                    ForEach(items,id:\.id ){ item in
                        ItemView(
                            item: item,
                            isSelected: $selectedItem
                        )
                        .onTapGesture {
                            selectedItem = item
                            onSelected(String(item.id ?? 0))
                        }
                    }
                }
            }
            .padding(.horizontal,8)
            .padding(.vertical,2)
        }
    }
    
    
}

struct ItemView: View {
    let item: LookUpModel
    @Binding var isSelected: LookUpModel?
    
    var body: some View {
        
        TextRegular14(text:( item.name), textColor: isSelected == item ? .white : R.color.color42526E.name.getColor())
        
            .padding(.vertical,4)
            .padding(.horizontal,8)
            .background(isSelected == item ? R.color.colorPrimary.name.getColor(): Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(R.color.colorE2E8F0.name.getColor(), lineWidth: isSelected == item ? 0 : 1)
            )
            .cornerRadius(18)
    }
}





struct ScrollCollectionView: View {
    @State private var selectedItem: LookUpModel? = nil
    let title:LocalizedStringKey

    let items: [LookUpModel]
    let onSelected: ((String)->())
    var body: some View {
        
        let columns = [
            GridItem(.fixed(30)),
        ]
        
        VStack(spacing:0){
            HStack{
                
                TextBold14(textKey:title, textColor: R.color.colorPrimary.name.getColor())
                Spacer()
            }
            
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: columns, alignment: .center, spacing: 0) {
                    ForEach(items,id:\.id ){ item in
                        ItemView2(
                            item: item,
                            isSelected: $selectedItem
                        )
                        .padding()
                        .onTapGesture {
                            selectedItem = item
                            onSelected(String(item.id ?? 0))
                        }
                    }
                }
            }
            .padding(.horizontal,8)
            .padding(.vertical,2)
        }
    }
    
    
}

struct ItemView2: View {
    let item: LookUpModel
    @Binding var isSelected: LookUpModel?
    
    var body: some View {
        
        TextRegular14(text:( item.name), textColor: isSelected == item ? .white : R.color.color7A869A.name.getColor())
            .padding(.horizontal,35)
            .padding(.vertical,10)
            .background(isSelected == item ? R.color.colorPrimary.name.getColor(): R.color.colorF7F8F8.name.getColor())
            .cornerRadius( 25)

        
    }
}


struct MainCollectionView: View {
    @State private var selectedItem: LookUpModel? = nil
    let title:LocalizedStringKey
    
    let items: [LookUpModel]
    let onSelected: ((String)->())
    var body: some View {
        
        let columns = [
            GridItem(.fixed(10)),
        ]
        
        VStack(spacing:15){
            HStack{
                
                TextBold14(textKey:title, textColor: R.color.colorPrimary.name.getColor())
                Spacer()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: columns, alignment: .center, spacing: 0) {
                    ForEach(items,id:\.id ){ item in
                        MainItemView(
                            item: item,
                            isSelected: $selectedItem
                        )
                        .padding(.horizontal,5)
                        .onTapGesture {
                            selectedItem = item
                            onSelected(String(item.id ?? 0))
                        }
                    }
                }
            }
            .padding(.horizontal,2)
            .padding(.vertical,2)
        }
    }
}

struct MainItemView: View {
    let item: LookUpModel
    @Binding var isSelected: LookUpModel?
    
    var body: some View {
        
        TextRegular14(text:( item.name), textColor: isSelected == item ? .white : R.color.color7A869A.name.getColor())
            .padding(.horizontal,15)
            .padding(.vertical,10)
            .background(isSelected == item ? R.color.colorPrimary.name.getColor(): R.color.colorF7F8F8.name.getColor())
            .cornerRadius( 25)

        
    }
}




struct SortByCollectionView: View {
    @State private var selectedItem: SortByModel? = nil
    let title:LocalizedStringKey
    
    let items: [SortByModel]
    let onSelected: ((String)->())
    var body: some View {
        
        let columns = [
            GridItem(.fixed(10)),
        ]
        
        VStack(spacing:15){
            HStack{
                
                TextBold14(textKey:title, textColor: R.color.colorPrimary.name.getColor())
                Spacer()
            }
            
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: columns, alignment: .center, spacing: 0) {
                    ForEach(items,id:\.id ){ item in
                        SortByItemView(
                            item: item,
                            isSelected: $selectedItem
                        )
                        .padding(.horizontal,5)
                        .onTapGesture {
                            selectedItem = item
                            onSelected(String(item.id ?? 0))
                        }
                    }
                }
            }
            .padding(.horizontal,2)
            .padding(.vertical,2)
        }
    }
}

struct SortByItemView: View {
    let item: SortByModel
    @Binding var isSelected: SortByModel?
    
    var body: some View {
        
        TextRegular14(textKey:( item.name), textColor: isSelected == item ? .white : R.color.color7A869A.name.getColor())
            .padding(.horizontal,15)
            .padding(.vertical,10)
            .background(isSelected == item ? R.color.colorPrimary.name.getColor(): R.color.colorF7F8F8.name.getColor())
            .cornerRadius( 25)

        
    }
}


struct SortByModel:Equatable {
    let id: Int?
    let name: LocalizedStringKey?
    var isSelected: Bool? = false
  
}
