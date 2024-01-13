//
//  BaseViewModel.swift
//  VilalKSA
//
//  Created by Elkilany on 12/01/2024.
//

import Combine

protocol ViewModelProtocol: ObservableObject {
    var state: AppState { get set }
    var errorPopUp: Bool { get set }
    var errorMessage: String { get set }
    func handle(error: APIError)
    func handleSuccess<T>(_ value: T)
}
  

class BaseViewModel:ViewModelProtocol,ObservableObject {
    
       @Published var state: AppState = .success
       @Published var errorPopUp: Bool = false
       @Published var errorMessage: String = ""
    
    
    
    func handle(error: APIError) {
        self.state = .error

        switch error {
        case .errorMessage(let message, _):
            print("Error Message: \(message)")
            self.errorPopUp = true
            self.errorMessage = message
        default:
            print("An unknown error occurred.")
            self.errorPopUp = true
            self.errorMessage = "An unknown error occurred."
        }
    }
    
    func handleSuccess<T>(_ value: T) {
    
    }
}
