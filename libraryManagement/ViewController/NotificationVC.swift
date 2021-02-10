//
//  NotificationVC.swift
//  libraryManagement
//
//  Created by jiseok kim on 2020/08/12.
//  Copyright © 2020 jiseok kim. All rights reserved.
//

import UIKit

class NotificationVC: UITableViewController {
    
    
    let datePicker = UIDatePicker()
    
  
    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        showDatePicker()
        textField.tintColor = .clear
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .time
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelDatePicker))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        // add toolbar to textField
        textField.inputAccessoryView = toolbar
        // add datepicker to textField
        textField.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        //For date formate
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        let date = formatter.date(from: formatter.string(from: datePicker.date))
        formatter.dateFormat = "HH:mm"
        
        textField.text = formatter.string(from: date!)
        //dismiss date picker dialog
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        //cancel button dismiss datepicker dialog
        self.view.endEditing(true)
    }
}

    
