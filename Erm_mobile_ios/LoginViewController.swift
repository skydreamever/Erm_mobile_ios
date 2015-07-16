//
//  ViewController.swift
//  Erm_mobile_ios
//
//  Created by 孙龙霄 on 7/15/15.
//  Copyright © 2015 孙龙霄. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController,NSURLConnectionDataDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let UUID = DeviceUtils.UUID()
        let NAME = DeviceUtils.NAME()
        let MODULE = DeviceUtils.MODULE()
        
        //---------------------------------appJson------------------------------//
        var appJson = Dictionary<String,String>()
        appJson["appid"] = "A0D001.nc.yonyou.com"
        appJson["controllerid"] = "com.nc.araperm_loginController";
        appJson["devid"] = UUID
        appJson["forcelogin"] = ""
        appJson["funcid"] = ""
        appJson["funcode"] = "A0D001.nc.yonyou.com"
        appJson["massotoken"] = ""
        appJson["sessionid"] = ""
        appJson["tabid"] = ""
        appJson["token"] = ""
        
        //##################输入选项###################//
        appJson["userid"] = "";
        appJson["user"] = "1101"
        appJson["groupid"] = ""
        appJson["pass"] = "123456a"
        //############################################//
        
        //--------------------------------------------------------------------//
        
        
        
        
        //
        //-----------------------deviceinfoJson-------------------------------//

        var deviceinfoJson = Dictionary<String,String>()
        deviceinfoJson["bluetooth"] = ""
        deviceinfoJson["firmware"] = ""
        deviceinfoJson["ram"] = ""
        deviceinfoJson["rom"] = ""
        deviceinfoJson["imei"] = ""
        deviceinfoJson["imsi"] = ""
        deviceinfoJson["mac"] = UUID
        deviceinfoJson["uuid"] = UUID
        deviceinfoJson["wfaddress"] = UUID
        deviceinfoJson["name"] = NAME
        deviceinfoJson["categroy"] = MODULE
        deviceinfoJson["model"] = MODULE
        deviceinfoJson["style"] = "ios"
        deviceinfoJson["resolution"] = ""
        deviceinfoJson["screensize"] = ""
        deviceinfoJson["lang"] = (NSUserDefaults.standardUserDefaults().objectForKey("AppleLanguages") as! NSArray)[0] as? String
        deviceinfoJson["pushtoken"] = ""
        
        //---------------------------------------------------------------------//
        
        
        
        
        //---------------------------------appJson------------------------------//
        var postJson = Dictionary<String,AnyObject>()
        postJson["actionid"] = ""
        postJson["actionname"] = "login"
        postJson["callback"] = ""
        postJson["contextmapping"] = "none"
        postJson["controllerid"] = "com.nc.arap.erm_loginController"
        postJson["viewid"] = ""
        postJson["windowid"] = "erm_loginController"
        
        var params = Dictionary<String,String>()
        params["contextmapping"] = "none"
        params["error"] = "this.showerror()"
        //##################输入选项###################//
        params["pass"] = "123456a"
        //############################################//
        params["success"] = "openMainview"
        params["type"] = "nc"
        postJson["params"] = params
            
        //---------------------------------------------------------------------//

        var rootjson = Dictionary<String,AnyObject>()
        rootjson["serviceid"] = "ncLoginService"

        
        var rootjsonStr:String?
        
        do{

            rootjson["appcontext"] = appJson
            rootjson["deviceinfo"] = deviceinfoJson
            rootjson["servicecontext"] = postJson
            
            let rootjsonData = try NSJSONSerialization.dataWithJSONObject(rootjson, options: NSJSONWritingOptions.PrettyPrinted)
            rootjsonStr = String(NSString(data: rootjsonData, encoding: NSUTF8StringEncoding)!).removeMessChar()
        }catch{
            NSLog("---------->json转字符串错误");
        }
        
        if rootjsonStr != nil {
            
            
            let result = String.encoding(rootjsonStr!);
            
            if result != nil {
                
                //##################输入选项###################//
                request("http://10.10.3.107:9999/umserver/core/", Method: "post", data: "tp=des_gzip&data="+result!)
                //############################################//

            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func request(url:String,Method:String,data:String){
        
        Alamofire.request(.POST, URLString: url, parameters: [:], encoding: .Custom({
            (convertible, params) in
            let mutableRequest = convertible.URLRequest.copy() as! NSMutableURLRequest
            mutableRequest.HTTPBody = data.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            return (mutableRequest, nil)
        })).responseJSON { (_, _, JSON, _) -> Void in
            
            let dic:Dictionary = JSON as! [String:String]

            let data:String? = dic["data"]
            let type:String? = dic["tp"]
            let result = String.decoding(data!,type: type!)
            NSLog(result!)

            
        }

        
    }


}

