//
//  MarkerInfoView.swift
//  VilalKSA
//
//  Created by Elkilany on 24/02/2024.
//

//import SwiftUI
//
//struct MarkerInfoView: View {
//    let price: String?
//    
//    var body: some View {
//        HStack{
//            TextRegular16(text:price , textColor: R.color.color7A869A.name.getColor())
//        }
//        .cornerRadius(20)
//        .background(.blue)
//        .frame(width: 100, height: 50)
//        .customCardStyle()
//    }
//}o

import UIKit

class MarkerInfoView: UIView {
    @IBOutlet weak var priceLab: UILabel!
    @IBOutlet weak var containerView: UIView!
}

