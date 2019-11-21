//
//  ViewControllerAddMeasure.swift
//  PresionArterial
//
//  Created by Juan Pablo on 10/12/19.
//  Copyright © 2019 Gustavo Paez. All rights reserved.
//

import UIKit
protocol MeasurementRegister{
    func addMeasure(measure:[Measurement],weight:Double,notes:String) -> Void
}
class ViewControllerAddMeasure: UIViewController {
    @IBOutlet var tfSystolic: UITextField!
    @IBOutlet var tfDistolic: UITextField!
    @IBOutlet var tfWeight: UITextField!
    @IBOutlet var tvNotes: UITextView!
    @IBOutlet var lblTimer: UILabel!
    @IBOutlet var createButton: UIButton!
    var counter = 0
    var pressionTaken = 3
    var timer = Timer()
    var measurements = [Measurement]()
    var delegate:MeasurementRegister!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTimer.text = "Solo  " + "\(pressionTaken) mas";
        // Do any additional setup after loading the view.
    }
    

    @IBAction func addMeasurement(_ sender: Any) {
        if validateData(){
        timer.invalidate() // just in case this button is tapped multiple times
            let measurement = Measurement( systolic: Int(tfSystolic.text!)!, diastolic: Int(tfDistolic.text!)!)
        measurements.append(measurement);
        
        tfSystolic.text = ""
        tfDistolic.text = ""
        
        // start the timer
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            pressionTaken -= 1;
            createButton.isEnabled = false;
            tfWeight.isEnabled = false;
        if pressionTaken == 0 {
            delegate.addMeasure(measure: measurements,weight:Double(tfWeight.text!) as! Double,notes:tvNotes.text!)
            navigationController?.popViewController(animated: true)
        }
        }
    }
    
    // called every time interval from the timer
    @objc func timerAction() {
        counter += 1
        lblTimer.text = "   " +  "\(counter)"
        if counter == 10 {
            counter = 0;
            lblTimer.text = "Solo " + "\(pressionTaken) mas";
            timer.invalidate()
            createButton.isEnabled = true;
        }
    }
    
    func validateData() -> Bool{
        if tfSystolic.text! == "" ||
            tfDistolic.text! == "" ||
            tfWeight.text! == ""
        {
            let alerta = UIAlertController(title:"Error",message:"Todos los campos deben tener datos",preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title:"OK",style: .cancel, handler:nil))
            present(alerta,animated:true,completion:nil)
            return false
        }
        else {
            var intSys = Int(tfSystolic.text!)!
            var intDis = Int(tfDistolic.text!)!
            if  intSys < intDis{
              let alerta = UIAlertController(title:"Error",message:"Presión sistolica no puede ser menor que la diastólica",preferredStyle: .alert)
              alerta.addAction(UIAlertAction(title:"OK",style: .cancel, handler:nil))
              present(alerta,animated:true,completion:nil)
       
            return false
            }
        }
        return true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
