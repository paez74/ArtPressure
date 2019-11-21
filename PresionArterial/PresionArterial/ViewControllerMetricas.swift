//
//  ViewControllerMetricas.swift
//  PresionArterial
//
//  Created by Antonio Alemán  on 11/19/19.
//  Copyright © 2019 Gustavo Paez. All rights reserved.
//

import UIKit
import Charts
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class ChartXAxisFormatter: NSObject {
    var formatter: DateFormatter?
    var referenceTimeInterval: TimeInterval?
    
    convenience init(referenceTimeInterval: TimeInterval, formatter: DateFormatter){
        self.init()
        self.referenceTimeInterval = referenceTimeInterval
        self.formatter = formatter
    }
}

extension ChartXAxisFormatter: IAxisValueFormatter{
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        guard let formatter = formatter, let referenceTimeInterval = referenceTimeInterval
            else {
                return ""
        }
        
        let date = Date(timeIntervalSince1970: value * 3600 * 24 + referenceTimeInterval)
        return formatter.string(from: date)
    }
    
    
}

class ViewControllerMetricas: UIViewController,ChartViewDelegate{

    
    
    
    @IBOutlet weak var chtCombined: CombinedChartView!
    
   
  
    //@IBOutlet weak var chtCombined: CombinedChartView!
    var email:String!
    var dateArray = [Int]()
    var measurementList = [Measurements]()
    var dicMeasurement = [Int: [Measurements]]()
    var presionSistolica = [Double]()
    var presionDiastolica = [Double]()
    //var presionSistolica = [120, 140, 110, 115, 120, 140, 110]
    //var presionDiastolica = [78, 73, 81, 90, 78, 73, 81]
    //var pulso = [70, 100, 140, 120, 70, 100, 85]
    var pulso = [Double]()
    //var measurementList = [Measurements]()
    var fechas = [Date]()
    var valX = [Int]()
    var handle: AuthStateDidChangeListenerHandle?
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        
        //getBloodPressure()
        
        //print(measurementList.count)
        //print(measurementList[0].measures[0].diastolic)
        //print("El resultado es: ", measuresAverage(measurements: measurementList[0], value: 0))
        //var ref:FIRDatabase
        
        // Do any additional setup after loading the view.
        /*let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        fechas = [formatter.date(from: "2019/10/10 00:00")!, formatter.date(from: "2019/10/13 00:00")!, formatter.date(from: "2019/10/16 00:00")!, formatter.date(from: "2019/10/20 00:00")!, formatter.date(from: "2019/10/23 14:00")!, formatter.date(from: "2019/10/24 14:02")!, formatter.date(from: "2019/10/25 14:05")!]
        
        for i in fechas{
            valX.append(Int(i.timeIntervalSince1970 / (3600 * 24)))
            
        }
        
        for i in valX{
            //print(i)
        }*/
        
        
        /*let chartView = CombinedChartView()
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.drawLabelsEnabled = true
        xAxis.drawLimitLinesBehindDataEnabled = true
        xAxis.avoidFirstLastClippingEnabled = true
        let xValuesNumberFormatter = ChartXAxisFormatter()
       let dateFormat = DateFormatter()
        dateFormat.date(from: <#T##String#>)
        xValuesNumberFormatter.formatter = "MM/dd"
        xAxis.valueFormatter = xValuesNumberFormatter*/
        chtCombined.delegate = self
        //print(self.measurementList.count)
        //updateCombinedGraph()
        
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
    
