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
    var weight:Double!;
    var notes:String!;
    @IBOutlet var lblSistolic: UILabel!
    @IBOutlet var lblWeight: UILabel!
    @IBOutlet var lblNotes: UILabel!
    @IBOutlet var lblDistolic: UILabel!
    @IBOutlet var scMeasure: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblSistolic.text = String(measurement[0].systolic)
        lblDistolic.text = String(measurement[0].diastolic)
        lblWeight.text = String(weight);
        lblNotes.text = notes;
    }
    
    @IBAction func scClicked(_ sender: Any) {
        lblSistolic.text = String(measurement[scMeasure.selectedSegmentIndex].systolic)
        lblDistolic.text = String(measurement[scMeasure.selectedSegmentIndex].diastolic)
        lblWeight.text = String(self.weight)
        lblNotes.text = String(self.notes);
    }
    

}
