//
//  ExchangeVC.swift
//  Bitcoin+
//
//  Created by Everton Carneiro on 27/09/17.
//  Copyright © 2017 Everton. All rights reserved.
//

import UIKit

class ExchangeVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var changeSidesButton: UIButton!
    @IBOutlet weak var bitcoinSymbol: UIImageView!
    @IBOutlet weak var currencyButton: UIButton!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    
    
    var bitcoinSymbolLocation: CGPoint!
    var currencyButtonLocation: CGPoint!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Bitcoin.bitcoinPrice(currency: "USD") { (results: [Bitcoin]) in
            print(results)
        }
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "bitcoinIcon"))
        //self.amountTextField.font = UIFont(name: "Courier New", size: 45)
        bitcoinSymbolLocation = bitcoinSymbol.center
        currencyButtonLocation = currencyButton.center
        amountLabel.text = "0,00"

    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        return true
    }
    

    
    
    
    @IBAction func changeSidesButton(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3) {
            if self.bitcoinSymbolLocation == self.bitcoinSymbol.center {
                self.bitcoinSymbol.center = self.currencyButtonLocation
                self.currencyButton.center = self.bitcoinSymbolLocation
                self.bitcoinSymbolLocation = self.bitcoinSymbol.center
                self.currencyButtonLocation = self.currencyButton.center
                
            }
            if self.symbolLabel.text == "฿" {
                self.symbolLabel.text = "$"
            }else {
                self.symbolLabel.text = "฿"
            }


        }
    }




}
