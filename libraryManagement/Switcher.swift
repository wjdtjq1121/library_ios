//
//  Switcher.swift
//  libraryManagement
//
//  Created by jiseok kim on 2020/08/01.
//  Copyright © 2020 jiseok kim. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn

class Switcher {
    
    static func updateRootVC(){
        
        let status = (Auth.auth().currentUser != nil) ? true : false
        let window = UIApplication.shared.windows.first
        var rootVC : UIViewController?
       
            print(status)
        

        if(status == true){
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabbarvc") as! UITabBarController
        }else{
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginvc") as! ViewController
        }
        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        window?.rootViewController = rootVC
        
    }
    
}
