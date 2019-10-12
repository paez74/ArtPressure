//
//  Measurement.swift
//  PresionArterial
//
//  Created by Juan Pablo on 10/12/19.
//  Copyright © 2019 Gustavo Paez. All rights reserved.
//

import UIKit

class Measurement: NSObject {
    var weight:Double!
    var systolicP:Int!
    var diastolicP:Int!
    var date:Date!
    var notes:String!
    
    init(weight:Double,systolicP:Int,diastolicP:Int,date:Date){
        self.weight = weight
        self.systolicP = systolicP
        self.diastolicP = diastolicP
        self.date = date
        self.notes = ""
    }
}
