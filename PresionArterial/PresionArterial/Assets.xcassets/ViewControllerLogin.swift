//
//  ViewControllerLogin.swift
//  PresionArterial
//
//  Created by Juan Pablo on 10/11/19.
//  Copyright © 2019 Gustavo Paez. All rights reserved.
//

import UIKit

class ViewControllerLogin: UIViewController ,UserRegister{

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
