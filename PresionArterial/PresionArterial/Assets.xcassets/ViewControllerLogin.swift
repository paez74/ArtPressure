//
//  ViewControllerLogin.swift
//  PresionArterial
//
//  Created by Juan Pablo on 10/11/19.
//  Copyright © 2019 Gustavo Paez. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewControllerLogin: UIViewController ,UserRegister{

    @IBOutlet weak var tfEmail: UITextField!
    
    @IBOutlet weak var tfPass: UITextField!
    
    /*@IBAction func actBtLogin(_ sender: UIButton) {
        login(email:tfEmail.text!, password: tfPass.text!)
    }*/
    @IBAction func btnLogin(_ sender: UIButton) {
        login(email:tfEmail.text!, password: tfPass.text!)
    }
    
    let defauls = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    @IBAction func unwindRegistro(unwindSegue: UIStoryboardSegue){
        
    }
    
    @IBAction func unwindApplication(unwindSegue: UIStoryboardSegue){
        
    }
    
    
    func addUser(user:Usuario)-> Void{
        // Function add user to db
        print(user.name!)
        print(user.username!)
        print(user.bday!)
        print(user.email!)
    }
    
    func doSegue(){
           performSegue(withIdentifier: "login", sender: nil)
       }
    
    
    func login(email:String, password:String) {
    
    
    Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
        guard let strongSelf = self else { return }
        // [START_EXCLUDE]

            if let error = error {
                let alert = UIAlertController(title: "Error", message: "Password o email incorrectos.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                strongSelf.present(alert, animated: true)
                //strongSelf.loggedIn = false
                return
            } else {
                //strongSelf.personaAuth.correo = withEmail
                //strongSelf.personaAuth.contrasena = password
                //strongSelf.guardarAutentificacion()
                
                //strongSelf.loggedIn = true
                strongSelf.defauls.set(email, forKey: "email")
                strongSelf.doSegue()
                //prepare(for: vcLogin, sender: self)
                
                //return true
                
        }
        // [END_EXCLUDE]
        
    }
    }
        
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "register"{
            let vistaSig = segue.destination as! ViewControllerRegistro
            vistaSig.delegate = self;
        }else{
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd HH:mm"
            let vistaTab = segue.destination as! UITabBarController;
            let vistaSig = vistaTab.viewControllers![0] as! ViewControllerInfo;
            // To do get user from database, and check password
            vistaSig.user = Usuario(name:"Gustavo Paez",email:"paez74@live.com.mx",username:"paez74",bday:formatter.date(from: "1997/10/08 22:31")!)
        }
    }
 

}
