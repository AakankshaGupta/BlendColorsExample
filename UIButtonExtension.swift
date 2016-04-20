//
//  UIButtonExtension.swift
//  BlendColorsExample
//
//  Created by cbluser113 on 20/01/1938 SAKA.
//  Copyright © 1938 SAKA cbluser113. All rights reserved.
//

import UIKit


extension UIButton {
    
    static func tint(image: UIImage, color: UIColor) -> UIImage{
        
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

}