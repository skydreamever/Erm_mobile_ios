//
//  String+StringUtils.swift
//  Erm_mobile_ios
//
//  Created by 孙龙霄 on 7/16/15.
//  Copyright © 2015 孙龙霄. All rights reserved.
//

import UIKit

extension String{
    
    func removeMessChar() ->String{
        
        var result:String
        result = self.stringByReplacingOccurrencesOfString("\\\"", withString: "\"", options: NSStringCompareOptions.LiteralSearch, range: nil)
        result = result.stringByReplacingOccurrencesOfString("\\n", withString: "", options:  NSStringCompareOptions.LiteralSearch, range: nil);
        result = result.stringByReplacingOccurrencesOfString(" ", withString: "", options:  NSStringCompareOptions.LiteralSearch, range: nil);
        result = result.stringByReplacingOccurrencesOfString("\n", withString: "", options:  NSStringCompareOptions.LiteralSearch, range: nil);

        return result
    }
    
    static func encoding(string:String) -> String?{
        
        let zipData = string.dataUsingEncoding(NSUTF8StringEncoding)?.gzippedData()
        let base64 = GTMBase64.stringByEncodingData(zipData)
        
        let customAllowedSet =  NSCharacterSet(charactersInString:"?#[]@!$ &'()*+,;=\"<>%{}|\\^~`").invertedSet
        let result = base64.stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)
        
        return result
        
    }
    
    
    static func decoding(string:String,type:String) -> String?{
        
        if type == "des"{
            return DESUtils.decryptWithText(string)
        }else if type == "des_gzip"{
            let data = GTMBase64.decodeString(string).gunzippedData()
            return String(NSString(data: data!, encoding: NSUTF8StringEncoding))
        }
        return nil
        
    }
    
}
