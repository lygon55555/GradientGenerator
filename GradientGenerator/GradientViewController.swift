//
//  GradientViewController.swift
//  GradientGenerator
//
//  Created by Yonghyun on 2020/05/05.
//  Copyright © 2020 Yonghyun. All rights reserved.
//

import UIKit

class GradientViewController: UIViewController {
    
    @IBOutlet var gradientView: UIImageView!
    @IBOutlet var colorImage1:  UIImageView!
    @IBOutlet var colorImage2:  UIImageView!
    @IBOutlet var colorImage3:  UIImageView!
    
    @IBOutlet var colorImage1Background: UIView!
    @IBOutlet var colorImage2Background: UIView!
    @IBOutlet var colorImage3Background: UIView!
    
    @IBOutlet var redSlider:   UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider:  UISlider!
    @IBOutlet var alphaSlider: UISlider!
    
    @IBOutlet var redValueLabel:   UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel:  UILabel!
    @IBOutlet var alphaValueLabel: UILabel!
    
    @IBOutlet var hexCodeTextField: UITextField!
    
    var color1 = [Int]()
    var color2 = [Int]()
    var color3 = [Int]()
    
    var selectedColor: String!
    
    var gradient: CAGradientLayer!
    
    override func viewDidLoad() {
        
        colorImage1Background.layer.borderWidth = 2
        colorImage1Background.layer.cornerRadius = 10
        colorImage2Background.layer.borderWidth = 2
        colorImage2Background.layer.cornerRadius = 10
        colorImage3Background.layer.borderWidth = 2
        colorImage3Background.layer.cornerRadius = 10
        
        colorImage1Background.layer.borderColor = UIColor.black.cgColor
        colorImage2Background.layer.borderColor = UIColor.white.cgColor
        colorImage3Background.layer.borderColor = UIColor.white.cgColor
        
        
        
//        color1 = UserDefaults.standard.array(forKey: UserDefaultKey.color1) as! [Int]
//        color2 = UserDefaults.standard.array(forKey: UserDefaultKey.color2) as! [Int]
//        color3 = UserDefaults.standard.array(forKey: UserDefaultKey.color3) as! [Int]
//
//        if color1.isEmpty && color2.isEmpty && color3.isEmpty {
//            color1.append(contentsOf: [34, 193, 195, 100])
//            color2.append(contentsOf: [150, 190, 116, 100])
//            color3.append(contentsOf: [255, 199, 80, 100])
//        }
//        else {
//
//        }

        selectedColor = "color1"
        
        color1.append(contentsOf: [34, 193, 195, 100])
        color2.append(contentsOf: [150, 190, 116, 100])
        color3.append(contentsOf: [255, 199, 80, 100])
        
        self.gradient = CAGradientLayer()
        gradient.frame = self.gradientView.bounds
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        
        gradient.colors = [
            UIColor(red: CGFloat(color1[0])/255, green: CGFloat(color1[1])/255, blue: CGFloat(color1[2])/255, alpha: CGFloat(color1[3])/100).cgColor, // Top
            UIColor(red: CGFloat(color2[0])/255, green: CGFloat(color2[1])/255, blue: CGFloat(color2[2])/255, alpha: CGFloat(color2[3])/100).cgColor, // Middle
            UIColor(red: CGFloat(color3[0])/255, green: CGFloat(color3[1])/255, blue: CGFloat(color3[2])/255, alpha: CGFloat(color3[3])/100).cgColor, // Bottom
        ]
        
        gradient.locations = [0, 0.5, 1]
        
        gradientView.layer.addSublayer(gradient)
        
        self.colorImage1.image = UIImage.from(color: UIColor(red: CGFloat(color1[0])/255, green: CGFloat(color1[1])/255, blue: CGFloat(color1[2])/255, alpha: CGFloat(color1[3])/100), width: colorImage1.bounds.width, height: colorImage1.bounds.height)
        self.colorImage2.image = UIImage.from(color: UIColor(red: CGFloat(color2[0])/255, green: CGFloat(color2[1])/255, blue: CGFloat(color2[2])/255, alpha: CGFloat(color2[3])/100), width: colorImage2.bounds.width, height: colorImage2.bounds.height)
        self.colorImage3.image = UIImage.from(color: UIColor(red: CGFloat(color3[0])/255, green: CGFloat(color3[1])/255, blue: CGFloat(color3[2])/255, alpha: CGFloat(color3[3])/100), width: colorImage3.bounds.width, height: colorImage3.bounds.height)
        
        redSlider.value = Float(color1[0])
        redValueLabel.text = "\(color1[0])"
        
        greenSlider.value = Float(color1[1])
        greenValueLabel.text = "\(color1[1])"
        
        blueSlider.value = Float(color1[2])
        blueValueLabel.text = "\(color1[2])"
        
        alphaSlider.value = Float(color1[3]/100)
        alphaValueLabel.text = "\(Float(color1[3]/100))"
        
        let rgbaColor = UIColor(red: CGFloat(color1[0])/255, green: CGFloat(color1[1])/255, blue: CGFloat(color1[2])/255, alpha: CGFloat(color1[3])/100)
        let hexString = rgbaColor.toHexString()
        self.hexCodeTextField.text = hexString
    }

