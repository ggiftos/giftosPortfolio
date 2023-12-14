//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Grant Giftos on 5/9/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
  let currencyType: String
  let coinRate: Double
  
  var coinRateString: String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 2
    return formatter.string(from: coinRate as NSNumber) ?? "Error"
  }
}
