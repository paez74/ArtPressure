//
//  Measurements.swift
//  PresionArterial
//
//  Created by Juan Pablo on 11/4/19.
//  Copyright © 2019 Gustavo Paez. All rights reserved.
//

import UIKit

class Measurements: NSObject {
    var weight:Double!
    var measures:[Measurement]
    var date:Date!
    var notes:String!
    
    init(measures:[Measurement],date:Date,weight:Double){
        self.measures = measures
        self.date = date
        self.weight = weight;
        self.notes = "";
    }
    init(measures:[Measurement],date:Date,weight:Double,notes:String){
        self.measures = measures
        self.date = date
        self.weight = weight;
        self.notes = notes;
    }

}
