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
    
    
    class func resizeImage(name:NSString) ->UIImage {
        let image = UIImage(named: name as String)
        
        
        return image!.stretchableImageWithLeftCapWidth(Int(Float(image!.size.width*0.5)) , topCapHeight:Int(Float(image!.size.height*0.5)))
    }
    
    
    class func resizeparticularImage(name:NSString) ->UIImage {
        let image = UIImage(named: name as String)
        
        
        return image!.stretchableImageWithLeftCapWidth(Int(Float(image!.size.width*0.5)) , topCapHeight:Int(Float(image!.size.height*0.7)))
    }
    
    class func createImageWithColor(color:UIColor) -> UIImage{
        let rect = CGRectMake(0, 0, 5, 5)
        
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}
