//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
  func didUpdateCoin(_ coinManager: CoinManager, coin: CoinModel)
  func didFailWithError(error: Error)
}

struct CoinManager {
  
  var delegate: CoinManagerDelegate?
  
  let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
  let apiKey = "YOUR_API_KEY_HERE"
  
  let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
  
  func getCoinPrice(for currency: String) {
    let urlString = "\(baseURL)/\(currency)?apikey=B5980D9B-100E-4672-A7DE-5C3266769F1F"
    performRequest(with: urlString)
  }
  
  func performRequest(with urlString: String) {
    if let url = URL(string: urlString) {
      let session = URLSession(configuration: .default)
      let task = session.dataTask(with: url) { (data, response, error) in
        if (error != nil) {
          delegate?.didFailWithError(error: error!)
          return
        }
        
        if let safeData = data {
          if let coin = parseJSON(safeData) {
            delegate?.didUpdateCoin(self, coin: coin)
          }
        }
      }
      
      task.resume()
    }
  }
  
  func parseJSON(_ coinData: Data) -> CoinModel? {
    let decoder = JSONDecoder()
    do {
      let decodedData = try decoder.decode(CoinData.self, from: coinData)
      let currency = decodedData.asset_id_quote
      let rate = decodedData.rate
      
      let coin = CoinModel(currencyType: currency, coinRate: rate)
      
      return coin
      
    } catch {
      print(error)
      return nil
    }
  }
}
