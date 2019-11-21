//
//  Measurement.swift
//  PresionArterial
//
//  Created by Juan Pablo on 10/12/19.
//  Copyright © 2019 Gustavo Paez. All rights reserved.
//

import UIKit

class Measurement: NSObject {
    
    var systolic:Int!
    var diastolic:Int!
    
    init(systolic:Int,diastolic:Int){
        self.systolic = systolic
        self.diastolic = diastolic
    }
    
}
