//
//  ViewControllerInfoMeasurement.swift
//  PresionArterial
//
//  Created by Juan Pablo on 10/12/19.
//  Copyright © 2019 Gustavo Paez. All rights reserved.
//

import UIKit

class ViewControllerInfoMeasurement: UIViewController {
    var measurement = [Measurement]()
    @IBOutlet var lblSistolic: UILabel!
    @IBOutlet var lblWeight: UILabel!
    @IBOutlet var lblNotes: UILabel!
    @IBOutlet var lblDistolic: UILabel!
    @IBOutlet var scMeasure: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblSistolic.text = String(measurement[0].systolicP)
        lblDistolic.text = String(measurement[0].diastolicP)
        lblWeight.text = String(measurement[0].weight)
        lblNotes.text = String(measurement[0].notes)
    }
    
    @IBAction func scClicked(_ sender: Any) {
        lblSistolic.text = String(measurement[scMeasure.selectedSegmentIndex].systolicP)
        lblDistolic.text = String(measurement[scMeasure.selectedSegmentIndex].diastolicP)
        lblWeight.text = String(measurement[scMeasure.selectedSegmentIndex].weight)
    lblNotes.text = String(measurement[scMeasure.selectedSegmentIndex].notes)
    }
    

}
