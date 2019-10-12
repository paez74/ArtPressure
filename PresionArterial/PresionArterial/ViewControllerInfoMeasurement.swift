//
//  ViewControllerInfoMeasurement.swift
//  PresionArterial
//
//  Created by Juan Pablo on 10/12/19.
//  Copyright © 2019 Gustavo Paez. All rights reserved.
//

import UIKit

class ViewControllerInfoMeasurement: UIViewController {
    var measurement:Measurement!
    @IBOutlet var lblSistolic: UILabel!
    @IBOutlet var lblWeight: UILabel!
    @IBOutlet var lblNotes: UILabel!
    @IBOutlet var lblDistolic: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblSistolic.text = String(measurement.systolicP)
        lblDistolic.text = String(measurement.diastolicP)
        lblWeight.text = String(measurement.weight)
        lblNotes.text = String(measurement.notes)
    }
    


}
