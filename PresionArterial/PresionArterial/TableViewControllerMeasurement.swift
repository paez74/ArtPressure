//
//  TableViewControllerMeasurement.swift
//  PresionArterial
//
//  Created by Juan Pablo on 10/12/19.
//  Copyright © 2019 Gustavo Paez. All rights reserved.
//

import UIKit

class TableViewControllerMeasurement: UITableViewController,MeasurementRegister {
    
    var measurementList = [Measurements]()
    var formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Mediciones Pasadas"
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        var measureArray = [Measurement]()
        var dummyMeasure = Measurement(weight: 75, systolicP: 35, diastolicP: 100, date: formatter.date(from: "2019/10/08 22:31")!)
        measureArray.append(dummyMeasure)
        dummyMeasure = Measurement(weight: 76, systolicP: 40, diastolicP: 100, date: formatter.date(from: "2019/10/08 22:31")!)
        measureArray.append(dummyMeasure)
        dummyMeasure = Measurement(weight: 80, systolicP: 25, diastolicP: 100, date: formatter.date(from: "2019/10/08 22:31")!)
        measureArray.append(dummyMeasure)
        var measuresTest = Measurements(measures:measureArray,date:dummyMeasure.date)
        measurementList.append(measuresTest)
        dummyMeasure = Measurement(weight: 73.5, systolicP: 46, diastolicP: 120, date: formatter.date(from: "2019/10/07 22:31")!)
        measureArray[0] = dummyMeasure;
        dummyMeasure = Measurement(weight: 78, systolicP:  35, diastolicP: 120, date: formatter.date(from: "2019/10/07 22:31")!)
        measureArray[1] = dummyMeasure;
        dummyMeasure = Measurement(weight: 79, systolicP: 56, diastolicP: 120, date: formatter.date(from: "2019/10/07 22:31")!)
        measureArray[2] = dummyMeasure;
        measuresTest = Measurements(measures:measureArray,date:dummyMeasure.date)
        measurementList.append(measuresTest)
        dummyMeasure = Measurement(weight: 72.8, systolicP: 50, diastolicP: 100, date: formatter.date(from: "2019/10/06 22:31")!)
        measureArray[0] = dummyMeasure;
        dummyMeasure = Measurement(weight: 102, systolicP: 40, diastolicP: 100, date: formatter.date(from: "2019/10/06 22:31")!)
        measureArray[1] = dummyMeasure;
        dummyMeasure = Measurement(weight: 72.8, systolicP: 33, diastolicP: 100, date: formatter.date(from: "2019/10/06 22:31")!)
        measureArray[2] = dummyMeasure;
        measuresTest = Measurements(measures:measureArray,date:dummyMeasure.date)
        measurementList.append(measuresTest)
        formatter.dateFormat = "dd-MM-yy"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return measurementList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "measureCell", for: indexPath)
        cell.textLabel?.text = String(measurementList[indexPath.row].measures[0].systolicP) + "/" + String(measurementList[indexPath.row].measures[0].diastolicP)
        cell.detailTextLabel?.text = formatter.string(from:measurementList[indexPath.row].measures[0].date)
        return cell
    }
    

    func addMeasure(measure: [Measurement]) {
        // To do add to database
        let newMeasures = Measurements(measures:measure,date:measure[0].date)
        measurementList.append(newMeasures)
        tableView.reloadData()
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
        }
    }
 

}
