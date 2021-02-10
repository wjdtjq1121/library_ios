//
//  Book.swift
//  libraryManagement
//
//  Created by jiseok kim on 2020/08/04.
//  Copyright © 2020 jiseok kim. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift



struct Book: Codable {
    let title: String
    let link: String
    let image: String
    let author: String
    let price : String
    let discount : String
    let publisher: String
    let pubdate: String
    let isbn: String
    let description: String
    let myThink: String
    var rate : Float
    let writeDate : Timestamp
    let year : String
    let month : String
    
    init(bookItem : BookItem) {
        var tempString = bookItem.pubdate
        if(tempString.count >= 7){
            tempString.insert(".",at: tempString.index(tempString.startIndex,offsetBy: 4))
            tempString.insert(".",at: tempString.index(tempString.startIndex,offsetBy: 7))
        }
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM"
        let formattedDate = format.string(from: date)
        let currentYear = formattedDate.prefix(4)
        let currentMonth = formattedDate.suffix(2)
        title = bookItem.title.components(separatedBy: ["<",">","b","/"]).joined()
        link = bookItem.link
        image = bookItem.image
        author = bookItem.author.components(separatedBy: ["<",">","b","/"]).joined()
        price = bookItem.price
        discount = bookItem.discount
        publisher = bookItem.publisher
        pubdate = tempString
        isbn = bookItem.isbn
        description = bookItem.description.components(separatedBy: ["<",">","b","/"]).joined()
        myThink = ""
        rate = 0
        writeDate = Timestamp(date: Date())
        year = String(currentYear)
        month = String(currentMonth)
    }

    init() {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM"
        let formattedDate = format.string(from: date)
        let currentYear = formattedDate.prefix(4)
        let currentMonth = formattedDate.suffix(2)
        title = ""
        link = ""
        image = ""
        author = ""
        price = ""
        discount = ""
        publisher = ""
        pubdate = ""
        isbn = ""
        description = ""
        myThink = ""
        rate = 0
        writeDate = Timestamp(date: Date())
        year = String(currentYear)
        month = String(currentMonth)
    }
    
    init(book : Book) {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM"
        let formattedDate = format.string(from: date)
        let currentYear = formattedDate.prefix(4)
        let currentMonth = formattedDate.suffix(2)
        
        title = book.title
        link = book.link
        image = book.image
        author = book.author
        price = book.price
        discount = book.discount
        publisher = book.publisher
        pubdate = book.pubdate
        isbn = book.isbn
        description = book.description
        myThink = ""
        rate = 0
        writeDate = Timestamp(date: Date())
        year = String(currentYear)
        month = String(currentMonth)
    }
    
    init (document : QueryDocumentSnapshot){
        author = document.data()["author"] as? String ?? ""
        image = document.data()["cover"] as? String ?? ""
        myThink = document.data()["note"] as? String ?? ""
        pubdate = document.data()["pubDate"] as? String ?? ""
        publisher = document.data()["publisher"] as? String ?? ""
        rate = document.data()["rate"] as? Float ?? 0
        description = document.data()["summary"] as? String ?? ""
        title = document.data()["title"] as? String ?? ""
        link = ""
        price = ""
        discount = ""
        isbn = document.data()["isbn"] as? String ?? ""
        writeDate = document.data()["writeDate"] as? Timestamp ?? Timestamp(date: Date(timeInterval: -3600, since: Date()))
        year = document.data()["year"] as? String ?? ""
        month = document.data()["month"] as? String ?? ""
    }
    
   
   
}
