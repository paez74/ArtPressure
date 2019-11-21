//
//  Autentificacion.swift
//  PresionArterial
//
//  Created by Antonio Alemán  on 11/19/19.
//  Copyright © 2019 Gustavo Paez. All rights reserved.
//

import UIKit

class Autentificacion: Codable {

    var correo: String
    var contrasena: String
    init(correo : String, contrasena: String) {
        self.correo = correo
        self.contrasena = contrasena }
}
