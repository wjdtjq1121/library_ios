//
//  statics.swift
//  libraryManagement
//
//  Created by jiseok kim on 2020/08/08.
//  Copyright © 2020 jiseok kim. All rights reserved.
//

import Foundation

struct Statistic: Codable {
    var totalCount: Int
    var monthGoal: Double
    var yearGoal: Double
    var monthCurrent: Double
    var yearCurrent : Double
    var yearData : [Double]
    var monthData : [Double]
    
    init() {
        totalCount = 0
        monthGoal = 0.0
        yearGoal = 0.0
        monthCurrent = 0.0
        yearCurrent = 0.0
        yearData = [0,0,0,0,0]
        monthData = [0,0,0,0,0,0,0,0,0,0,0,0]
    }
    
}



