//
//  CountryPickerHandler.swift
//  VilalKSA
//
//  Created by Elkilany on 12/12/2023.
//

import CountryPicker
import SwiftUI

struct CountryPickerHandler: UIViewControllerRepresentable {
    
    let onSelect: (( _ chosenCountry: Country) -> Void)?
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> UINavigationController {
        UINavigationController(rootViewController: CountryPickerController.create {
            
            onSelect?($0)}
        )
    }
}
