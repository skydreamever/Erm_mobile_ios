//
//  UIImage+UImageUtils.swift
//  Erm_mobile_ios
//
//  Created by 孙龙霄 on 7/18/15.
//  Copyright © 2015 孙龙霄. All rights reserved.
//

import UIKit

extension UIImage{

    
    func scaleImage(scaleSize:float_t) -> UIImage{
        
        
        let newSize = CGSizeMake(self.size.width * CGFloat(scaleSize), self.size.height * CGFloat(scaleSize))
        
        UIGraphicsBeginImageContext(newSize)
        self.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        let scaleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaleImage        
    }
    
    
}
