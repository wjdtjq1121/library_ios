//
//  firstMainViewController.swift
//  libraryManagement_main
//
//  Created by 권지현 on 7/31/20.
//  Copyright © 2020 권지현. All rights reserved.
//

import UIKit
import Firebase


class FirstBookShelfViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var collectionView: UICollectionView!
    
    var bookList : Array<Book> = []

    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named:"lib")
        iv.contentMode = .scaleAspectFill
        return iv
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView?.backgroundView = imageView
        let itemWidth = UIScreen.main.bounds.width / 3
        let itemHeight = UIScreen.main.bounds.height / 5.3
        let horizontalCV = HorizontalFlowLayout();

        horizontalCV.itemSize = CGSize(width: itemWidth , height: itemHeight)

        self.collectionView.collectionViewLayout = horizontalCV


    }


    override func viewWillAppear(_ animated: Bool) {
        let uid = (Auth.auth().currentUser?.uid) ?? ""
        let db = Firestore.firestore()
        db.collection("User").document("\(uid)").collection("Book").order(by: "writeDate",descending:true ).getDocuments(){(QuerySnapshot, err) in
        if let err = err{
            print("Error getting documents : \(err)")
            
        } else{
            DispatchQueue.main.async {
                self.bookList = []
                for document in QuerySnapshot!.documents{
                    self.bookList.append(Book(document: document))
                }
                self.collectionView.reloadData()
            }
        }
    }
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookList.count
    }
    
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let bookCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell

        let url = URL(string: self.bookList[indexPath.row].image)
        do {
            let data = try Data(contentsOf: url!)
            // do something with data
            // if the call fails, the catch block is executed
            bookCell.cellImage?.image = UIImage(data: data)
            bookCell.cellImage.contentMode = .scaleAspectFit

        } catch {
            print(error.localizedDescription)
        }

        return bookCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {


        performSegue(withIdentifier: "showDetail", sender: self)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = collectionView?.indexPathsForSelectedItems?.first {
            let vc = segue.destination as! DetailVC
            vc.book = bookList[indexPath.row]
        }
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
