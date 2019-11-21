//
//  ViewControllerInfo.swift
//  PresionArterial
//
//  Created by Juan Pablo on 10/12/19.
//  Copyright © 2019 Gustavo Paez. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ViewControllerInfo: UIViewController {
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblAge: UILabel!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var lblSystolic: UILabel!
    @IBOutlet var lblDistolic: UILabel!
    @IBOutlet var lblWeight: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblNotes: UILabel!
    var handle: AuthStateDidChangeListenerHandle?
    var user:Usuario!
    var email : String! = ""
    var name : String! = ""
    var last_name : String! = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        lblAge.text = "años"
        getCurrentUser()

    }
    
    func getUserInfo(){
        let db = Firestore.firestore();
        // [START get_multiple_all]
        let docRef = db.collection("users").document(email)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                let name = document.get("name") as! String
                let last_name = document.get("last_name") as! String
                self.lblName.text = name + " " + last_name
                /// Todays Date
                let now = Date()
                /// Calender
                let calendar = Calendar.current
                let bday = document.get("birthday") as! [String: AnyObject];
                let day = bday["day"] as! String
                let month = bday["month"] as! String
                let year = bday["year"] as! String
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy/MM/dd"
                let bday2 = formatter.date(from: year + "/" + month + "/" + day)!
                let age = calendar.dateComponents([.year], from:bday2, to: now)
                self.lblAge.text = String(age.year!) + " años"
            } else {
                print("Document does not exist")
            }
        }
    }

    
    func getCurrentUser() {
        // [START auth_listener]
        if Auth.auth().currentUser != nil {
            // User is signed in.
            let user = Auth.auth().currentUser
            if let user = user {
                // The user's ID, unique to the Firebase project.
                // Do NOT use this value to authenticate with your backend server,
                // if you have one. Use getTokenWithCompletion:completion: instead.
                email = user.email
                getUserInfo()
                print("Logged in!")
            }
        } else {
            // No user is signed in.
            // ...
            print("Not logged in!")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // [START remove_auth_listener]
        // [END remove_auth_listener]
    }

}
