//
//  LabelExtension.swift
//  BlendColorsExample
//
//  Created by cbluser113 on 20/01/1938 SAKA.
//  Copyright © 1938 SAKA cbluser113. All rights reserved.
//

import UIKit


extension UILabel {
    
   static func blendLabel(label : UILabel,image : UIImage, color : UIColor,text : String) -> UIImage
    {
        // let backgroundSize : CGSize = image.size
        let textColor: UIColor = UIColor(red:80/255, green: 122/255, blue: 205/255, alpha: 1.0)
        let textFont: UIFont = UIFont.boldSystemFontOfSize(10)
        
        let textFontAttributes =
        [
            NSFontAttributeName: textFont,
            NSForegroundColorAttributeName: textColor,
        ]
        UIGraphicsBeginImageContextWithOptions(label.frame.size, false , UIScreen.mainScreen().scale)
        let context : CGContext = UIGraphicsGetCurrentContext()!
        
        CGContextSaveGState(context)
        
        CGContextSetBlendMode(context, CGBlendMode.Multiply)
        CGContextTranslateCTM(context, 0 , label.frame.size.height)
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
        
        let startPoint = CGPointMake(0, label.bounds.height)
        let endPoint = CGPointMake(label.bounds.width, label.bounds.height)
        
        // 8
        CGContextDrawLinearGradient(context,gradient,startPoint,endPoint, .DrawsBeforeStartLocation)
        
        // 9
        CGContextRestoreGState(context)
        
        let rect : CGRect = CGRectMake(0,0, image.size.width, image.size.height)
        text.drawInRect(rect, withAttributes: textFontAttributes)
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

}