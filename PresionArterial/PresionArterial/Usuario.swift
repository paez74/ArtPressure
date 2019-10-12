//
//  Usuario.swift
//  PresionArterial
//
//  Created by Juan Pablo on 10/11/19.
//  Copyright © 2019 Gustavo Paez. All rights reserved.
//

import UIKit

class Usuario: NSObject {
    var name:String!
    var email:String!
    var username:String!
    var bday:Date!
    
    
    init(name:String,email:String,username:String,bday:Date){
        self.name = name
        self.email = email
        self.username = username
        self.bday = bday
    }
}
