//
//  ErmBadgeView.swift
//  Erm_mobile_ios
//
//  Created by 孙龙霄 on 7/18/15.
//  Copyright © 2015 孙龙霄. All rights reserved.
//

import UIKit

class ErmBadgeView: UIButton {
    
    var badgeValue:String!{
        didSet{
                        self.setTitle(badgeValue, forState: UIControlState.Normal)
            var attr = [String:AnyObject]()
            attr[NSFontAttributeName] = self.titleLabel?.font

            
            
            let titleSize = (badgeValue as NSString).sizeWithAttributes(attr as [String : AnyObject])
            
            let bgw = self.currentBackgroundImage!.size.width
            if titleSize.width < bgw {
                self.width = bgw
            }else{
                self.width = titleSize.width + 10
            }
            
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel?.font = UIFont.systemFontOfSize(11)
        
        self.setBackgroundImage(UIImage.resizeImage("main_badge"), forState: UIControlState.Normal)
        self.height = self.currentBackgroundImage!.size.height
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
