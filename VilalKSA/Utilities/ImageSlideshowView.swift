//
//  ImageSlideshowView.swift
//  VilalKSA
//
//  Created by Elkilany on 25/02/2024.
//

import SwiftUI
import ImageSlideshow

struct ImageSlideshowView: UIViewRepresentable {
    let imageUrls: [String]
    
    func makeUIView(context: Context) -> ImageSlideshow {
        let imageSlideShow = ImageSlideshow()
        
        var images = [InputSource]()
        
        for urlString in imageUrls {
          if let url = URL(string: urlString) {
                images.append(KingfisherSource(url: url))
            }
        }
        
        imageSlideShow.backgroundColor = .gray
        imageSlideShow.slideshowInterval = 2.0
        imageSlideShow.contentScaleMode = .scaleAspectFill
        imageSlideShow.layer.cornerRadius = 8
        imageSlideShow.setImageInputs(images)
        imageSlideShow.pageIndicatorPosition = PageIndicatorPosition(horizontal: .center, vertical: .customBottom(padding: -10))
        
        let gestureRecognizer = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.didTap(_:)))
        imageSlideShow.addGestureRecognizer(gestureRecognizer)
        
        return imageSlideShow
    }
    
    func updateUIView(_ uiView: ImageSlideshow, context: Context) {
        // Update the view here if needed
    }
    
    func makeCoordinator() -> Coordinator {
           return Coordinator()
       }
       
       class Coordinator: NSObject {
           @objc func didTap(_ gestureRecognizer: UITapGestureRecognizer) {
               // Access the slideshow view from the gesture recognizer's view property
               if let slideshow = gestureRecognizer.view as? ImageSlideshow {
                   
                   slideshow.presentFullScreenController(from: UIApplication.shared.windows.first?.rootViewController ?? UIViewController())
               }
           }
       }
   }



import AVKit
//struct VideoPlayerView: UIViewControllerRepresentable {
//    let videoURL: URL
//    
//    func makeUIViewController(context: Context) -> AVPlayerViewController {
//        let player = AVPlayer(url: videoURL)
//        let playerViewController = AVPlayerViewController()
//        playerViewController.player = player
//        return playerViewController
//    }
//    
//    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
//        // Update logic goes here if needed
//    }
//}


struct VideoPlayerView: View {
    let videoURL: URL
    
    var body: some View {
        VStack {
            Button(action: {
                let player = AVPlayer(url: videoURL)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
             UIApplication.shared.windows.first?.rootViewController?.present(playerViewController, animated: true, completion: {
                    player.play()
                })
            }) {
                TextBold16(textKey: R.string.localizable.showVideo.localized, textColor: R.color.color42526E.name.getColor())
            }
        }
    }
}
