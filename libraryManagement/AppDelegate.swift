//
//  AppDelegate.swift
//  libraryManagement
//
//  Created by jiseok kim on 2020/07/31.
//  Copyright © 2020 jiseok kim. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseCore



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        FirebaseApp.configure()
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self
        return true
    }
    
    
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
      -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
      // ...
      if let error = error {
        print(error)
        return
      }

      guard let authentication = user.authentication else { return }
      
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                        accessToken: authentication.accessToken)
        
      // ...
      Auth.auth().signIn(with: credential) { (authResult, error) in
        if let error = error {
            print(error)
          return
        }
        let client = Auth.auth().currentUser
            let db = Firestore.firestore()
            let uid :String = client?.uid ?? ""
            let email :String = client?.email ?? ""
            let name :String = client?.displayName ?? ""

            db.collection("User").document("\(uid)").setData([
                "email": "\(email)",
                "name": "\(name)",
                "uid": "\(uid)",
                "monthGoal": "0",
                "yearGoal": "0",
                "totalBookCount": 0
            ])
        Switcher.updateRootVC()
        
        // User is signed in
        // ...
      }
        
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

