//
//  BaseStateView.swift
//  MTSuperMobileApp
//
//  Created by Mohamed Hussein on 02/11/2021.
//

import StatefulViewController
import UIKit

class BaseStateView: UIView, StatefulPlaceholderView {
    enum StateViewType {
        case Controller
        case Cell
    }

    var type: StateViewType?
    var controllerTopMargin: Double = 100
    var controllerbottomMargin: Double = 0

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func placeholderViewInsets() -> UIEdgeInsets {
        switch type {
        case .Controller:
            // self.backgroundColor = Asset.stateViewBackground.color
            return UIEdgeInsets(top: CGFloat(controllerTopMargin), left: 0, bottom: CGFloat(controllerbottomMargin), right: 0)
        case .Cell:
            backgroundColor = UIColor.clear
            return UIEdgeInsets(top: 60, left: 0, bottom: 10, right: 0)
        default:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}
