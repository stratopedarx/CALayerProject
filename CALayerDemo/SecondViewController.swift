//
//  SecondViewController.swift
//  CALayerDemo
//
//  Created by Ivan Akulov on 07/12/2016.
//  Copyright © 2016 Ivan Akulov. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = 30
            imageView.layer.masksToBounds = true
            imageView.layer.shadowOpacity = 0.6
            imageView.layer.borderWidth = 20
            imageView.layer.borderColor = UIColor.green.cgColor
            imageView.layer.shadowOffset = CGSize(width: 10, height: 20)
        }
    }

    @IBOutlet weak var button: UIButton! {
        didSet {
            button.layer.cornerRadius = 20
        }
    }

    var gradientLayer: CAGradientLayer! {
        didSet {
            gradientLayer.startPoint = CGPoint(x: 1, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)

            gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientLayer = CAGradientLayer()
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    override func viewDidLayoutSubviews() {
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.frame.height, height: self.view.frame.height)
    }
}
