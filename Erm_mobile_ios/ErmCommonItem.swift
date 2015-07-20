//
//  ErmCommonItem.swift
//  Erm_mobile_ios
//
//  Created by 孙龙霄 on 7/18/15.
//  Copyright © 2015 孙龙霄. All rights reserved.
//

import UIKit


class ErmCommonItem : NSObject {
    
    var icon:String?
    var title:String?
    var subtitle:String?
    var badgeValue:String?
    
    var opertion:(()->Void)?
    
    
    static func itemWithTile(title:String?,icon:String?)->ErmCommonItem{
        
        let item = ErmCommonItem()
        item.title = title
        item.icon = icon
        return item
        
    }
    
    static func itemWhithTitle(title:String?)->ErmCommonItem{
        
        return self.itemWithTile(title, icon: nil)
        
        
    }
    
    
    
    
    
}
