//
//  ViewControllerRegistro.swift
//  PresionArterial
//
//  Created by Juan Pablo on 10/11/19.
//  Copyright © 2019 Gustavo Paez. All rights reserved.
//

import UIKit
import FirebaseAuth
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

    var name : String!
    var lastname : String!
    var email : String!
    var password : String!
    var birthday : Date!
    var userCreated : Bool = false
    var delegate:UserRegister!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func createUser(){
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            // [START_EXCLUDE]
            guard let user = authResult?.user, error == nil else {
                self.userCreated = false
                let alerta = UIAlertController(title:"Error",message: error!.localizedDescription ,preferredStyle: .alert)
                alerta.addAction(UIAlertAction(title:"OK",style: .cancel, handler:nil))
                self.present(alerta,animated:true,completion:nil)
                return
            }
            print("\(user.email!) created")
           self.userCreated = true
           self.navigationController?.popViewController(animated: true)
            // [END_EXCLUDE]
        }
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (sender as! UIButton) == btnRegistrarse{
            if validateData(){
                addUser()
                return userCreated
            }
            else { return false}
        }
        else {return true}
    }

    func addUser(){
        name = tfName.text!
        email = tfEmail.text!
        password = tfPassword.text!
        birthday = dpBirthday.date
        createUser()
    }
    func validateData() -> Bool{
      if tfName.text! == "" ||
         tfEmail.text! == "" ||
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
