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
        
        ServiceUtils.loginAction("1101", pass: "123456a", ip: "10.10.3.107", port: "9999") { (result) -> Void in
            
            if result {                
                ServiceUtils.callAction("com.nc.arap.mainController", callback: "main_onload_callback()", error: "main_onload_callback()", viewid: "com.yonyou.arap.mobile.controller.DefController", windowid: "mainController", actionname: "getUserID", success:  "", serviceid: "umCommonService", loginCall: nil, resultctxCall: { (dic) -> Void in
                    
                    NSLog(dic["userid"] as! String)
                    
                    
                })
                
            }else{

            }
        }
        


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

