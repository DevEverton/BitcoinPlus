//
//  ExchangeVC.swift
//  Bitcoin+
//
//  Created by Everton Carneiro on 27/09/17.
//  Copyright © 2017 Everton. All rights reserved.
//

import UIKit

class ExchangeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var changeSidesButton: UIButton!
    @IBOutlet weak var bitcoinSymbol: UIImageView!
    @IBOutlet weak var currencyButton: UIButton!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    var bitcoinSymbolLocation: CGPoint!
    var currencyButtonLocation: CGPoint!
    
    var bitcoinData = [Bitcoin]()
    

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
        getData()


    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let sections = ["Last", "Buy", "Sell"]
//        
//        return sections[0]
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bitcoinData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ResultsCell
 
        let bitcoinObject = bitcoinData[indexPath.row]
        
        cell.valueLabel.text = "Last: " + Functions.formatToCurrency(symbol: bitcoinObject.symbol, number: String(bitcoinObject.last))
        
        return cell
        
    }
    
    func getData() {
        
        Bitcoin.bitcoinPrice(currency: "BRL") { (results:[Bitcoin]?) in
            if let bitcoinResults = results {
                self.bitcoinData = bitcoinResults
                Functions.performUIUpdatesOnMain {
                    self.tableView.reloadData()

                }
            }
        }
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
