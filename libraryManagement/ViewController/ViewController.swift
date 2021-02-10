//
//  ViewController.swift
//  libraryManagement
//
//  Created by jiseok kim on 2020/07/31.
//  Copyright © 2020 jiseok kim. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController {

 
    @IBOutlet weak var siginInButton: GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (result, Error) in
            print(result)
        }
        
        GIDSignIn.sharedInstance()?.presentingViewController = self

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)   
    
    }

  
   
    
}

