//
//  CoinData.swift
//  ByteCoin
//
//  Created by Cáren Sousa on 28/09/22.
//

import Foundation


struct CoinData: Codable {
    let rates: Rates
}

struct Rates: Codable {
    let rate: Double
}


