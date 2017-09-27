//
//  Functions.swift
//  Bitcoin+
//
//  Created by Everton Carneiro on 27/09/17.
//  Copyright © 2017 Everton. All rights reserved.
//

import Foundation


struct Functions {
    
    static func formatToCurrency(symbol: String, number: String) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.currency
        numberFormatter.currencySymbol = symbol + " "
        if let number2 = Double(number){
            return numberFormatter.string(from: NSNumber(value: number2))!
        }
        return number
    }
    
    static func castToDouble(value: String) -> Double{
        var value = value
        value.insert(".", at: value.index(value.endIndex, offsetBy: -2))
        let valueDbl = Double(value)!
        return valueDbl
    }
    
    
}

