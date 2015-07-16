//
//  ViewController.swift
//  Erm_mobile_ios
//
//  Created by 孙龙霄 on 7/15/15.
//  Copyright © 2015 孙龙霄. All rights reserved.
//

import UIKit

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
        
        do{//swift2.0新增try catch
//            let paramsData = try NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions.PrettyPrinted)
//            postJson["params"] = String(NSString(data: paramsData, encoding: NSUTF8StringEncoding)!);
            postJson["params"] = params
            
        }catch{
            NSLog("---------->json转字符串错误");
        }
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
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func request(url:String,Method:String,data:String){
        //            url = @"http://academy.yonyou.com/api/postTest.ashx";

        let urlRequest = NSMutableURLRequest(URL: NSURL(string: url)!, cachePolicy: NSURLRequestCachePolicy.ReloadRevalidatingCacheData, timeoutInterval: 30)
        
        let bodyData = data.dataUsingEncoding(NSUTF8StringEncoding)
        urlRequest.HTTPBody = bodyData
        urlRequest.setValue("Accept-Encoding", forHTTPHeaderField: "gzip");
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type");
        urlRequest.HTTPMethod = "POST"
        
//        var receivedData = NSMutableData(length: 0);
        
//        let newConnection = NSURLConnection(request: urlRequest, delegate: self)
//        
//        newConnection?.start()
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            if data != nil{
            
                do{
                    let dic:Dictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! [String:String]
                    
                    let data:String? = dic["data"]
                    let type:String? = dic["tp"]
                    let result = String.decoding(data!,type: type!)
                    NSLog(result!)
                } catch{
                    NSLog("---------->json转字符串错误");
                    
                }
                
                
            }
            
            
        }
        
    }


}

