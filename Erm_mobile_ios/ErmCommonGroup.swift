//
//  ErmCommonGroup.swift
//  Erm_mobile_ios
//
//  Created by 孙龙霄 on 7/18/15.
//  Copyright © 2015 孙龙霄. All rights reserved.
//

import UIKit

class ErmCommonGroup: NSObject {
    
    var header:String?
    var footer:String?
    var items:[ErmCommonItem]?
    
    static func group()->ErmCommonGroup{
        
        return ErmCommonGroup()
    
    }
    
    
}
