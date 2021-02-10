//
//  FourthItem.swift
//  libraryManagement
//
//  Created by jiseok kim on 2020/08/02.
//  Copyright © 2020 jiseok kim. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase
import GoogleSignIn
import FirebaseCore

class FourthItem: UIViewController {
    
    
    //알람끄기

        var alarm: Bool = true

        

        var count = 0

        




    override func viewDidLoad() {
        super.viewDidLoad()
        
        


        
        
//        UNUserNotificationCenter.current().requestAuthorization(options: UNAuthorizationOptions, completionHandler: (Bool, Error?) -> Void)
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
    
    @IBAction func firebaseUpdate(_ sender: Any) {
        
        let db = Firestore.firestore()
            let uid: String = Auth.auth().currentUser?.uid ?? ""
            
                   db.collection("User").document("\(uid)").setData([
            
                             "monthGoal": "5",
                             "yearGoal": "34"
                         ])
            
            
        
        
    }
    
    
    
    @IBAction func changeFirebaseDbButton(_ sender: Any) {
        
        
        let db = Firestore.firestore()
        let uid: String = Auth.auth().currentUser?.uid ?? ""
        
               db.collection("User").document("\(uid)").setData([
        
                         "monthGoal": "5",
                         "yearGoal": "34"
                     ])
        
        
    

        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    

    @IBAction func datePicker(_ sender: Any) {
        
        
    }

    @IBAction func didTouchButton(_ sender: Any) {
        let content = UNMutableNotificationContent()
        content.title = "제목"
        content.body = "내용"
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        
        let request = UNNotificationRequest(identifier: "test", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
