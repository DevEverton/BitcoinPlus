//
//  Constants.swift
//  Bitcoin+
//
//  Created by Everton Carneiro on 02/10/17.
//  Copyright © 2017 Everton. All rights reserved.
//

import Foundation


struct Constants {
    
//    static let currencyShort = ["USD", "AUD", "BRL", "CAD", "CHF", "CLP", "CNY", "DKK", "EUR", "GBP",
//                            "HKD", "INR", "ISK", "JPY", "KRW", "NZD", "PLN", "RUB", "SEK", "SGD", "THB", "TWD"]
    
    static let countriesCurrency = ["United States dollar", "Australian dollar", "Brazilian real", "Canadian dollar", "Swiss franc",
                                "Chilean peso", "Chinese Yuan Renminbi", "Danish krone", "European euro", "Pound sterling", "Hong Kong dollar",
                                "Indian rupee", "Icelandic krona", "Japanese yen", "South Korean won", "New Zealand dollar", "Polish zloty",
                                "Russian ruble", "Swedish krona", "Singapore dollar", "Thai baht", "New Taiwan dollar"]
    
    static let countriesCurrencyDict = ["United States dollar":"USD", "Australian dollar":"AUD", "Brazilian real":"BRL", "Canadian dollar":"CAD",
                               "Swiss franc":"CHF", "Chilean peso":"CLP", "Chinese Yuan Renminbi":"CNY", "Danish krone":"DKK",
                               "European euro":"EUR", "Pound sterling":"GBP", "Hong Kong dollar":"HKD", "Indian rupee":"INR",
                               "Icelandic krona":"ISK", "Japanese yen":"JPY", "South Korean won":"KRW", "New Zealand dollar":"NZD",
                               "Polish zloty":"PLN", "Russian ruble":"RUB", "Swedish krona":"SEK", "Singapore dollar":"SGD",
                               "Thai baht":"THB","New Taiwan dollar":"TWD"]
    

    static let BTC = "BTC"

}

enum topCalculatorNumber {
    
    case currency
    case bitcoin
    
}
