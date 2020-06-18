//
//  GradientViewController.swift
//  GradientGenerator
//
//  Created by Yonghyun on 2020/05/05.
//  Copyright © 2020 Yonghyun. All rights reserved.
//

import UIKit
import ReactorKit
import RxCocoa
import RxSwift

class GradientViewController: UIViewController, StoryboardView {
    
    @IBOutlet var gradientView: UIImageView!
    @IBOutlet var colorImage0:  UIImageView!
    @IBOutlet var colorImage1:  UIImageView!
    @IBOutlet var colorImage2:  UIImageView!

    @IBOutlet var colorImage0Background: UIView!
    @IBOutlet var colorImage1Background: UIView!
    @IBOutlet var colorImage2Background: UIView!
    
    @IBOutlet var redSlider:   UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider:  UISlider!
    @IBOutlet var alphaSlider: UISlider!
    
    @IBOutlet var redValueLabel:   UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel:  UILabel!
    @IBOutlet var alphaValueLabel: UILabel!
    
    @IBOutlet var hexCodeTextField: UITextField!
    
    var color0 = [Int]()
    var color1 = [Int]()
    var color2 = [Int]()
    
    var selectedColor: String!
    var gradient: CAGradientLayer!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        overrideUserInterfaceStyle = .light

        colorImage0Background.layer.borderWidth  = 2
        colorImage1Background.layer.borderWidth  = 2
        colorImage2Background.layer.borderWidth  = 2
        colorImage0Background.layer.cornerRadius = 10
        colorImage1Background.layer.cornerRadius = 10
        colorImage2Background.layer.cornerRadius = 10
        colorImage0Background.layer.borderColor  = UIColor.black.cgColor
        colorImage1Background.layer.borderColor  = UIColor.white.cgColor
        colorImage2Background.layer.borderColor  = UIColor.white.cgColor
        
        self.hexCodeTextField.isEnabled = false
        
        if  UserDefaults.exists(key: UserDefaultKey.color0) &&
            UserDefaults.exists(key: UserDefaultKey.color1) &&
            UserDefaults.exists(key: UserDefaultKey.color2) {
            color0 = UserDefaults.standard.array(forKey: UserDefaultKey.color0) as? [Int] ?? [Int]()
            color1 = UserDefaults.standard.array(forKey: UserDefaultKey.color1) as? [Int] ?? [Int]()
            color2 = UserDefaults.standard.array(forKey: UserDefaultKey.color2) as? [Int] ?? [Int]()
        }
        else {
            color0.append(contentsOf: [34, 193, 195, 100])
            color1.append(contentsOf: [150, 190, 116, 100])
            color2.append(contentsOf: [255, 199, 80, 100])
        }

        selectedColor = "color0"
        self.gradient = CAGradientLayer()
        gradient.frame = self.gradientView.bounds
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint   = CGPoint(x: 0.5, y: 1)
        
        gradient.colors = [
            UIColor(red:   CGFloat(color0[0])/255,
                    green: CGFloat(color0[1])/255,
                    blue:  CGFloat(color0[2])/255,
                    alpha: CGFloat(color0[3])/100).cgColor, // Top
            UIColor(red:   CGFloat(color1[0])/255,
                    green: CGFloat(color1[1])/255,
                    blue:  CGFloat(color1[2])/255,
                    alpha: CGFloat(color1[3])/100).cgColor, // Middle
            UIColor(red:   CGFloat(color2[0])/255,
                    green: CGFloat(color2[1])/255,
                    blue:  CGFloat(color2[2])/255,
                    alpha: CGFloat(color2[3])/100).cgColor, // Bottom
        ]
        
        gradient.locations = [0, 0.5, 1]
        gradientView.layer.addSublayer(gradient)
        
        self.colorImage0.image = UIImage.from(color: UIColor(red:   CGFloat(color0[0])/255,
                                                             green: CGFloat(color0[1])/255,
                                                             blue:  CGFloat(color0[2])/255,
                                                             alpha: CGFloat(color0[3])/100),
                                              width:  colorImage0.bounds.width,
                                              height: colorImage0.bounds.height)
        self.colorImage1.image = UIImage.from(color: UIColor(red:   CGFloat(color1[0])/255,
                                                             green: CGFloat(color1[1])/255,
                                                             blue:  CGFloat(color1[2])/255,
                                                             alpha: CGFloat(color1[3])/100),
                                              width:  colorImage1.bounds.width,
                                              height: colorImage1.bounds.height)
        self.colorImage2.image = UIImage.from(color: UIColor(red:   CGFloat(color2[0])/255,
                                                             green: CGFloat(color2[1])/255,
                                                             blue:  CGFloat(color2[2])/255,
                                                             alpha: CGFloat(color2[3])/100),
                                              width:  colorImage2.bounds.width,
                                              height: colorImage2.bounds.height)
        
