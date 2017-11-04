//
//  Functions.swift
//  Bitcoin+
//
//  Created by Everton Carneiro on 27/09/17.
//  Copyright © 2017 Everton. All rights reserved.
//

import Foundation
import UIKit


struct Functions {
    
    static func formatToCurrency(number: String, withSymbol symbol: String) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.currency
        numberFormatter.currencySymbol = symbol
        if let number2 = Double(number){
            return numberFormatter.string(from: NSNumber(value: number2))!
        }
        return number
    }
    
    static func formatter(number: String) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.currency
        numberFormatter.currencySymbol = ""
        if let number2 = Double(number){
            return numberFormatter.string(from: NSNumber(value: number2))!
        }
        return number
        
    }
    

    
    static func castToDouble(stringNumber number: String) -> Double?{
        var number = number
        number.insert(".", at: number.index(number.endIndex, offsetBy: -2))
        if let valueDbl = Double(number){
            return valueDbl
        }
        return nil
    }
    
    static func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
        DispatchQueue.main.async {
            updates()
        }
    }
    

    
}



