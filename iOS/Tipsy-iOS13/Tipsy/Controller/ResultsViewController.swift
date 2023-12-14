//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by Grant Giftos on 2/3/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
  
  var splitBillResult: String?
  var numPeople: Int?
  var pct: Double?
  
  @IBOutlet weak var totalLabel: UILabel!
  @IBOutlet weak var settingsLabel: UILabel!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let pctString = String(format: "%.0f", pct! * 100)
    
    totalLabel.text = splitBillResult
    settingsLabel.text = "Split between \(numPeople!), with \(pctString)% tip."
  }
  
  @IBAction func recalculatePressed(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
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
