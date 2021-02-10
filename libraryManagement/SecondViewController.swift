//
//  SecondViewController.swift
//  libraryManagement
//
//  Created by jiseok kim on 2020/08/01.
//  Copyright © 2020 jiseok kim. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logOut(_ sender: Any) {
        do{
            performSegue(withIdentifier: "unwideVC1", sender: nil)
            try Auth.auth().signOut()
            
            
        }
            catch let signOutError as NSError{
                print("Error signing out: %@ ",signOutError)
        }
    }
    @IBAction func unwindVC1 (segue : UIStoryboardSegue) {}
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
