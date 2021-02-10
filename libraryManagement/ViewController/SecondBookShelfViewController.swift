//
//  secondMainViewController.swift
//  libraryManagement_main
//
//  Created by 권지현 on 7/31/20.
//  Copyright © 2020 권지현. All rights reserved.
//

import UIKit
import Firebase

class SecondBookShelfViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var bookList : Array<Book> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        bookList = []
        let uid = (Auth.auth().currentUser?.uid) ?? ""
        let db = Firestore.firestore()
        
    

        db.collection("User").document("\(uid)").collection("Book").order(by: "writeDate",descending:true ).getDocuments(){(QuerySnapshot, err) in
            if let err = err{
                print("Error getting documents : \(err)")
            } else{
                DispatchQueue.main.async {
                    for document in QuerySnapshot!.documents{
                        self.bookList.append(Book(document: document))
                    }
                    self.tableView.reloadData()
                  
                }
            }
        }

    }
    
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return bookList.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if(indexPath.row > bookList.count-1){
              return UITableViewCell()
            }
          else{

          let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! BookListTableViewCell
            do {
                       let url = URL(string: self.bookList[indexPath.row].image)
                       let data = try Data(contentsOf: url!)
                       cell.bookTitle?.text = self.bookList[indexPath.row].title
                       cell.bookAuthor?.text = self.bookList[indexPath.row].author
                       cell.bookDate?.text = self.bookList[indexPath.row].pubdate
                       cell.starRating?.rating = self.bookList[indexPath.row].rate
                       cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
                       cell.bookImageView?.image = UIImage(data: data)
                   } catch {
                       print(error.localizedDescription)
                   }

          return cell
        }
        
    }
    
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
            performSegue(withIdentifier: "showDetail", sender: self)
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailVC {
            destination.book = self.bookList[(tableView.indexPathForSelectedRow!.row)]
            tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
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




