//
//  AddBookPage.swift
//  libraryManagement
//
//  Created by jiseok kim on 2020/08/03.
//  Copyright © 2020 jiseok kim. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class AddBookPage: UIViewController,SendDataDelegate {
    
    var selectedBook : Book = Book()
    let queue = DispatchQueue(label: "queue")
    
    func sendData(data: Book) {
        selectedBook = data
    }
    func reloadVC(){
        self.viewWillAppear(true)
    }

    
    @IBAction func compeleteBtn(_ sender: Any) {
    }
    @IBOutlet weak var starRating: StarRatingView!
    @IBOutlet weak var bookImage: UIImageView!
   
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var pubDateLabel: UILabel!
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var myThinkView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if(selectedBook.title.isEmpty == true){
           
        }else{
            let url = URL(string:selectedBook.image)
            do {
                 let data = try Data(contentsOf: url!)
                let image = UIImage(data: data)
                self.bookImage.image = image

            }catch let err {
                 print("Error : \(err.localizedDescription)")
            }
            titleLabel.text = selectedBook.title
            authorLabel.text = selectedBook.author
            publisherLabel.text = selectedBook.publisher
            pubDateLabel.text = selectedBook.pubdate
            descriptionView.text = selectedBook.description
            
        
//            bookImage.image = UIImage(data: data!)
        }
    }
   

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show" {
            let viewController : SerchBookVC = segue.destination as! SerchBookVC
            viewController.delegate = self
            
        }
        
    }
    

    @IBAction func test(_ sender: Any) {
       
        let db = Firestore.firestore()
        
        let author :String = self.selectedBook.author
        let cover :String = self.selectedBook.image
        let note :String = myThinkView.text ?? ""
        let pubDate : String = self.selectedBook.pubdate
        let publisher : String = self.selectedBook.publisher
        let rate : Float = self.starRating.rating 
        let summary : String = self.selectedBook.description
        let title : String = self.selectedBook.title
        let writeDate : Date = Date()
        let isbn : String = self.selectedBook.isbn
        let year : String = self.selectedBook.year
        let month : String = self.selectedBook.month
        
        let uid :String = Auth.auth().currentUser?.uid ?? ""
        if(author.isEmpty != true){
            let _ = queue.sync {
                db.collection("User").document("\(uid)").collection("Book").document("\(isbn)").setData([
                    "author": "\(author)",
                    "cover": "\(cover))",
                    "note": "\(note)",
                    "pubDate": "\(pubDate)",
                    "publisher": "\(publisher)",
                    "rate": rate,
                    "summary": "\(summary)",
                    "title": "\(title)",
                    "writeDate": Timestamp(date: writeDate),
                    "isbn" : "\(isbn)",
                    "year" : year,
                    "month" : month

                ])
                let docRef = db.collection("User").document("\(uid)")
                docRef.updateData(["totalBookCount" : FieldValue.increment(Int64(1))]){
                    err in
                    if let err = err{
                        print("Errer : \(err)")
                    }else{
                        print("update sucess")
                    }
                }
            }
        }else{
            return
        }
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
//    @IBAction func logOUT(_ sender: Any) {
//            let firebaseAuth = Auth.auth()
//        do {
//          try firebaseAuth.signOut()
//            Switcher.updateRootVC()
//        } catch let signOutError as NSError {
//          print ("Error signing out: %@", signOutError)
//        }
//    }
//
//
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
