//
//  ErrorMessage.swift
//  VilalKSA
//
//  Created by Elkilany on 04/01/2024.
//

import Foundation

struct ErrorMessage {
    var message: String
    var status: Int

}

extension ErrorMessage: Codable {
//    enum CodingKeys: String, CodingKey {
//        case status
//        case message
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        status = try container.decodeIfPresent(Int.self, forKey: .status) ?? 0
//        message = try container.decodeIfPresent(String.self, forKey: .message) ?? ""
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encodeIfPresent(status, forKey: .status)
//        try container.encodeIfPresent(message, forKey: .message)
//    }
}
