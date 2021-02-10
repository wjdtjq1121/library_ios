//
//  SerchBookVC.swift
//  libraryManagement
//
//  Created by jiseok kim on 2020/08/04.
//  Copyright © 2020 jiseok kim. All rights reserved.
//

import UIKit

protocol SendDataDelegate {

    func sendData(data: Book)
    func reloadVC()
}

class SerchBookVC: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var searchBtn: UIButton!
    
    var delegate : SendDataDelegate?
    let jsconDecoder: JSONDecoder = JSONDecoder()
    var bookResult : [Book] = []
    var selectedBook : Book = Book()
    override func viewDidLoad() {
        searchBtn.backgroundColor = .gray
        searchBtn.isEnabled = false
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchTextChanged(_ sender: Any) {
        if((searchTextField.text?.isEmpty) == true) {
            searchBtn.backgroundColor = .gray
            searchBtn.isEnabled = false
        }else{
            searchBtn.backgroundColor = .systemBlue
            searchBtn.isEnabled = true
        }
    }
    
    @IBAction func searchBtnPressed(_ sender: Any) {
        let queryValue: String = searchTextField.text!
        requestAPIToNaver(queryValue: queryValue)
    }
    
    
    
  
    
    func requestAPIToNaver(queryValue: String) {
        let clientID: String = "pg6LxXFBksK8cSpRZXZW"
        let clientKEY: String = "r8pJsxUcir"
        
        let query: String  = "https://openapi.naver.com/v1/search/book.json?query=\(queryValue)&display=10&start=1"
        let encodedQuery: String = query.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        let queryURL: URL = URL(string: encodedQuery)!
       
        var requestURL = URLRequest(url: queryURL)
        requestURL.addValue(clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        requestURL.addValue(clientKEY, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        
        let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
            guard error == nil else { print(error ?? ""); return }
            guard let data = data else { print(error ?? ""); return }
       
            
            do {
                let searchInfo: SearchResult = try self.jsconDecoder.decode(SearchResult.self, from: data)
                dataManager.shared.searchResult = searchInfo
                self.bookResult = []
                DispatchQueue.main.async {
                    for item in dataManager.shared.searchResult!.items{
                        self.bookResult.append(Book(bookItem: item))
                    }
                    self.TableView.reloadData()
                }

            } catch {
                print(fatalError())
            }
        }
        task.resume()
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

extension SerchBookVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell",for: indexPath)
//        cell.textLabel?.text = "\(indexPath.row)"

        cell.textLabel?.text = bookResult.isEmpty ? "" : "\(bookResult[indexPath.row].title)"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(bookResult.isEmpty != true){
            self.selectedBook = self.bookResult[indexPath.row]

            delegate?.sendData(data: self.selectedBook)
            delegate?.reloadVC()
            dismiss(animated: true, completion: nil)
        }
        
    }
    
}
