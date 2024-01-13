//
//  Image+Extension .swift
//  VilalKSA
//
//  Created by Elkilany on 21/11/2023.
//

import Foundation
import SwiftUI
import Kingfisher

extension Image {
    init(base64String: String, placeholder: String = "") {
        guard  base64String != "" else {
            self = Image(placeholder)
            return

        }
        guard let data = Data(base64Encoded: base64String), base64String != "" else {
            self = Image(placeholder)
            return
        }
        guard let uiImage = UIImage(data: data) else {
            self = Image(placeholder)
            return
        }
        self = Image(uiImage: uiImage)
    }
}
