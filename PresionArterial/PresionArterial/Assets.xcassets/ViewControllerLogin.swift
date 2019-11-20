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
    var loggedIn : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    func login() {
        let email = tfEmail.text!
        let password = tfPass.text!
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            // [START_EXCLUDE]

                if let error = error {
                    let alert = UIAlertController(title: "Error", message: "Password o email incorrectos.", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    
                    strongSelf.present(alert, animated: true)
                    strongSelf.loggedIn = false
                    return
                } else {
                    strongSelf.loggedIn = true
            }
            // [END_EXCLUDE]
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "login" {
            login()
            return loggedIn
        }else{
            return true
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
