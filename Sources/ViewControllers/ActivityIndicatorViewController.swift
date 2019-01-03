//
//  ViewController.swift
//  NVActivityIndicatorViewDemo
//
// The MIT License (MIT)

// Copyright (c) 2016 Vinh Nguyen

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import UIKit
import SuperView
import Former

class ActivityIndicatorViewController: FormViewController, NVActivityIndicatorViewable {

    override func viewDidLoad() {
        super.viewDidLoad()

        let cols = 5
        let rows = 8
        let cellWidth = Int(self.view.frame.width / CGFloat(cols))
        let cellHeight = Int(self.view.frame.height / CGFloat(rows))

        let scrollView = UIScrollView(frame: self.view.frame)
        scrollView.bounces = true
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = true
        self.view.addSubview(scrollView)
        (NVActivityIndicatorType.ballPulse.rawValue ... NVActivityIndicatorType.circleStrokeSpin.rawValue).forEach {
            let x = ($0 - 1) % cols * cellWidth
            let y = ($0 - 1) / cols * cellHeight
            let frame = CGRect(x: x, y: y, width: cellWidth, height: cellHeight)
            let activityIndicatorView = NVActivityIndicatorView(frame: frame,
                                                                type: NVActivityIndicatorType(rawValue: $0)!)
            activityIndicatorView.color = UIColor.darkGray
            let animationTypeLabel = UILabel(frame: frame)

            animationTypeLabel.text = String($0)
            animationTypeLabel.sizeToFit()
            animationTypeLabel.textColor = UIColor.darkGray
            animationTypeLabel.frame.origin.x += CGFloat(cellWidth)/2 - animationTypeLabel.frame.size.width/2
            animationTypeLabel.frame.origin.y += CGFloat(cellHeight) - animationTypeLabel.frame.size.height

            activityIndicatorView.padding = 20
            if $0 == NVActivityIndicatorType.orbit.rawValue {
                activityIndicatorView.padding = 0
            }
            scrollView.addSubview(activityIndicatorView)
            scrollView.addSubview(animationTypeLabel)
            activityIndicatorView.startAnimating()

            let button: UIButton = UIButton(frame: frame)
            button.tag = $0
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            scrollView.addSubview(button)
        }
    }

    @objc func buttonTapped(_ sender: UIButton) {
        let size = CGSize(width: 30, height: 30)

        self.startAnimating(size, message: SuperView.shared.options.activityIndicator.message, type: NVActivityIndicatorType(rawValue: sender.tag)!, fadeInAnimation: nil)
        SuperView.shared.options.activityIndicator.type = sender.tag

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
//            NVActivityIndicatorPresenter.sharedInstance.setMessage("Authenticating...")
            self.navigationController?.popViewController(animated: true)
        }

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.stopAnimating(nil)
        }
    }
}
