//
//  Bitcoin.swift
//  Bitcoin+
//
//  Created by Everton Carneiro on 27/09/17.
//  Copyright © 2017 Everton. All rights reserved.
//

import Foundation

struct Bitcoin {
    
    let last:Double
    let buy:Double
    let sell:Double
    let symbol:String
    
    enum SerializationError:Error {
        
        case missing(String)
        case invalid(String:Any)
        
        
    }
    
    init(json:[String:Any])throws {
        guard let last = json["last"] as? Double else {throw SerializationError.missing("last is missing")}
        guard let buy = json["buy"] as? Double else {throw SerializationError.missing("buy is missing")}
        guard let sell = json["sell"] as? Double else {throw SerializationError.missing("last is missing")}
        guard let symbol = json["symbol"] as? String else {throw SerializationError.missing("symbol is missing")}
        
        self.last = last
        self.buy = buy
        self.sell = sell
        self.symbol = symbol
        
    }
    
    
    static func bitcoinPrice(currency: String,completion: @escaping ([Bitcoin]) -> ()){
        
        let url = "https://blockchain.info/pt/ticker"
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request){(data:Data?, response: URLResponse?, error: Error?) in
            
            var bitcoinArray:[Bitcoin] = []
            
            if let data = data {
                
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]{
                        if let currency = json[currency] as? [String:Any] {
                            if let bitcoinObj = try? Bitcoin(json: currency){
                                
                                bitcoinArray = [bitcoinObj]
                                
                            }
                        }
                        
                    }
                    
                }catch{
                    print(error.localizedDescription)
                    
                }
                completion(bitcoinArray)
                
                
            }
            
            
        }
        task.resume()
        
        
    }
    
    
}