    @IBAction func changeRedValue(_ sender: UISlider) {
        let value = Int(sender.value)
        
        if(selectedColor == "color1") {
            self.color1[0] = value
            self.colorImage1.image = UIImage.from(color: UIColor(red: CGFloat(color1[0])/255, green: CGFloat(color1[1])/255, blue: CGFloat(color1[2])/255, alpha: CGFloat(color1[3])/100), width: colorImage1.bounds.width, height: colorImage1.bounds.height)
            
            let rgbaColor = UIColor(red: CGFloat(color1[0])/255, green: CGFloat(color1[1])/255, blue: CGFloat(color1[2])/255, alpha: CGFloat(color1[3])/100)
            let hexString = rgbaColor.toHexString()
            self.hexCodeTextField.text = hexString
        }
        else if(selectedColor == "color2") {
            self.color2[0] = value
            self.colorImage2.image = UIImage.from(color: UIColor(red: CGFloat(color2[0])/255, green: CGFloat(color2[1])/255, blue: CGFloat(color2[2])/255, alpha: CGFloat(color2[3])/100), width: colorImage2.bounds.width, height: colorImage2.bounds.height)
            
            let rgbaColor = UIColor(red: CGFloat(color2[0])/255, green: CGFloat(color2[1])/255, blue: CGFloat(color2[2])/255, alpha: CGFloat(color2[3])/100)
            let hexString = rgbaColor.toHexString()
            self.hexCodeTextField.text = hexString
        }
        else {
            self.color3[0] = value
            self.colorImage3.image = UIImage.from(color: UIColor(red: CGFloat(color3[0])/255, green: CGFloat(color3[1])/255, blue: CGFloat(color3[2])/255, alpha: CGFloat(color3[3])/100), width: colorImage3.bounds.width, height: colorImage3.bounds.height)
            
            let rgbaColor = UIColor(red: CGFloat(color3[0])/255, green: CGFloat(color3[1])/255, blue: CGFloat(color3[2])/255, alpha: CGFloat(color3[3])/100)
            let hexString = rgbaColor.toHexString()
            self.hexCodeTextField.text = hexString
        }
        
        gradient.colors = [
            UIColor(red: CGFloat(color1[0])/255, green: CGFloat(color1[1])/255, blue: CGFloat(color1[2])/255, alpha: CGFloat(color1[3])/100).cgColor, // Top
            UIColor(red: CGFloat(color2[0])/255, green: CGFloat(color2[1])/255, blue: CGFloat(color2[2])/255, alpha: CGFloat(color2[3])/100).cgColor, // Middle
            UIColor(red: CGFloat(color3[0])/255, green: CGFloat(color3[1])/255, blue: CGFloat(color3[2])/255, alpha: CGFloat(color3[3])/100).cgColor, // Bottom
        ]
        
        redValueLabel.text = "\(value)"
    }
    @IBAction func changeGreenValue(_ sender: UISlider) {
        let value = Int(sender.value)
        
        if(selectedColor == "color1") {
            self.color1[1] = value
            self.colorImage1.image = UIImage.from(color: UIColor(red: CGFloat(color1[0])/255, green: CGFloat(color1[1])/255, blue: CGFloat(color1[2])/255, alpha: CGFloat(color1[3])/100), width: colorImage1.bounds.width, height: colorImage1.bounds.height)
            
            let rgbaColor = UIColor(red: CGFloat(color1[0])/255, green: CGFloat(color1[1])/255, blue: CGFloat(color1[2])/255, alpha: CGFloat(color1[3])/100)
            let hexString = rgbaColor.toHexString()
            self.hexCodeTextField.text = hexString
        }
        else if(selectedColor == "color2") {
            self.color2[1] = value
            self.colorImage2.image = UIImage.from(color: UIColor(red: CGFloat(color2[0])/255, green: CGFloat(color2[1])/255, blue: CGFloat(color2[2])/255, alpha: CGFloat(color2[3])/100), width: colorImage2.bounds.width, height: colorImage2.bounds.height)
            
            let rgbaColor = UIColor(red: CGFloat(color2[0])/255, green: CGFloat(color2[1])/255, blue: CGFloat(color2[2])/255, alpha: CGFloat(color2[3])/100)
            let hexString = rgbaColor.toHexString()
            self.hexCodeTextField.text = hexString
        }
        else {
            self.color3[1] = value
            self.colorImage3.image = UIImage.from(color: UIColor(red: CGFloat(color3[0])/255, green: CGFloat(color3[1])/255, blue: CGFloat(color3[2])/255, alpha: CGFloat(color3[3])/100), width: colorImage3.bounds.width, height: colorImage3.bounds.height)
            
            let rgbaColor = UIColor(red: CGFloat(color3[0])/255, green: CGFloat(color3[1])/255, blue: CGFloat(color3[2])/255, alpha: CGFloat(color3[3])/100)
            let hexString = rgbaColor.toHexString()
            self.hexCodeTextField.text = hexString
        }
        
        gradient.colors = [
            UIColor(red: CGFloat(color1[0])/255, green: CGFloat(color1[1])/255, blue: CGFloat(color1[2])/255, alpha: CGFloat(color1[3])/100).cgColor, // Top
            UIColor(red: CGFloat(color2[0])/255, green: CGFloat(color2[1])/255, blue: CGFloat(color2[2])/255, alpha: CGFloat(color2[3])/100).cgColor, // Middle
            UIColor(red: CGFloat(color3[0])/255, green: CGFloat(color3[1])/255, blue: CGFloat(color3[2])/255, alpha: CGFloat(color3[3])/100).cgColor, // Bottom
        ]
        
        greenValueLabel.text = "\(value)"
    }
    @IBAction func changeBlueValue(_ sender: UISlider) {
        let value = Int(sender.value)
        
        if(selectedColor == "color1") {
            self.color1[2] = value
            self.colorImage1.image = UIImage.from(color: UIColor(red: CGFloat(color1[0])/255, green: CGFloat(color1[1])/255, blue: CGFloat(color1[2])/255, alpha: CGFloat(color1[3])/100), width: colorImage1.bounds.width, height: colorImage1.bounds.height)
            
            let rgbaColor = UIColor(red: CGFloat(color1[0])/255, green: CGFloat(color1[1])/255, blue: CGFloat(color1[2])/255, alpha: CGFloat(color1[3])/100)
            let hexString = rgbaColor.toHexString()
            self.hexCodeTextField.text = hexString
        }
        else if(selectedColor == "color2") {
            self.color2[2] = value
            self.colorImage2.image = UIImage.from(color: UIColor(red: CGFloat(color2[0])/255, green: CGFloat(color2[1])/255, blue: CGFloat(color2[2])/255, alpha: CGFloat(color2[3])/100), width: colorImage2.bounds.width, height: colorImage2.bounds.height)
            
            let rgbaColor = UIColor(red: CGFloat(color2[0])/255, green: CGFloat(color2[1])/255, blue: CGFloat(color2[2])/255, alpha: CGFloat(color2[3])/100)
            let hexString = rgbaColor.toHexString()
            self.hexCodeTextField.text = hexString
        }
        else {
            self.color3[2] = value
            self.colorImage3.image = UIImage.from(color: UIColor(red: CGFloat(color3[0])/255, green: CGFloat(color3[1])/255, blue: CGFloat(color3[2])/255, alpha: CGFloat(color3[3])/100), width: colorImage3.bounds.width, height: colorImage3.bounds.height)
            
            let rgbaColor = UIColor(red: CGFloat(color3[0])/255, green: CGFloat(color3[1])/255, blue: CGFloat(color3[2])/255, alpha: CGFloat(color3[3])/100)
            let hexString = rgbaColor.toHexString()
            self.hexCodeTextField.text = hexString
        }
        
        gradient.colors = [
            UIColor(red: CGFloat(color1[0])/255, green: CGFloat(color1[1])/255, blue: CGFloat(color1[2])/255, alpha: CGFloat(color1[3])/100).cgColor, // Top
            UIColor(red: CGFloat(color2[0])/255, green: CGFloat(color2[1])/255, blue: CGFloat(color2[2])/255, alpha: CGFloat(color2[3])/100).cgColor, // Middle
            UIColor(red: CGFloat(color3[0])/255, green: CGFloat(color3[1])/255, blue: CGFloat(color3[2])/255, alpha: CGFloat(color3[3])/100).cgColor, // Bottom
        ]
        
        blueValueLabel.text = "\(value)"
    }
    @IBAction func changeAlphaValue(_ sender: UISlider) {
        let value = Float(sender.value)
        let intValue = Int(value*100)
        
        if(selectedColor == "color1") {
            self.color1[3] = intValue
            self.colorImage1.image = UIImage.from(color: UIColor(red: CGFloat(color1[0])/255, green: CGFloat(color1[1])/255, blue: CGFloat(color1[2])/255, alpha: CGFloat(color1[3])/100), width: colorImage1.bounds.width, height: colorImage1.bounds.height)
            
            let rgbaColor = UIColor(red: CGFloat(color1[0])/255, green: CGFloat(color1[1])/255, blue: CGFloat(color1[2])/255, alpha: CGFloat(color1[3])/100)
            let hexString = rgbaColor.toHexString()
            self.hexCodeTextField.text = hexString
        }
        else if(selectedColor == "color2") {
            self.color2[3] = intValue
            self.colorImage2.image = UIImage.from(color: UIColor(red: CGFloat(color2[0])/255, green: CGFloat(color2[1])/255, blue: CGFloat(color2[2])/255, alpha: CGFloat(color2[3])/100), width: colorImage2.bounds.width, height: colorImage2.bounds.height)
            
            let rgbaColor = UIColor(red: CGFloat(color2[0])/255, green: CGFloat(color2[1])/255, blue: CGFloat(color2[2])/255, alpha: CGFloat(color2[3])/100)
            let hexString = rgbaColor.toHexString()
            self.hexCodeTextField.text = hexString
        }
        else {
            self.color3[3] = intValue
            self.colorImage3.image = UIImage.from(color: UIColor(red: CGFloat(color3[0])/255, green: CGFloat(color3[1])/255, blue: CGFloat(color3[2])/255, alpha: CGFloat(color3[3])/100), width: colorImage3.bounds.width, height: colorImage3.bounds.height)
            
            let rgbaColor = UIColor(red: CGFloat(color3[0])/255, green: CGFloat(color3[1])/255, blue: CGFloat(color3[2])/255, alpha: CGFloat(color3[3])/100)
            let hexString = rgbaColor.toHexString()
            self.hexCodeTextField.text = hexString
        }
        
        gradient.colors = [
            UIColor(red: CGFloat(color1[0])/255, green: CGFloat(color1[1])/255, blue: CGFloat(color1[2])/255, alpha: CGFloat(color1[3])/100).cgColor, // Top
            UIColor(red: CGFloat(color2[0])/255, green: CGFloat(color2[1])/255, blue: CGFloat(color2[2])/255, alpha: CGFloat(color2[3])/100).cgColor, // Middle
            UIColor(red: CGFloat(color3[0])/255, green: CGFloat(color3[1])/255, blue: CGFloat(color3[2])/255, alpha: CGFloat(color3[3])/100).cgColor, // Bottom
        ]
        
        let numberFormatter = NumberFormatter()
        numberFormatter.roundingMode = .floor
        numberFormatter.minimumSignificantDigits = 2
        numberFormatter.maximumSignificantDigits = 2

        let originalNum = value
        let newNum = numberFormatter.string(from: NSNumber(value: originalNum))
        
        alphaValueLabel.text = "\(newNum ?? "")"
    }
    
