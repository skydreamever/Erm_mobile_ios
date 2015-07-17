//
//  NetWorkUtils.swift
//  Erm_mobile_ios
//
//  Created by 孙龙霄 on 7/17/15.
//  Copyright © 2015 孙龙霄. All rights reserved.
//

import UIKit
import Alamofire

class NetworkUtils {
    
    static func request(url:String,method:String,data:String,success:(AnyObject!) ->Void,errors:()->Void){
        
        Alamofire.request(.POST, URLString: url, parameters: [:], encoding: .Custom({
            (convertible, params) in
            let mutableRequest = convertible.URLRequest.copy() as! NSMutableURLRequest
            mutableRequest.HTTPBody = data.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            return (mutableRequest, nil)
        })).responseJSON { (_, _, JSON, ERROR) -> Void in
            
            if ERROR != nil{
                NSLog("网络请求错误-------------------------------")
                print(ERROR)
                
            }else{
                success(JSON)
            }

        }
        
        
    }

    
    
}