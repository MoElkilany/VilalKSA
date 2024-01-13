//
//  VerbosPlugin.swift
//  SCISP
//
//  Created by Mohamed Abdulrahman on 12/07/2023.
//

import Foundation
import Moya

struct VerbosePlugin: PluginType {
    let verbose: Bool

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        #if DEBUG
        if let body = request.httpBody,
           let json = try? JSONSerialization.jsonObject(with: body, options: .mutableContainers),
           let data = try? JSONSerialization.data(withJSONObject: json , options: JSONSerialization.WritingOptions.prettyPrinted),
           var convertedString = String(data: data, encoding: String.Encoding.utf8) {
            if verbose {
                print("========Request Body Of  \(target.baseURL)\(target.path)=========")
                print(convertedString)
                print("===================================================")
            }
        } else {
            if verbose {
                print("========Request Headers Of \(target.baseURL)\(target.path)=========")
                print("\(request.headers)")
                print("===================================================")
            }
        }
        #endif
        return request
    }

    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        #if DEBUG
        switch result {
        case .success(let body):
            if verbose {
                print("=============Response Body Of  \(target.baseURL)\(target.path)=============")
                if let json = try? JSONSerialization.jsonObject(with: body.data, options: .mutableContainers),
                   let data = try? JSONSerialization.data(withJSONObject: json , options: JSONSerialization.WritingOptions.prettyPrinted),
                   var convertedString = String(data: data, encoding: String.Encoding.utf8) {
                    print("response json =======> \(convertedString)")
                } else {
                    let response = String(data: body.data, encoding: .utf8)!
                    print("response data =======> \(response)")
                }
                print("==============================================================")
            }
        case .failure( _):
            break
        }
        #endif
    }

}
