//
//  ImageView.swift
//  SCISP
//
//  Created by Mohamed Abdulrahman on 04/06/2023.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var data = Data()

    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}

struct ImageView: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var image:UIImage = UIImage()

    init(withURL url:String) {
        imageLoader = ImageLoader(urlString:url)
    }

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .onReceive(imageLoader.$data) { data in
                self.image = UIImage(data: data) ?? UIImage()
            }
    }
}

