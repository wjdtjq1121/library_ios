//
//  TabVc.swift
//  libraryManagement
//
//  Created by jiseok kim on 2020/08/01.
//  Copyright © 2020 jiseok kim. All rights reserved.
//

import UIKit

class TabVc: UIViewController {
    
    @IBAction func logout(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "status")
        Switcher.updateRootVC()
    }

}
