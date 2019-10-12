//
//  ViewControllerRegistro.swift
//  PresionArterial
//
//  Created by Juan Pablo on 10/11/19.
//  Copyright © 2019 Gustavo Paez. All rights reserved.
//

import UIKit
protocol UserRegister{
    func addUser(user:Usuario)-> Void
}
class ViewControllerRegistro: UIViewController {

    @IBOutlet var tfName: UITextField!
    @IBOutlet var tfEmail: UITextField!
    @IBOutlet var tfUsername: UITextField!
    @IBOutlet var tfPassword: UITextField!
    @IBOutlet var tfPasswordRepeat: UITextField!
    @IBOutlet var btnRegistrarse: UIButton!
    @IBOutlet var dpBirthday: UIDatePicker!
    var delegate:UserRegister!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (sender as! UIButton) == btnRegistrarse{
            if validateData(){
                addUser()
                return true
            }
            else { return false}
        }
        else {return true}
    }
    func addUser(){
        let name = tfName.text!
        let email = tfEmail.text!
        let username = tfUsername.text!
        let password = tfPassword.text!
        let birthday = dpBirthday.date
        let user = Usuario(name:name,email:email,username:username,bday:birthday)
        delegate.addUser(user:user);
    }
    func validateData() -> Bool{
      if tfName.text! == "" ||
         tfEmail.text! == "" ||
         tfUsername.text! == "" ||
         tfPassword.text! == "" ||
         tfPasswordRepeat.text! == ""
        {
            let alerta = UIAlertController(title:"Error",message:"Todos los campos deben tener datos",preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title:"OK",style: .cancel, handler:nil))
            present(alerta,animated:true,completion:nil)
            return false
        }
      else if tfPassword.text != tfPasswordRepeat.text{
        let alerta = UIAlertController(title:"Error",message:"Las contraseñas no coinciden",preferredStyle: .alert)
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
