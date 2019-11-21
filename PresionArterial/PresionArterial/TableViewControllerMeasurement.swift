//
//  TableViewControllerMeasurement.swift
//  PresionArterial
//
//  Created by Juan Pablo on 10/12/19.
//  Copyright © 2019 Gustavo Paez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class TableViewControllerMeasurement: UITableViewController,MeasurementRegister {
    var email : String!
    var measurementList = [Measurements]()
    var formatter = DateFormatter()
    var handle: AuthStateDidChangeListenerHandle?
    //let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let userEmail = defaults.value(forKey: "email") as? String
        self.title = "Mediciones Pasadas"
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        // [START setup]
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        // [END setup]
       
        if Auth.auth().currentUser != nil {
                // User is signed in.
                let user = Auth.auth().currentUser
                if let user = user {
                    // The user's ID, unique to the Firebase project.
                    // Do NOT use this value to authenticate with your backend server,
                    // if you have one. Use getTokenWithCompletion:completion: instead.
                    email = user.email
                    print("Logged in!")
                }
            } else {
                // No user is signed in.
                // ...
                print("Not logged in!")
            }
           
            getBloodPressure()
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
                //getUserInfo()
                //getBloodPressure()
                print("Logged in!")
            }
        } else {
            // No user is signed in.
            // ...
            print("Not logged in!")
        }
    }
    
    func getBloodPressure(){
        let db = Firestore.firestore();
            // [START get_multiple_all]
        db.collection("users").document(email)
            .collection("bloodPressure").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let docInfo = document.data();
                        let measure = docInfo["measurements"] as! [String: AnyObject];
                        var measured = measure["measure1"] as! [String: AnyObject];
                        var measureArray = [Measurement]()
                        measureArray.append(Measurement(systolic: measured["systolic"] as! Int, diastolic:measured["diastolic"] as! Int));
                        measured = measure["measure2"] as! [String : AnyObject];
                        measureArray.append(Measurement(systolic: measured["systolic"] as! Int, diastolic:measured["diastolic"] as! Int));
                        measured = measure["measure3"] as! [String: AnyObject];
                        measureArray.append(Measurement(systolic: measured["systolic"] as! Int, diastolic:measured["diastolic"] as! Int));
                       let date = docInfo["createdAt"] as! Timestamp;
                       let measurements =  Measurements(measures:measureArray,
                                                        date:date.dateValue(),
                                                        weight:docInfo["weight"] as! Double,
                                                        notes:docInfo["notes"] as! String)
                        self.measurementList.append(measurements)
                        self.tableView.reloadData()
                    }
                }
            }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // to do manipulate user
        super.viewWillAppear(animated)

        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            
            self.tableView.reloadData()
            //let user = Auth.auth().currentUser
        }
    }
        // [END auth_
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return measurementList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "measureCell", for: indexPath)
        cell.textLabel?.text = String(measurementList[indexPath.row].measures[0].systolic) + "/" + String(measurementList[indexPath.row].measures[0].diastolic)
        cell.detailTextLabel?.text = formatter.string(from:measurementList[indexPath.row].date)
        return cell
    }
    

    func addMeasure(measure: [Measurement],weight:Double,notes:String) {
        // To do add to database
        let newMeasures = Measurements(measures:measure,date:Date(),weight:weight,notes:notes)
        measurementList.append(newMeasures)
        tableView.reloadData()
        self.uploadMeasure(measures:newMeasures);
    }


    func uploadMeasure(measures:Measurements){
        
        formatter.dateFormat = "MMMM d, yyyy HH:mm:ss"
        let createdAtTime: Date = formatter.date(from: formatter.string(from:measures.date)) ?? Date(timeIntervalSince1970: 0)
        let createdAt: Timestamp = Timestamp(date: createdAtTime)
        self.formatter.dateFormat = "yyyy/MM/dd HH:mm"
        let db = Firestore.firestore();
        db.collection("users").document(email)
            .collection("bloodPressure").addDocument(data:[
            "createdAt": createdAt,
            "measurements": [
                "measure1": [
                    "diastolic": measures.measures[0].diastolic,
                    "systolic": measures.measures[0].systolic
                ],
                "measure2":[
                    "diastolic": measures.measures[1].diastolic,
                    "systolic": measures.measures[1].systolic
                ],
                "measure3":[
                    "diastolic": measures.measures[2].diastolic,
                    "systolic":  measures.measures[2].systolic
                ]
                
                ],
                 "notes": measures.notes!,
                 "weight": measures.weight,
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "addMeasure"{
            let vistaSig = segue.destination as! ViewControllerAddMeasure
            vistaSig.delegate = self;
        }else{
            let indice = tableView.indexPathForSelectedRow!
            let vistaSig = segue.destination as!  ViewControllerInfoMeasurement
            vistaSig.measurement = measurementList[indice.row].measures
            vistaSig.weight = measurementList[indice.row].weight;
            vistaSig.notes = measurementList[indice.row].notes;
        }
    }
 

}
