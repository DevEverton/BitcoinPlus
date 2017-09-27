//
//  ExchangeVC.swift
//  Bitcoin+
//
//  Created by Everton Carneiro on 27/09/17.
//  Copyright © 2017 Everton. All rights reserved.
//

import UIKit

class ExchangeVC: UIViewController {
    
    @IBOutlet weak var changeSidesButton: UIButton!
    @IBOutlet weak var bitcoinSymbol: UIImageView!
    @IBOutlet weak var currencyButton: UIButton!
    
    
    var bitcoinSymbolLocation: CGPoint!
    var currencyButtonLocation: CGPoint!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Bitcoin.bitcoinPrice(currency: "USD") { (results: [Bitcoin]) in
            print(results)
        }
        
        bitcoinSymbolLocation = bitcoinSymbol.center
        currencyButtonLocation = currencyButton.center

    }
    
    
    @IBAction func changeSidesButton(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3) {
            if self.bitcoinSymbolLocation == self.bitcoinSymbol.center {
                self.bitcoinSymbol.center = self.currencyButtonLocation
                self.currencyButton.center = self.bitcoinSymbolLocation
            }else {
                self.bitcoinSymbolLocation = self.bitcoinSymbol.center
                self.currencyButtonLocation = self.currencyButton.center
            }
        }
    }




}
