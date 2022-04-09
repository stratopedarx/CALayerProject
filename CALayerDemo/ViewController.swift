//
//  ViewController.swift
//  CALayerDemo
//
//  Created by Ivan Akulov on 07/12/2016.
//  Copyright © 2016 Ivan Akulov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var shapeLayer: CAShapeLayer! {
        didSet {
            // свойства, которые меняться не будут
            shapeLayer.lineWidth = 20    // толщина линии
            shapeLayer.lineCap = .round  // загругленные края
            shapeLayer.fillColor = nil   // что бы фигура не заполнялась дефолтным черным цветом
            shapeLayer.strokeEnd = 1     // нужно, что бы понять где мы хотим отрисовать нашу фигуру. от 0 до 1. 1 - это финиш
            shapeLayer.strokeColor = UIColor.gray.cgColor
        }
    }

    // второй элемент, который будет показывать загрузку
    var overShapeLayer: CAShapeLayer! {
        didSet {
            // свойства, которые меняться не будут
            overShapeLayer.lineWidth = 20    // толщина линии
            overShapeLayer.lineCap = .round  // загругленные края
            overShapeLayer.fillColor = nil   // что бы фигура не заполнялась дефолтным черным цветом
            overShapeLayer.strokeEnd = 0     // нужно, что бы понять где мы хотим отрисовать нашу фигуру. от 0 до 1. 1 - это финиш
            overShapeLayer.strokeColor = UIColor.white.cgColor
        }
    }

    var gradientLayer: CAGradientLayer! {
        didSet {
            // определяем начальную и конечную точку нашего градиента
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)  // левый верхний угол
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)  // правый нижний угол

            // массив цветов
            gradientLayer.colors = [UIColor.gray.cgColor, UIColor.blue.cgColor]
            // чтобы цвета неравномерно распределялись
//            gradientLayer.locations = [0, 0.2, 1]
        }
    }

    @IBOutlet weak var imageView: UIImageView! {
        // срабатывает при присваивании значений (так же при инициализации)
        didSet {
            imageView.layer.cornerRadius = imageView.frame.size.height / 2
            imageView.layer.masksToBounds = true

            // настраиваем рамку
            let borderColor = UIColor.white
            imageView.layer.borderColor = borderColor.cgColor
            imageView.layer.borderWidth = 10
        }
    }

    @IBOutlet weak var button: UIButton! {
        didSet {
            button.layer.shadowOffset = CGSize(width: 0, height: 10)
            button.layer.shadowOpacity = 1
            button.layer.shadowRadius = 5
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // инициализация градиента. Делаем это только один раз
        gradientLayer = CAGradientLayer()
        // добавляем в качестве подслоя нашего основного вью
        view.layer.insertSublayer(gradientLayer, at: 0)  //  0 - хотим, что бы он был самым первым

        // указываем в каких пределах будет отрисовываться наш слой. делаем это в методе viewDidLayoutSubviews

        shapeLayer = CAShapeLayer()
        view.layer.addSublayer(shapeLayer)

        overShapeLayer = CAShapeLayer()
        view.layer.addSublayer(overShapeLayer)
    }

    @IBAction func actionButton(_ sender: UIButton) {
        overShapeLayer.strokeEnd += 0.2
        if overShapeLayer.strokeEnd == 1 {
            performSegue(withIdentifier: "showSecondScreen", sender: self)
        }
    }
    

    // срабатывает когда меняет ориентация нашего устройства
    override func viewDidLayoutSubviews() {
        // указываем в каких пределах будет отрисовываться наш слой
        // каждый раз когда меняется рамка мы пересчитываем градиент
//        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)

        // к примеру хотим сделать градиент до половины фотографии
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 20 + 21 + imageView.frame.height / 2)

        // здесь занимаемся отрисовкой траектории нашей shapeLayer
        configShapeLayer(shapeLayer)
        configShapeLayer(overShapeLayer)
    }

    private func configShapeLayer(_ shapeLayer: CAShapeLayer) {
        shapeLayer.frame = view.bounds
        let path = UIBezierPath()
        let startPoint = CGPoint(x: self.view.frame.width / 2 - 100, y: self.view.frame.height / 2)
        let endPoint = CGPoint(x: self.view.frame.width / 2 + 100, y: self.view.frame.height / 2)
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        shapeLayer.path = path.cgPath
    }
}

