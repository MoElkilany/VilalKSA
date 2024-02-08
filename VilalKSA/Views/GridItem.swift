//
//  GridView.swift
//  VilalKSA
//
//  Created by Elkilany on 14/01/2024.
//
import SwiftUI

struct GridView: View {
    
    var gridItems: [GridItemModel] = [
        
        GridItemModel(icon: "star", title: "عن الهيئة",action: {
            print("star")
        }),
        GridItemModel(icon: "lock", title: "الملف الشخصي",action: {
            print("lock")
        }),
        GridItemModel(icon: "pencil", title: "المركز الإعلامي",action: {
            print("pencil")
        }),
        GridItemModel(icon: "folder", title: "أدوات",action: {
            print("folder")
        }),
        GridItemModel(icon: "questionmark", title: "الأسئلة المتكررة",action: {
            print("questionmark")
        }),
        GridItemModel(icon: "doc", title: "تغيير اللغه",action: {
            print("doc")
        }),
        GridItemModel(icon: "doc", title: "المكتبة الرقمية",action: {
            print("doc")
        }),
        GridItemModel(icon: "doc", title: "المكتبة الرقمية",action: {
            print("doc")
        }),
        GridItemModel(icon: "doc", title: "المكتبة الرقمية",action: {
            print("doc")
        }),
        GridItemModel(icon: "doc", title: "المكتبة الرقمية",action: {
            print("doc")
        }),
        GridItemModel(icon: "doc", title: "المكتبة الرقمية",action: {
            print("doc")
        }),
        GridItemModel(icon: "doc", title: "المكتبة الرقمية",action: {
            print("doc")
        }),
        GridItemModel(icon: "doc", title: "المكتبة الرقمية",action: {
            print("doc")
        }),
        GridItemModel(icon: "doc", title: "المكتبة الرقمية",action: {
            print("doc")
        }),
        GridItemModel(icon: "doc", title: "المكتبة الرقمية",action: {
            print("doc")
        }),
        GridItemModel(icon: "doc", title: "المكتبة الرقمية",action: {
            print("doc")
        }),
        GridItemModel(icon: "doc", title: "المكتبة الرقمية",action: {
            print("doc")
        }),
        GridItemModel(icon: "doc", title: "المكتبة الرقمية",action: {
            print("doc")
        }),
        GridItemModel(icon: "doc", title: "المكتبة الرقمية",action: {
            print("doc")
        })
    ]
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView(showsIndicators:false){
            LazyVGrid(columns: columns, spacing: 10) {
                
                ForEach(gridItems) { item in
                    
                    VStack {
                        Image(systemName: item.icon ?? "")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                        
                        TextBold12(text: item.title ?? "" , textColor: R.color.color42526E.name.getColor())
                            .frame(maxWidth: .infinity)
                            .padding([.top,.bottom], 10)
                            .multilineTextAlignment(.center)
                        
                    }
                    .frame(width: 161, height: 128)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    .shadow(color: Color.gray.opacity(0.3), radius: 5)
                    .onTapGesture {
                        item.action?()
                    }
                }
            }
            .padding()
        }
        .background(Color.white)
    }
}

struct GridItemModel: Identifiable {
    let id = UUID()
    var icon: String?
    var title: LocalizedStringKey?
    var action: (()->Void)?
}

//#Preview {
//    GridView()
//}


struct GridViewItem: View {
    var icon: String?
    var title: String?
    var action: (()->Void)?
    
    var body: some View {
        
        Button {
            action?()
        } label: {
            VStack {
                URLImage(imageUrl:  icon ?? "",imageWidth: 20,imageHeight: 20)
//                AsyncImage(url: URL(string: icon ?? "")){ phase in
//                    if let image =
//                        phase.image{
//                        image
//                            .frame(width: 50, height: 50, alignment: .center)
//                    }else if phase.error != nil{
//                        Text("Couldn't load image")
//                    }else{
//                        ProgressView()
//                    }
//                }
                
                TextBold12(text: LocalizedStringKey(title ?? "") , textColor: R.color.color42526E.name.getColor())
                    .frame(maxWidth: .infinity)
                    .padding([.top,.bottom], 10)
                    .multilineTextAlignment(.center)
            }
            .frame(width: 161, height: 128)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
            .shadow(color: Color.gray.opacity(0.3), radius: 5)
        }

        
       
    }
}

#Preview {
    GridViewItem(icon: "folder", title: "Test") {
        print("GridViewItem")
    }
}
