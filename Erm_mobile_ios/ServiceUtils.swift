//
//  ServiceUtils.swift
//  Erm_mobile_ios
//
//  Created by 孙龙霄 on 7/17/15.
//  Copyright © 2015 孙龙霄. All rights reserved.
//

import UIKit

class ServiceUtils{
    
    
    static let UUID = DeviceUtils.UUID()
    static let NAME = DeviceUtils.NAME()
    static let MODULE = DeviceUtils.MODULE()
    
    
    struct userInfo{
        static var user = ""
        static var pass = ""
        static var ip = ""
        static var port = ""
    }
    
    
    
    static func getAppContext() -> [String:AnyObject]{
        //---------------------------------appJson------------------------------//
        var appJson = Dictionary<String,String>()
        
        let userDefault = NSUserDefaults.standardUserDefaults()
        let userid = userDefault.valueForKey("userid") as! String?
        let groupid = userDefault.valueForKey("groupid")as! String?
        
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
        appJson["userid"] = ( userid == nil ? "" : userid!)
        appJson["groupid"] = ( groupid == nil ? "" : groupid!)

        
        
        //##################输入选项###################//
        appJson["user"] = ServiceUtils.userInfo.user
        appJson["pass"] = ServiceUtils.userInfo.pass
        //############################################//
        
        //--------------------------------------------------------------------//
        
        return appJson
    }
    
    static func getDeviceInfo() -> [String:AnyObject]{
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
        
        return deviceinfoJson
    }
    
    static func getServicecontext(controllerid:String,callback:String,error:String,viewid:String,windowid:String,actionname:String, success:String) -> [String:AnyObject]{
        
        //---------------------------------postJson-----------------------------//
        var postJson = Dictionary<String,AnyObject>()
        postJson["actionid"] = ""
        postJson["actionname"] = actionname
        postJson["callback"] = callback
        postJson["contextmapping"] = "none"
        postJson["controllerid"] = controllerid
        postJson["viewid"] = viewid
        postJson["windowid"] = windowid
        
        var params = Dictionary<String,String>()
        params["contextmapping"] = "none"
        params["error"] = error
        //##################输入选项###################//
        params["pass"] = ServiceUtils.userInfo.pass
        //############################################//
        params["success"] = success
        params["type"] = "nc"
        postJson["params"] = params
        //---------------------------------------------------------------------//
        
        return postJson
        
    }
    
    
    static func loginAction(user:String,pass:String, ip:String, port:String,returnResult:(Bool)->Void){

        ServiceUtils.userInfo.user = user
        ServiceUtils.userInfo.pass = pass
        ServiceUtils.userInfo.ip = ip
        ServiceUtils.userInfo.port = port
        
        callAction("com.nc.arap.erm_loginController", callback: "", error: "this.showerror()", viewid: "", windowid: "erm_loginController", actionname: "login", success: "openMainview", serviceid: "ncLoginService", loginCall: { (JSON) -> Void in
            
            let dic:Dictionary = JSON as! [String:String]
            
            let data:String? = dic["data"]
            let type:String? = dic["tp"]
            let result = String.decoding(data!,type: type!)
            do{
                let resultData = result!.dataUsingEncoding(NSUTF8StringEncoding)
                let resultCode = try NSJSONSerialization.JSONObjectWithData(
                    resultData!, options: NSJSONReadingOptions.MutableContainers)
                let resultcode = resultCode["code"]! as! String
                
                if resultcode == "1" {
                    NSLog("Login Success")
                    
                    let resultctx = resultCode["resultctx"] as! [String:AnyObject]
                    
                    let userid = resultctx["userid"] as! String
                    let groupid = resultctx["groupid"] as! String
                    let token = resultctx["token"] as! String
                    
                    let userDefault = NSUserDefaults.standardUserDefaults()
                    userDefault.setValue(userid, forKey: "userid")
                    userDefault.setValue(groupid, forKey: "groupid")
                    userDefault.setValue(token, forKey: "token")
                    userDefault.synchronize()//可以不写这句话
                    
                    returnResult(true)
                    
                    
                }
            }catch{
                
            }
            

            returnResult(false)
            }, resultctxCall: nil)
        
    }
    
    
    
    
    static func callAction(controllerid:String,callback:String,error:String,viewid:String,windowid:String,actionname:String, success:String,serviceid:String,loginCall:((AnyObject!)->Void)?,resultctxCall:(([String:AnyObject]!)->Void)?){
        
        
        let appJson = ServiceUtils.getAppContext()
        let deviceinfoJson = ServiceUtils.getAppContext()
        
        var postJson:[String:AnyObject]?
        
        if serviceid == "ncLoginService"{
            postJson = ServiceUtils.getServicecontext(controllerid, callback: callback, error: error, viewid: viewid, windowid: windowid, actionname: actionname, success: success)
        }else if serviceid == "umCommonService"{
            postJson = ServiceUtils.getServicecontext("com.nc.arap.mainController", callback: "main_onload_callback()", error: "main_onload_callback()", viewid: "com.yonyou.arap.mobile.controller.DefController", windowid: "mainController", actionname: "getUserID", success: "")
        }
        
        
        var rootjson = Dictionary<String,AnyObject>()
        rootjson["serviceid"] = serviceid
        
        
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
                
                
                let data = "tp=des_gzip&data="+result!
                
                
                NetworkUtils.request("http://" + ServiceUtils.userInfo.ip + ":" + ServiceUtils.userInfo.port + "/umserver/core/", method: "post", data: data, success: { (JSON) -> Void in
                    
                    
                    if serviceid == "ncLoginService"{
                        
                        loginCall!(JSON)
                        
                    }else if serviceid == "umCommonService"{
                        
                        let dic:Dictionary = JSON as! [String:String]
                        
                        let data:String? = dic["data"]
                        let type:String? = dic["tp"]
                        let result = String.decoding(data!,type: type!)
                        
                        do{
                            let resultData = result!.dataUsingEncoding(NSUTF8StringEncoding)
                            let resultCode = try NSJSONSerialization.JSONObjectWithData(
                                resultData!, options: NSJSONReadingOptions.MutableContainers)
                            let  resultctx = resultCode["resultctx"]! as! [String:AnyObject]
                            
                            resultctxCall!(resultctx)
                            
                            
                            
                            
                            
                        }catch{
                            NSLog("---------->json转字符串错误")
                        }
                        
                    }
                    
                    }, errors: { () -> Void in
                        
                        
                })
                
            }
        }

    }
    
}