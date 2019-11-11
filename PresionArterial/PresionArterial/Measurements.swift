//
//  Measurements.swift
//  PresionArterial
//
//  Created by Juan Pablo on 11/4/19.
//  Copyright © 2019 Gustavo Paez. All rights reserved.
//

import UIKit

class Measurements: NSObject {
    var measures:[Measurement]
    var date:Date!
    
    init(measures:[Measurement],date:Date){
        self.measures = measures
        self.date = date
    }
}
