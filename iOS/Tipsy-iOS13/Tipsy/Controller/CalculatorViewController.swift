//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
  
  @IBOutlet weak var billTextField: UITextField!
  @IBOutlet weak var zeroPctButton: UIButton!
  @IBOutlet weak var tenPctButton: UIButton!
  @IBOutlet weak var twentyPctButton: UIButton!
  @IBOutlet weak var splitNumberLabel: UILabel!
  
  var tipPct = 0.10
  var peopleToSplit = 2
  var billAmountString: String?
  var billAmount: Double?
  var splitBillAmount = "Error calculating split bill"
  
  @IBAction func tipChanged(_ sender: UIButton) {
    billTextField.endEditing(true)
    
    resetTipSelections()
    sender.isSelected = true
    
    var buttonTitle = sender.currentTitle!
    buttonTitle.removeLast()
    tipPct = Double(buttonTitle)! / Double(100)
    
    print(tipPct)
  }
  
  @IBAction func stepperValueChanged(_ sender: UIStepper) {
    peopleToSplit = Int(sender.value)
    splitNumberLabel.text = String(format: "%d", peopleToSplit)
  }
  
  @IBAction func calculatePressed(_ sender: UIButton) {
    if let safeBillAmountString = billTextField.text {
      billAmountString = safeBillAmountString
      billAmount = Double(billAmountString!)
    }
    
    splitBillAmount = calculateSplitBill(billBeforeTip: billAmount ?? 0.0, tipPct: tipPct, peopleSplit: peopleToSplit)
    
    performSegue(withIdentifier: "goToResult", sender: self)
  }
  
  func resetTipSelections() {
    zeroPctButton.isSelected = false
    tenPctButton.isSelected = false
    twentyPctButton.isSelected = false
  }
  
  func calculateSplitBill(billBeforeTip: Double, tipPct: Double, peopleSplit: Int) -> String {
    
    let rawTipNum = (billBeforeTip * (1 + tipPct)) / Double(peopleSplit)
    let tipString = String(format: "%.2f", rawTipNum)
    
    return tipString
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier == "goToResult") {
      let destinationVC = segue.destination as! ResultsViewController
      destinationVC.splitBillResult = splitBillAmount
      destinationVC.numPeople = peopleToSplit
      destinationVC.pct = tipPct
    }
  }
}

