//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Grant Giftos on 2/1/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit

struct CalculatorBrain {
  
  var bmi: BMI?
  let color = (underweight: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), healthy: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), overweight: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
  
  mutating func calculateBMI(height: Float, weight: Float) {
    let bmiValue = weight / pow(height, 2)
    
    if(bmiValue < 18.5) {
      bmi = BMI(value: bmiValue, advice: "Eat more pies", color: color.underweight)
    } else if(bmiValue < 24.9) {
      bmi = BMI(value: bmiValue, advice: "Fit as a fiddle!", color: color.healthy)
    } else {
      bmi = BMI(value: bmiValue, advice: "Eat less pies", color: color.overweight)
    }
    
  }
  
  func getBMIValue() -> String {
    return String(format: "%.1f", bmi?.value ?? 0.0)
  }
  
  func getAdvice() -> String {
    return bmi?.advice ?? "No advice"
  }
  
  func getColor() -> UIColor {
    return bmi?.color ?? UIColor.white
  }
}
