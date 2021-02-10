//
//  ApiDataManager.swift
//  libraryManagement
//
//  Created by jiseok kim on 2020/08/04.
//  Copyright © 2020 jiseok kim. All rights reserved.
//
import Foundation

class dataManager {
    
    static let shared: dataManager = dataManager()
    var searchResult: SearchResult?
    
    private init () {
    }
    
}

struct SearchResult: Codable {
    let lastBuildDate : String
    let total : Int
    let start : Int
    let display : Int
    let items : [BookItem]
    
}

