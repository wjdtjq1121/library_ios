//
//  detailVC.swift
//  libraryManagement
//
//  Created by jiseok kim on 2020/08/06.
//  Copyright © 2020 jiseok kim. All rights reserved.
//

import UIKit
import Firebase

class DetailVC: UIViewController {

    var book : Book?
    let queue = DispatchQueue(label: "queue")
    var isbn : String = ""
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var pubDateLabel: UILabel!
    @IBOutlet weak var ImageVIew: UIImageView!
    @IBOutlet weak var starVIew: StarRatingView!
    @IBOutlet weak var summaryText: UITextView!
    @IBOutlet weak var noteText: UITextView!
    
    @IBOutlet weak var deleteBtn: UIBarButtonItem!
    @IBOutlet weak var sharedBtn: UIBarButtonItem!
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    
    override func viewDidLoad() {
        let title = book?.title ?? ""
        let author = book?.author ?? ""
        let publisher = book?.publisher ?? ""
        let pubDate = book?.pubdate ?? ""
        let rate = book?.rate ?? 0
        let image = book?.image ?? ""
        let summary = book?.description ?? ""
        let note = book?.myThink ?? ""
        self.isbn = book?.isbn ?? ""
        
        super.viewDidLoad()

        
       
        titleLabel.text = title
        authorLabel.text = author
        publisherLabel.text = publisher
        pubDateLabel.text = pubDate
        summaryText.text = summary
        noteText.text = note
        starVIew.rating = rate
        
        let url = URL(string:image)
        do {
             let data = try Data(contentsOf: url!)
            let image = UIImage(data: data)
            self.ImageVIew.image = image

        }catch let err {
             print("Error : \(err.localizedDescription)")
        }
        
       
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? EditVC  else{
           return
        }
        destination.book = self.book
        
    }
    
    @IBAction func deleteBtnPressed(_ sender: Any) {
         let alert = UIAlertController(title: "정말 삭제하시겠습니까?", message: "삭제한 정보는 되돌릴 수 없습니다.", preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default,handler: {
            (action) in
            let db = Firestore.firestore()
            let uid :String = Auth.auth().currentUser?.uid ?? ""
            
            let _ = self.queue.sync {
                let docRef = db.collection("User").document("\(uid)")
                docRef.updateData(["totalBookCount" : FieldValue.increment(Int64(-1))]){
                    err in
                    if let err = err{
                        print("Errer : \(err)")
                        
                    }else{
                        print("update sucess")
                        
                    }
                    
                }
                db.collection("User").document("\(uid)").collection("Book").document("\(self.isbn)").delete(){ err in
                    if let err = err {
                        print("Error removing document: \(err)")
                    } else {
                        print("Document successfully removed!")
                    }
                }
            }
            
            self.navigationController?.popViewController(animated: true)
            
        })
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert,animated: false,completion: nil)
    }
    func announce() {
           print("announce call")
           
           let text = "공유하기"
           let textToShare = [ text ]
           // 액티비티 뷰 컨트롤러 셋업
           let activityVC = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
           // 제외하고 싶은 타입을 설정 (optional)
           //activityVC.excludedActivityTypes = [ UIActivity.ActivityType.airDrop ]
           // 현재 뷰에서 present
           self.present(activityVC, animated: true, completion: nil)
       }
    
    @IBAction func shareBtnPressed(_ sender: Any) {
        announce()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
