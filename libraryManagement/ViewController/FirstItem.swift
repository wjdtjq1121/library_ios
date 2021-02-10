//
//  bookShelfViewController.swift
//  libraryManagement_main
//
//  Created by 권지현 on 7/30/20.
//  Copyright © 2020 권지현. All rights reserved.
//

import UIKit

class FirstItem: UIViewController {


    
    @IBOutlet weak var segementBtn: UISegmentedControl!
    @IBOutlet weak var addBookButton: UIBarButtonItem!
    @IBOutlet weak var firstContainer: UIView!
    @IBOutlet weak var secondContainer: UIView!
//    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        firstContainer.translatesAutoresizingMaskIntoConstraints = false
//        let width = firstContainer.widthAnchor.constraint(equalTo: self.view.widthAnchor)
//        let height = firstContainer.heightAnchor.constraint(equalTo: firstContainer.widthAnchor)
//        width.isActive = true
//        height.isActive = true
        
    }
  
    //list형태 서재에서 책 추가할 수 있는 버튼 구현
    override func viewDidAppear(_ animated: Bool) {

        self.addBookButton?.tintColor = UIColor.blue
        self.addBookButton?.isEnabled = true
        
        
        if(self.segementBtn.selectedSegmentIndex == 0){
            UIView.animate(withDuration: 0.5, animations: {
                self.firstContainer?.alpha = 1
                self.secondContainer?.alpha = 0
            })
        }
        
    }
    
    

    //segmented control버튼으로 shelf형태 서재에서 list형태의 서재로 넘어가는 기능 구현
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            UIView.animate(withDuration: 0.5, animations: {
                self.firstContainer.alpha = 1
                self.secondContainer.alpha = 0
            })
            
        } else{
            UIView.animate(withDuration: 0.5, animations: {
                self.firstContainer.alpha = 0
                self.secondContainer.alpha = 1
            })
            
        }
        self.addBookButton?.isEnabled = true
        self.addBookButton?.tintColor = UIColor.blue
    }
    
}

