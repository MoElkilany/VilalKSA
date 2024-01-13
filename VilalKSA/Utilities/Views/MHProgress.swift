//
//  MHProgress.swift
//  CleanArchtectureD
//
//  Created by Admin on 22/09/2021.
//

import NVActivityIndicatorView
import UIKit


class MHProgress: UIView {
    private var indecator: NVActivityIndicatorView?
    private let containerView = UIVisualEffectView()
    private let title = UILabel()

    static let sharedMHP = MHProgress()

    private init() {
        let size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 100)
        let origin = CGPoint(x: 0, y: 100)
        let rect = CGRect(origin: origin, size: size)
        super.init(frame: rect)
        configureContainer()
    }

    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func configureContainer() {
        backgroundColor = UIColor.clear
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
        containerView.backgroundColor = .clear
        //		containerView.layer.borderColor = ColorName.mtBorderColor.color.cgColor
        //		containerView.layer.borderWidth = 2
        // containerView.layer.opacity = 1
        // containerView.effect = UIBlurEffect(style: .light)
        containerView.frame.size = CGSize(width: 110, height: 110)
        containerView.frame.origin = CGPoint(x: UIScreen.main.bounds.width / 2 - containerView.frame.width / 2,
                                             y: (UIScreen.main.bounds.height - 100) / 2 - containerView.frame.height / 2)
        indecator = NVActivityIndicatorView(frame: containerView.frame,
                                            type: .lineSpinFadeLoader,
                                            color: UIColor.gray,
                                            padding: 30)
        let x = CGFloat((containerView.frame.width / 2) - ((indecator?.frame.width)! / 2))
        let y = CGFloat((containerView.frame.height / 2) - ((indecator?.frame.height)! / 2))
        indecator?.frame.origin = CGPoint(x: x,
                                          y: y)
        title.frame.size = CGSize(width: containerView.frame.width - 10, height: 40)
        title.frame.origin = CGPoint(x: ((containerView.frame.width) / 2) - (title.frame.width / 2),
                                     y: (containerView.frame.height) - 45)
        title.textColor = #colorLiteral(red: 0, green: 0.2716432937, blue: 0.3464305065, alpha: 1)
        title.textAlignment = .center
        title.adjustsFontSizeToFitWidth = true
        title.minimumScaleFactor = 0.5
        title.font = UIFont.systemFont(ofSize: 15)
        title.numberOfLines = 0

        containerView.contentView.addSubview(indecator!)
        containerView.contentView.addSubview(title)
        containerView.bringSubviewToFront(title)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
    }

    func show(with title: String = "") {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.title.text = title
            self.indecator?.startAnimating()
            UIApplication.shared.windows.first?.addSubview(self)
            // UIApplication.shared.windows.last?.bringSubviewToFront(self)
        }
    }

    func hide() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.indecator?.stopAnimating()
            self.title.text = ""
            self.removeFromSuperview()
        }
    }
}
