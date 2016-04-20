//
//  GradientView.swift
//  BlendColorsExample
//
//  Created by cbluser113 on 19/01/1938 SAKA.
//  Copyright © 1938 SAKA cbluser113. All rights reserved.
//

import UIKit

class GradientView: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override func drawRect(rect: CGRect) {
        // 1
        let currentContext = UIGraphicsGetCurrentContext()
        
        // 2
        CGContextSaveGState(currentContext);
        
        // 3
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // 4
       // let startColor = UIColor(red: 74/255, green: 119/255, blue: 200/255, alpha: 0.1)
        let startColor =  UIColor(red: 71/255, green: 115/255, blue: 194/255, alpha: 0.25)
        let startColorComponents = CGColorGetComponents(startColor.CGColor)
        let endColor = UIColor(red: 71/255, green: 115/255, blue: 194/255, alpha: 0.5)
        let endColorComponents = CGColorGetComponents(endColor.CGColor)
        
        // 5
        var colorComponents
        = [startColorComponents[0], startColorComponents[1], startColorComponents[2], startColorComponents[3], endColorComponents[0], endColorComponents[1], endColorComponents[2], endColorComponents[3]]
        
        // 6
        var locations:[CGFloat] = [0.0, 1.0]
        
        // 7
        let gradient = CGGradientCreateWithColorComponents(colorSpace,&colorComponents,&locations,2)
        
        let startPoint = CGPointMake(0, self.bounds.height)
        let endPoint = CGPointMake(self.bounds.width, self.bounds.height)
        
        // 8
        CGContextDrawLinearGradient(currentContext,gradient,startPoint,endPoint, .DrawsBeforeStartLocation)
        
        // 9
        CGContextRestoreGState(currentContext);
    }
}
