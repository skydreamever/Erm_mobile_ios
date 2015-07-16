//
//  DeviceUtils.swift
//  Erm_mobile_ios
//
//  Created by 孙龙霄 on 7/16/15.
//  Copyright © 2015 孙龙霄. All rights reserved.
//

import UIKit


class DeviceUtils {
    
    class func UUID() -> String?{
        return UIDevice.currentDevice().identifierForVendor?.UUIDString
    }
    
    class func MODULE() -> String{
        return UIDevice.currentDevice().model
    }
    
    class func NAME() ->String{
        return UIDevice.currentDevice().name
    }
}
