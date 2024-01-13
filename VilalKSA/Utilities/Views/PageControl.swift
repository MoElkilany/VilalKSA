//
//  PageControl.swift
//  SCISP
//
//  Created by Mohamed Abdulrahman on 31/05/2023.
//

import SwiftUI

struct PageControl: UIViewRepresentable {
    var numberOfPages: Int
    @Binding var currentPage: Int {
        didSet {
            pageControl.currentPage = self.currentPage
        }
    }
    var pageIndicatorTintColor: UIColor?
    var currentPageIndicatorTintColor: UIColor?
    
    private let pageControl = UIPageControl()
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UIPageControl {
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPage = currentPage
        pageControl.pageIndicatorTintColor = pageIndicatorTintColor ?? UIColor.gray
        pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor ?? UIColor.white
        pageControl.addTarget(context.coordinator, action: #selector(Coordinator.updateCurrentPage(sender:)), for: .valueChanged)
        return pageControl
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
    
    
    class Coordinator: NSObject {
        var control: PageControl
        
        init(_ control: PageControl) {
            self.control = control
        }
        
        @objc func updateCurrentPage(sender: UIPageControl) {
            control.currentPage = sender.currentPage
        }
    }
}
