//
//  EditVC.swift
//  libraryManagement
//
//  Created by jiseok kim on 2020/08/07.
//  Copyright © 2020 jiseok kim. All rights reserved.
//

import UIKit
import Firebase

class EditVC: UIViewController {
    
    var book : Book? = nil
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
    @IBOutlet weak var doneBtn: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        authorLabel.textAlignment = .left
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
    
    
    @IBAction func doneBtnPressed(_ sender: Any) {
        
        let db = Firestore.firestore()
        let title = self.titleLabel.text ?? ""
        let author = self.authorLabel.text ?? ""
        let publisher = self.publisherLabel.text ?? ""
        let pubDate = self.pubDateLabel.text ?? ""
        let rate = self.starVIew.rating
        let image = self.book?.image ?? ""
        let summary = self.summaryText.text ?? ""
        let note = self.noteText.text ?? ""
        let writeDate = self.book?.writeDate ?? Timestamp(date: Date(timeInterval: -3600, since: Date()))
        let year = book?.year ?? ""
        let month = book?.month ?? ""
        self.isbn = book?.isbn ?? ""
        
        let uid :String = Auth.auth().currentUser?.uid ?? ""
        let _ = queue.sync {
            db.collection("User").document("\(uid)").collection("Book").document("\(isbn)").setData([
                "author": "\(author)",
                "cover": "\(image)",
                "note": "\(note)",
                "pubDate": "\(pubDate)",
                "publisher": "\(publisher)",
                "rate": rate,
                "summary": "\(summary)",
                "title": "\(title)",
                "writeDate": writeDate,
                "isbn" : "\(isbn)",
                "year" : year,
                "month" : month

            ])
        }
        
        performSegue(withIdentifier: "unwied", sender: self)
        
        
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