    func getBloodPressure(email: String) -> [Measurements]{
        measurementList = []
        dicMeasurement = [Int: [Measurements]]()
        //var listaDate = [Int]
        let db = Firestore.firestore();
            // [START get_multiple_all]
        var listaMeasures = [Measurements]()
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
                        let dateEntero = Int((measurements.date.timeIntervalSince1970 - 21600)/(3600*24))
                        
                        if self.dicMeasurement[dateEntero] == nil{
                            self.dicMeasurement[dateEntero] = []
                            self.dateArray.append(dateEntero)
                        }
                        self.dicMeasurement[dateEntero]!.append(measurements)
                        //print(measurements.date.timeIntervalSince1970/(3600*24))
                        
                        //self.tableView.reloadData()
                    }
                }
                
                listaMeasures = self.measurementList.sorted(by: { $0.date < $1.date })
                var listaDate = self.dateArray.sorted()
                self.measurementList = listaMeasures
                self.dateArray = listaDate
                self.updateCombinedGraph()
            }
        return listaMeasures
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // to do manipulate user
        super.viewWillAppear(animated)

        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            
            //self.tableView.reloadData()
            //let user = Auth.auth().currentUser
        }
        getCurrentUser()
        getBloodPressure(email: email)
        chtCombined.resetZoom()
        chtCombined.zoomToCenter(scaleX: 0, scaleY: 0)
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {

       
        let pos = NSInteger(entry.x)
        //let highlighter2: Highlight = Highlight(x: Double(pos), dataSetIndex: 0, stackIndex: 1)
        var n = 0
        /*for i in valX{
            if pos == i{
                print(presionDiastolica[n])
                //chtCombined.barData?.highlightValue(highlighter2)
                //chtCombined.highlightValue(x: Double(pos), y: Double(presionDiastolica[n]), dataIndex: 1, dataSetIndex: 0, stackIndex: 1)
        
            }
            n += 1
        }*/
    }

    func chartValueNothingSelected(_ chartView: ChartViewBase)
    {
        print("funciona")
    }
    
    func updateCombinedGraph(){
        let referenceTimeInterval: TimeInterval = 6 * 3600
        
        let newFormatter = DateFormatter()
        //newFormatter.dateStyle = .short
        //newFormatter.timeStyle = .none
        newFormatter.dateFormat = "MMM dd"
        newFormatter.locale = Locale.current
        let xValuesNumberFormatter = ChartXAxisFormatter(referenceTimeInterval: referenceTimeInterval, formatter: newFormatter)
        
        //let chartView = chtCombined
        let xAxis = chtCombined.xAxis
        //xAxis.labelPosition = .bottom
        //xAxis.drawLabelsEnabled = true
        //xAxis.drawLimitLinesBehindDataEnabled = true
        //xAxis.avoidFirstLastClippingEnabled = true
        xAxis.valueFormatter = xValuesNumberFormatter
        //chtCombined.xAxis = xAxis
        //chtCombined.c
        
        let combinedData = CombinedChartData()
        combinedData.barData = updateBarGraph()
        combinedData.lineData = updateLineGraph()
        chtCombined.data = combinedData
        chtCombined.rightAxis.enabled = false
        chtCombined.leftAxis.axisMinimum = 30
        chtCombined.leftAxis.axisMaximum = 200
        //chtCombined.pinchZoomEnabled = true
        //chtCombined.xAxis.drawGridLinesEnabled = false
        chtCombined.backgroundColor = NSUIColor.white
        //chtCombined.setVisibleXRangeMaximum(14)
        //chtCombined.legend.
        //chtCombined.moveViewToX(1000000)
        chtCombined.xAxis.granularity = 1
       //chtCombined.clipsToBounds = false
        chtCombined.animate(xAxisDuration: 1.0, yAxisDuration: 2.0, easingOption: .easeOutBack)
        
        
        
    }
    
    func measuresAverage(measurements: [Measurements], value: Int) -> Double{
        var suma:Double
        var resultado: Double
        var n:Double
        suma = 0
        resultado = 0
        n = 0
        for j in measurements{
        for i in j.measures{
            if value==0{
                suma+=Double(i.diastolic)
            }
            else if value==1{
                suma+=Double(i.systolic)
            }
            n+=1
        }
        }
        resultado = suma/n
        //print(resultado)
        return (resultado)
    }
    
    func updateBarGraph() -> BarChartData{
        var barChartData = [BarChartDataEntry]()
        //var i = 0
        for i in dateArray{
            
            //print(measurementList[i].date.timeIntervalSince1970/(3600*24))
            //var fechaEntero = Int((measurementList[i].date.timeIntervalSince1970 - 21600)/(3600*24))
            var fechaDouble = Double(i)
            //print(fechaEntero)
            //print(fechaDouble)
            print(i)
            print(measuresAverage(measurements: dicMeasurement[i]!, value: 0))
            print(measuresAverage(measurements: dicMeasurement[i]!, value: 1))
            print(measuresAverage(measurements: dicMeasurement[i]!, value: 1) - measuresAverage(measurements: dicMeasurement[i]!, value: 0))
            let value = BarChartDataEntry(x: fechaDouble, yValues: [measuresAverage(measurements: dicMeasurement[i]!, value: 0), measuresAverage(measurements: dicMeasurement[i]!, value: 1) - measuresAverage(measurements: dicMeasurement[i]!, value: 0)])
            //print(fechas[i].timeIntervalSince1970)
            //print(fechas[i].timeIntervalSince1970)
            
            barChartData.append(value)
            
            
        }
        /*while i < measurementList.count{
            print(measurementList[i].date.timeIntervalSince1970/(3600*24))
            var fechaEntero = Int((measurementList[i].date.timeIntervalSince1970 - 21600)/(3600*24))
            var fechaDouble = Double(fechaEntero)
            print(fechaEntero)
            print(fechaDouble)
            let value = BarChartDataEntry(x: fechaDouble, yValues: [measuresAverage(measurements: measurementList[i], value: 0), measuresAverage(measurements: measurementList[i], value: 1) - measuresAverage(measurements: measurementList[i], value: 0)])
            //print(fechas[i].timeIntervalSince1970)
            //print(fechas[i].timeIntervalSince1970)
            barChartData.append(value)
            
            i+=1
        }*/
        let barra = BarChartDataSet(entries: barChartData, label: "Presion")
        barra.colors = [NSUIColor.clear, NSUIColor.green]
        
        //barra.highlightEnabled = false
        let data = BarChartData()
        data.addDataSet(barra)
        data.setDrawValues(false)
        return data
        /*chtBar.data = data
        let combinedData = CombinedChartData()
        combinedData.barData = data
        chtCombined.data = combinedData*/
        
    }
    
    func updateLineGraph() -> LineChartData{
        var lineData = [ChartDataEntry]()
        for i in dateArray{
           //var fechaEntero = Int((measurementList[i].date.timeIntervalSince1970 - 21600)/(3600*24))
            var fechaDouble = Double(i)
            let value = ChartDataEntry(x: fechaDouble, y: measuresAverage(measurements: dicMeasurement[i]!, value: 1) - measuresAverage(measurements: dicMeasurement[i]!, value: 0))
            lineData.append(value)
          
        }
        /*var i = 0
        while i < measurementList.count{
            //print(measurementList[i].weight)
            //print(measuresAverage(measurements: measurementList[i], value: 1))
            //print(measuresAverage(measurements: measurementList[i], value: 0))
            //print(measuresAverage(measurements: measurementList[i], value: 1) - measuresAverage(measurements: measurementList[i], value: 0))
           var fechaEntero = Int((measurementList[i].date.timeIntervalSince1970 - 21600)/(3600*24))
            var fechaDouble = Double(fechaEntero)
            let value = ChartDataEntry(x: fechaDouble, y: measuresAverage(measurements: measurementList[i], value: 1) - measuresAverage(measurements: measurementList[i], value: 0))
            lineData.append(value)
            i+=1
        }*/
        let linea = LineChartDataSet(entries: lineData, label: "Pulso")
        linea.circleColors  = [NSUIColor.orange]
        linea.colors = [NSUIColor.orange]
        linea.highlightEnabled = false
        let data = LineChartData()
        data.addDataSet(linea)
        //data.setDrawValues(false)
        return data
    }
    
    func updateGraph(){
        
        var barChartData = [BarChartDataEntry]()
        
        let value = BarChartDataEntry(x: 20, y: 5)
        //value = BarChartDataEntry(
        barChartData.append(value)
        
        let bar1 = BarChartDataSet(entries: barChartData, label: "Prueba")
        
        let data = BarChartData()
        
        data.addDataSet(bar1)
        
        let combinedData = CombinedChartData()
        
        combinedData.barData = data
        
        //chtBar.data = data
        
        chtCombined.data = data
        
    }

}
