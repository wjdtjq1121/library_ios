//
//  Book.swift
//  libraryManagement
//
//  Created by jiseok kim on 2020/08/03.
//  Copyright © 2020 jiseok kim. All rights reserved.
//

import Foundation

struct BookItem: Codable {
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
    
}

