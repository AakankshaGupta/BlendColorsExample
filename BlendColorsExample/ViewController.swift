//
//  ViewController.swift
//  BlendColorsExample
//
//  Created by cbluser113 on 12/01/1938 SAKA.
//  Copyright © 1938 SAKA cbluser113. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var conditionsLabel: UILabel!
    @IBOutlet weak var signUpBtn: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.conditionsLabel.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.size.width - 40
        
        loginBtn.layer.borderWidth = 1.0
        loginBtn.layer.masksToBounds = false
        loginBtn.layer.cornerRadius = 5
        loginBtn.clipsToBounds = true
        loginBtn.layer.borderColor = UIColor(white: 0.8, alpha: 0.1).CGColor
        
//        let img = self.tint(backgroundImage.image!, color: UIColor(white: 1.0, alpha: 0.2))
        let bImage = UIButton.tint(backgroundImage.image!, color: UIColor(white: 1.0, alpha: 0.2))
        loginBtn.setBackgroundImage(bImage, forState: .Normal)
        
        let img1 = self.blendLabelBtn(backgroundImage.image!, color: UIColor(white: 1.0, alpha: 1.0))
        signUpBtn.setTitleColor(UIColor(patternImage: img1), forState: UIControlState.Normal)
        //signUpBtn.setBackgroundImage(img1, forState: UIControlState.Normal)
//        let myImg = self.blendLabel(backgroundImage.image!, color: UIColor.whiteColor())
        let blendedImage = UILabel.blendLabel(conditionsLabel, image: backgroundImage.image!, color: UIColor.whiteColor(), text: "By signing up you agree to the terms & conditions and privacy policy")
        conditionsLabel.textColor = UIColor(patternImage: blendedImage)
     }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func blendLabelBtn(image : UIImage, color : UIColor) -> UIImage
    {
      //  let backgroundSize : CGSize = image.size
        
        // 1
        UIGraphicsBeginImageContextWithOptions(image.size, false , UIScreen.mainScreen().scale)

        let currentContext = UIGraphicsGetCurrentContext()
        
        // 2
        CGContextSaveGState(currentContext);
        
        // 3
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // 4
        // let startColor = UIColor(red: 74/255, green: 119/255, blue: 200/255, alpha: 0.1)
        let startColor =  UIColor(red: 81/255, green: 119/255, blue: 210/255, alpha: 0.5)
        let startColorComponents = CGColorGetComponents(startColor.CGColor)
        let endColor = UIColor(red: 143/255, green: 228/255, blue: 245/255, alpha: 1)
       // let endColor = UIColor(white: 1.0, alpha: 1.0)1
        let endColorComponents = CGColorGetComponents(endColor.CGColor)
        
        // 5
        var colorComponents
        = [startColorComponents[0], startColorComponents[1], startColorComponents[2], startColorComponents[3], endColorComponents[0], endColorComponents[1], endColorComponents[2], endColorComponents[3]]
        
        // 6
        var locations:[CGFloat] = [0.0, 1.0]
        
        // 7
        let gradient = CGGradientCreateWithColorComponents(colorSpace,&colorComponents,&locations,2)
        
        let startPoint = CGPointMake(0, self.signUpBtn.bounds.height)
        let endPoint = CGPointMake(self.signUpBtn.bounds.width, self.signUpBtn.bounds.height)
        
        // 8
        CGContextDrawLinearGradient(currentContext,gradient,startPoint,endPoint, .DrawsBeforeStartLocation)
        
        // 9
        CGContextRestoreGState(currentContext)
        
        let coloredImg: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return coloredImg


    }
    
    func blendLabel(image : UIImage, color : UIColor) -> UIImage
    {
       // let backgroundSize : CGSize = image.size
        let textColor: UIColor = UIColor(red:80/255, green: 122/255, blue: 205/255, alpha: 1.0)
        let textFont: UIFont = UIFont.boldSystemFontOfSize(10)
        
        let string = "By signing up you agree to the terms & conditions and privacy policy"
        
        let textFontAttributes =
        [
            NSFontAttributeName: textFont,
            NSForegroundColorAttributeName: textColor,
        ]
        UIGraphicsBeginImageContextWithOptions(conditionsLabel.frame.size, false , UIScreen.mainScreen().scale)
        let context : CGContext = UIGraphicsGetCurrentContext()!
       
        CGContextSaveGState(context)
        
        CGContextSetBlendMode(context, CGBlendMode.Multiply)
        CGContextTranslateCTM(context, 0 , conditionsLabel.frame.size.height)
        CGContextScaleCTM(context, 1, -1)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // 4
        // let startColor = UIColor(red: 74/255, green: 119/255, blue: 200/255, alpha: 0.1)
        let startColor =  UIColor(red: 80/255, green: 122/255, blue: 205/255, alpha: 0.3)
        let startColorComponents = CGColorGetComponents(startColor.CGColor)
        let endColor = UIColor(red: 80/255, green: 122/255, blue: 205/255, alpha: 0.5)
        // let endColor = UIColor(white: 1.0, alpha: 1.0)1
        let endColorComponents = CGColorGetComponents(endColor.CGColor)
        
        // 5
        var colorComponents
        = [startColorComponents[0], startColorComponents[1], startColorComponents[2], startColorComponents[3], endColorComponents[0], endColorComponents[1], endColorComponents[2], endColorComponents[3]]
        
        // 6
        var locations:[CGFloat] = [0.0, 1.0]
        
        // 7
        let gradient = CGGradientCreateWithColorComponents(colorSpace,&colorComponents,&locations,2)
        
        let startPoint = CGPointMake(0, self.conditionsLabel.bounds.height)
        let endPoint = CGPointMake(self.conditionsLabel.bounds.width, self.conditionsLabel.bounds.height)
        
        // 8
        CGContextDrawLinearGradient(context,gradient,startPoint,endPoint, .DrawsBeforeStartLocation)
        
        // 9
        CGContextRestoreGState(context)

        let rect : CGRect = CGRectMake(0,0, image.size.width, image.size.height)
        string.drawInRect(rect, withAttributes: textFontAttributes)
        CGContextClipToMask(context, rect, image.CGImage)
       
        var r = CGFloat()
        var g = CGFloat()
        var b = CGFloat()
        var a = CGFloat()
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        CGContextSetRGBFillColor(context, r, g, b, a)
        CGContextFillRect(context, rect)
        
        let coloredImg: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return coloredImg
    }
    
    func tint(image: UIImage, color: UIColor) -> UIImage
    {
        let ciImage = CIImage(image: image)
        
        guard let filter = CIFilter(name: "CIMultiplyCompositing"),colorFilter = CIFilter(name: "CIConstantColorGenerator")
        else {return UIImage()}
        
        let ciColor = CIColor(color: color)
        colorFilter.setValue(ciColor, forKey: kCIInputColorKey)
        let colorImage = colorFilter.outputImage
        filter.setValue(colorImage, forKey: kCIInputImageKey)
        filter.setValue(ciImage, forKey: kCIInputBackgroundImageKey)
        
        return UIImage(CIImage: filter.outputImage!)
    }
    
    func signUpGradient()
    {
        
    }
    
}







