//
//  Loading.swift
//  ERMDemoApp
//
//  Created by eXNodes on 11/14/17.
//  Copyright © 2017 eXNodes. All rights reserved.
//

import UIKit

final class Loading: UIView {

    private lazy var spinner = UIActivityIndicatorView(style: .gray)
    var isActive: Bool = false
    var isRefresh: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        let background = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        background.center = self.center
        background.backgroundColor = .clear
        background.alpha = 0.5
        background.layer.cornerRadius = 15.0
        background.layer.masksToBounds = true
        addSubview(background)

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }

    private static var shareInstance = Loading(frame: UIScreen.main.bounds)

    public class func defaults() -> Loading {
        return shareInstance
    }

    func start() {
        DispatchQueue.main.async {
            let view = UIApplication.shared.keyWindow

            view?.addSubview(self)
            let x = UIScreen.main.bounds.width / 2
            let y = UIScreen.main.bounds.height / 2

            self.spinner.isHidden = false
            self.spinner.center = CGPoint(x: x, y: y)
            self.spinner.startAnimating()

            self.addSubview(self.spinner)
            self.isActive = true

        }
    }

    @objc private func resetRefresh() {
        isRefresh = false
    }

    func stop() {
        DispatchQueue.main.async {
            self.resetRefresh()
            self.isActive = false
            self.removeFromSuperview()
        }
    }
}
