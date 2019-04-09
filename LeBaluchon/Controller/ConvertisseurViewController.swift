//
//  ConvertisseurViewController.swift
//  LeBaluchon
//
//  Created by Vigneswaranathan Sugeethkumar on 04/12/2018.
//  Copyright © 2018 Vigneswaranathan Sugeethkumar. All rights reserved.
//

import UIKit

extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}

class ConvertisseurViewController: UIViewController {
    
    @IBOutlet weak var firstMoney: UITextField!
    @IBOutlet weak var amountFinal: UILabel!
    @IBOutlet weak var amountKeyboard: UILabel!
    
  
    var convert = ConvertManager(convertSession: URLSession(configuration: .default))
    var rateUSD : Double = 0.0
    var rateEUR : Double = 0.0
    var total = 0.0
    
    var result: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moneyToConvert(firstMoney)
        amountKeyboard.isHidden = true
        // Do any additional setup after loading the view.
    }


    func getRate() {
        self.convert.getConvert { (convert, error) in
                if let convert = convert {
                    if let rateUnwrap = convert.rates {
                    self.rateUSD = rateUnwrap.usd
                    self.rateEUR = rateUnwrap.eur
                        
                    }
                    
                    print("\(self.rateUSD)")
                    
                    self.total = self.rateUSD*self.stringToInt(textField: self.firstMoney)
                    
                    self.total = Double(round(100*self.total)/100)
                        
                    self.amountFinal.text = "\(self.total) $"
                    self.amountKeyboard.text = "\(self.total) $"
                }
        }
    }
    
    func stringToInt(textField: UITextField) -> Double {
        var double : Double = 0.0
        let text = textField.text
        if let text = text {
            if text.isInt {
                double = Double(text)!
            return double
            }
        }
        return double
    }
    
    @IBAction func moneyToConvert(_ sender: UITextField) {
        amountKeyboard.isHidden = false
        getRate()
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        firstMoney.resignFirstResponder()
        amountKeyboard.isHidden = true
        
    }
}

