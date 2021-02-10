//
//  settingItem.swift
//  libraryManagement
//
//  Created by jsHan on 2020/08/11.
//  Copyright © 2020 jiseok kim. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase



class settingItem: UITableViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {
    
    
    @IBOutlet weak var monthPicker: UITextField!
    @IBOutlet weak var yearPicker: UITextField!
    
    let queue = DispatchQueue(label: "queue")
    let picker1 = UIPickerView()
    let picker2 = UIPickerView()
    
    
    let month = ["1","2","3","4","5","6","7","8","9","10"]
    let year = ["12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker1.dataSource = self
        picker1.delegate = self
        
        picker2.dataSource = self
        picker2.delegate = self
        
        
        picker1.tag = 1
        picker2.tag = 2;
        
        monthPicker.tintColor = .clear
        yearPicker.tintColor = .clear
        
        monthPicker.inputView = picker1
        yearPicker.inputView = picker2
        
        dismissPickerView()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //   self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == picker1{
            return month.count
        } else if pickerView == picker2{
            return year.count
        }
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == picker1{
            return month[row]
        } else if pickerView == picker2{
            return year[row]
        }
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == picker1{
            monthPicker.text = month[row]
            //            self.view.endEditing(false)
        } else if pickerView == picker2{
            yearPicker.text = year[row]
            //            self.view.endEditing(false)
        }
        
        
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        monthPicker.inputAccessoryView = toolBar
        yearPicker.inputAccessoryView = toolBar
    }
    @objc func action() {
        self.view.endEditing(true)
    }
    
    @IBAction func logOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        
        let alert = UIAlertController(title: "정말 로그아웃 하시겠습니까?", message: "", preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default,handler: {
            (action) in
            do {
                try firebaseAuth.signOut()
                
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
            Switcher.updateRootVC()
        })
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert,animated: false,completion: nil)
        
        
    }
    // MARK: - Table view data source
    
    @IBAction func saveSetting(_ sender: Any) {
        print("aaa")
        let alert = UIAlertController(title: "설정을 저장하시겠습니까?", message: "설정한 항목들이 저장됩니다.", preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default,handler: {
            (action) in
            let db = Firestore.firestore()
            let uid :String = Auth.auth().currentUser?.uid ?? ""
            
            let _ = self.queue.sync {
                
                let docRef = db.collection("User").document("\(uid)")
                
                let mGoal = self.monthPicker.text ?? "0"
                let yGoal = self.yearPicker.text ?? "0"
                docRef.updateData(["monthGoal" : mGoal,"yearGoal":yGoal]){
                    err in
                    if let err = err{
                        print("Errer : \(err)")
                        
                    }else{
                        print("update sucess")
                        
                    }
                    
                }
            }
            
            
            
        })
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert,animated: false,completion: nil)
        
    }
    
    
    
    
    
    
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath.row){
    //
    //          performSegue(withIdentifier: "year", sender: self)
    //      }
    
    
    
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
