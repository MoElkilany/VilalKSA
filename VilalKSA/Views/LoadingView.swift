//
//  LoadingView.swift
//  MTSuperMobileApp
//
//  Created by Mohamed Hussein on 31/10/2021.
//

import Foundation
import NVActivityIndicatorView
import StatefulViewController
import UIKit

class LoadingView: BaseStateView {
    @IBOutlet var indicator: NVActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        indicator.type = .ballSpinFadeLoader
        indicator.startAnimating()
    }
}