        redSlider.value   = Float(color0[0])
        greenSlider.value = Float(color0[1])
        blueSlider.value  = Float(color0[2])
        alphaSlider.value = Float(color0[3]/100)
        redValueLabel.text   = "\(color0[0])"
        greenValueLabel.text = "\(color0[1])"
        blueValueLabel.text  = "\(color0[2])"
        alphaValueLabel.text = "\(Float(color0[3]/100))"
        
        let rgbaColor = UIColor(red:   CGFloat(color0[0])/255,
                                green: CGFloat(color0[1])/255,
                                blue:  CGFloat(color0[2])/255,
                                alpha: CGFloat(color0[3])/100)
        let hexString = rgbaColor.toHexString()
        self.hexCodeTextField.text = hexString
    }
    
// MARK: - func bind (ReactorKit)
    func bind(reactor: GradientViewReactor) {
        
    }
    
    func changeColor0Value(num: Int, value: Int) {
        self.color0[num] = value
        let rgbaColor = UIColor(red:   CGFloat(color0[0])/255,
                                green: CGFloat(color0[1])/255,
                                blue:  CGFloat(color0[2])/255,
                                alpha: CGFloat(color0[3])/100)
        self.colorImage0.image = UIImage.from(color: rgbaColor,
                                              width:  colorImage0.bounds.width,
                                              height: colorImage0.bounds.height)
        let hexString = rgbaColor.toHexString()
        self.hexCodeTextField.text = hexString
        saveColor()
    }
    
    func changeColor1Value(num: Int, value: Int) {
        self.color1[num] = value
        let rgbaColor = UIColor(red:   CGFloat(color1[0])/255,
                                green: CGFloat(color1[1])/255,
                                blue:  CGFloat(color1[2])/255,
                                alpha: CGFloat(color1[3])/100)
        self.colorImage1.image = UIImage.from(color: rgbaColor,
                                              width:  colorImage1.bounds.width,
                                              height: colorImage1.bounds.height)
        let hexString = rgbaColor.toHexString()
        self.hexCodeTextField.text = hexString
        saveColor()
    }
    
    func changeColor2Value(num: Int, value: Int) {
        self.color2[num] = value
        let rgbaColor = UIColor(red:   CGFloat(color2[0])/255,
                                green: CGFloat(color2[1])/255,
                                blue:  CGFloat(color2[2])/255,
                                alpha: CGFloat(color2[3])/100)
        self.colorImage2.image = UIImage.from(color: rgbaColor,
                                              width:  colorImage2.bounds.width,
                                              height: colorImage2.bounds.height)
        let hexString = rgbaColor.toHexString()
        self.hexCodeTextField.text = hexString
        saveColor()
    }
    
    func saveColor() {
        UserDefaults.standard.set(color0, forKey: UserDefaultKey.color0)
        UserDefaults.standard.set(color1, forKey: UserDefaultKey.color1)
        UserDefaults.standard.set(color2, forKey: UserDefaultKey.color2)
    }

    @IBAction func changeRedValue(_ sender: UISlider) {
        let value = Int(sender.value)
        changeColorValueAndGradient(num: 0, value: value)
        redValueLabel.text = "\(value)"
    }
    
    @IBAction func changeGreenValue(_ sender: UISlider) {
        let value = Int(sender.value)
        changeColorValueAndGradient(num: 1, value: value)
        greenValueLabel.text = "\(value)"
    }
    
    @IBAction func changeBlueValue(_ sender: UISlider) {
        let value = Int(sender.value)
        changeColorValueAndGradient(num: 2, value: value)
        blueValueLabel.text = "\(value)"
    }
    
    @IBAction func changeAlphaValue(_ sender: UISlider) {
        let value = Float(sender.value)
        let intValue = Int(value*100)
        changeColorValueAndGradient(num: 3, value: intValue)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.roundingMode = .floor
        numberFormatter.minimumSignificantDigits = 2
        numberFormatter.maximumSignificantDigits = 2

        let originalNum = value
        let newNum = numberFormatter.string(from: NSNumber(value: originalNum))
        
        alphaValueLabel.text = "\(newNum ?? "")"
    }
    
    func changeColorValueAndGradient(num: Int, value: Int) {
        if(selectedColor == "color0") {
            changeColor0Value(num: num, value: value)
        }
        else if(selectedColor == "color1") {
            changeColor1Value(num: num, value: value)
        }
        else {
            changeColor2Value(num: num, value: value)
        }
        
        gradient.colors = [
            UIColor(red:   CGFloat(color0[0])/255,
                    green: CGFloat(color0[1])/255,
                    blue:  CGFloat(color0[2])/255,
                    alpha: CGFloat(color0[3])/100).cgColor, // Top
            UIColor(red:   CGFloat(color1[0])/255,
                    green: CGFloat(color1[1])/255,
                    blue:  CGFloat(color1[2])/255,
                    alpha: CGFloat(color1[3])/100).cgColor, // Middle
            UIColor(red:   CGFloat(color2[0])/255,
                    green: CGFloat(color2[1])/255,
                    blue:  CGFloat(color2[2])/255,
                    alpha: CGFloat(color2[3])/100).cgColor, // Bottom
        ]
    }
    
    @IBAction func selectColorImage0(_ sender: Any) {
        selectedColor = "color0"
        colorImage0Background.layer.borderColor = UIColor.black.cgColor
        colorImage1Background.layer.borderColor = UIColor.white.cgColor
        colorImage2Background.layer.borderColor = UIColor.white.cgColor
        
        redSlider.value   = Float(color0[0])
        greenSlider.value = Float(color0[1])
        blueSlider.value  = Float(color0[2])
        alphaSlider.value = Float(color0[3]/100)
        redValueLabel.text   = "\(color0[0])"
        greenValueLabel.text = "\(color0[1])"
        blueValueLabel.text  = "\(color0[2])"
        alphaValueLabel.text = "\(color0[3]/100)"
        
        let rgbaColor = UIColor(red:   CGFloat(color0[0])/255,
                                green: CGFloat(color0[1])/255,
                                blue:  CGFloat(color0[2])/255,
                                alpha: CGFloat(color0[3])/100)
        let hexString = rgbaColor.toHexString()
        self.hexCodeTextField.text = hexString
    }
    
    @IBAction func selectColorImage1(_ sender: Any) {
        selectedColor = "color1"
        colorImage1Background.layer.borderColor = UIColor.black.cgColor
        colorImage0Background.layer.borderColor = UIColor.white.cgColor
        colorImage2Background.layer.borderColor = UIColor.white.cgColor
        
        redSlider.value   = Float(color1[0])
        greenSlider.value = Float(color1[1])
        blueSlider.value  = Float(color1[2])
        alphaSlider.value = Float(color1[3]/100)
        redValueLabel.text   = "\(color1[0])"
        greenValueLabel.text = "\(color1[1])"
        blueValueLabel.text  = "\(color1[2])"
        alphaValueLabel.text = "\(color1[3]/100)"
        
        let rgbaColor = UIColor(red:   CGFloat(color1[0])/255,
                                green: CGFloat(color1[1])/255,
                                blue:  CGFloat(color1[2])/255,
                                alpha: CGFloat(color1[3])/100)
        let hexString = rgbaColor.toHexString()
        self.hexCodeTextField.text = hexString
    }
    
    @IBAction func selectColorImage2(_ sender: Any) {
        selectedColor = "color2"
        colorImage2Background.layer.borderColor = UIColor.black.cgColor
        colorImage0Background.layer.borderColor = UIColor.white.cgColor
        colorImage1Background.layer.borderColor = UIColor.white.cgColor
        
        redSlider.value   = Float(color2[0])
        greenSlider.value = Float(color2[1])
        blueSlider.value  = Float(color2[2])
        alphaSlider.value = Float(color2[3]/100)
        redValueLabel.text   = "\(color2[0])"
        greenValueLabel.text = "\(color2[1])"
        blueValueLabel.text  = "\(color2[2])"
        alphaValueLabel.text = "\(color2[3]/100)"
        
        let rgbaColor = UIColor(red:   CGFloat(color2[0])/255,
                                green: CGFloat(color2[1])/255,
                                blue:  CGFloat(color2[2])/255,
                                alpha: CGFloat(color2[3])/100)
        let hexString = rgbaColor.toHexString()
        self.hexCodeTextField.text = hexString
    }
}
