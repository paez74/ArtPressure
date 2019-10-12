//
//  ViewControllerAddMeasure.swift
//  PresionArterial
//
//  Created by Juan Pablo on 10/12/19.
//  Copyright © 2019 Gustavo Paez. All rights reserved.
//

import UIKit
protocol MeasurementRegister{
   func addMeasure(measure:Measurement) -> Void
}
class ViewControllerAddMeasure: UIViewController {
    @IBOutlet var tfSystolic: UITextField!
    @IBOutlet var tfDistolic: UITextField!
    @IBOutlet var tfWeight: UITextField!
    @IBOutlet var tvNotes: UITextView!
    
    var delegate:MeasurementRegister!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addMeasurement(_ sender: Any) {
        if validateData(){
            let measurement = Measurement(weight: Double(tfWeight.text!)!, systolicP: Int(tfSystolic.text!)!, diastolicP: Int(tfDistolic.text!)!, date: Date())
            delegate.addMeasure(measure: measurement)
            navigationController?.popViewController(animated: true)
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