    @IBAction func selectColorImage1(_ sender: Any) {
        selectedColor = "color1"
        colorImage1Background.layer.borderColor = UIColor.black.cgColor
        colorImage2Background.layer.borderColor = UIColor.white.cgColor
        colorImage3Background.layer.borderColor = UIColor.white.cgColor
        
        redSlider.value = Float(color1[0])
        redValueLabel.text = "\(color1[0])"
        
        greenSlider.value = Float(color1[1])
        greenValueLabel.text = "\(color1[1])"
        
        blueSlider.value = Float(color1[2])
        blueValueLabel.text = "\(color1[2])"
        
        alphaSlider.value = Float(color1[3]/100)
        alphaValueLabel.text = "\(color1[3]/100)"
        
        let rgbaColor = UIColor(red: CGFloat(color1[0])/255, green: CGFloat(color1[1])/255, blue: CGFloat(color1[2])/255, alpha: CGFloat(color1[3])/100)
        let hexString = rgbaColor.toHexString()
        self.hexCodeTextField.text = hexString
    }
    @IBAction func selectColorImage2(_ sender: Any) {
        selectedColor = "color2"
        colorImage2Background.layer.borderColor = UIColor.black.cgColor
        colorImage1Background.layer.borderColor = UIColor.white.cgColor
        colorImage3Background.layer.borderColor = UIColor.white.cgColor
        
        redSlider.value = Float(color2[0])
        redValueLabel.text = "\(color2[0])"
        
        greenSlider.value = Float(color2[1])
        greenValueLabel.text = "\(color2[1])"
        
        blueSlider.value = Float(color2[2])
        blueValueLabel.text = "\(color2[2])"
        
        alphaSlider.value = Float(color2[3]/100)
        alphaValueLabel.text = "\(color2[3]/100)"
        
        let rgbaColor = UIColor(red: CGFloat(color2[0])/255, green: CGFloat(color2[1])/255, blue: CGFloat(color2[2])/255, alpha: CGFloat(color2[3])/100)
        let hexString = rgbaColor.toHexString()
        self.hexCodeTextField.text = hexString
    }
    @IBAction func selectColorImage3(_ sender: Any) {
        selectedColor = "color3"
        colorImage3Background.layer.borderColor = UIColor.black.cgColor
        colorImage1Background.layer.borderColor = UIColor.white.cgColor
        colorImage2Background.layer.borderColor = UIColor.white.cgColor
        
        redSlider.value = Float(color3[0])
        redValueLabel.text = "\(color3[0])"
        
        greenSlider.value = Float(color3[1])
        greenValueLabel.text = "\(color3[1])"
        
        blueSlider.value = Float(color3[2])
        blueValueLabel.text = "\(color3[2])"
        
        alphaSlider.value = Float(color3[3]/100)
        alphaValueLabel.text = "\(color3[3]/100)"
        
        let rgbaColor = UIColor(red: CGFloat(color3[0])/255, green: CGFloat(color3[1])/255, blue: CGFloat(color3[2])/255, alpha: CGFloat(color3[3])/100)
        let hexString = rgbaColor.toHexString()
        self.hexCodeTextField.text = hexString
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }
}

extension UIImage {
    static func from(color: UIColor, width: CGFloat, height: CGFloat) -> UIImage {
        
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        return nil
    }
}

extension UIColor {
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0

        getRed(&r, green: &g, blue: &b, alpha: &a)

        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0

        return NSString(format:"#%06x", rgb) as String
    }

    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
}
