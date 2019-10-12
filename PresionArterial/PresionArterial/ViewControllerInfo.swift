//
//  ViewControllerInfo.swift
//  PresionArterial
//
//  Created by Juan Pablo on 10/12/19.
//  Copyright © 2019 Gustavo Paez. All rights reserved.
//

import UIKit

class ViewControllerInfo: UIViewController {
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblAge: UILabel!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var lblSystolic: UILabel!
    @IBOutlet var lblDistolic: UILabel!
    @IBOutlet var lblWeight: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblNotes: UILabel!
    var user:Usuario!
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Todays Date
        let now = Date()
        /// Calender
        let calendar = Calendar.current
        let age = calendar.dateComponents([.year], from:user.bday, to: now)
        lblName.text = user.name!
        lblAge.text = String(age.year!) + "años"
        
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
