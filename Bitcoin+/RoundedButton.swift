//
//  RoundedButton.swift
//  Bitcoin+
//
//  Created by Everton Carneiro on 29/09/17.
//  Copyright © 2017 Everton. All rights reserved.
//

import UIKit

@IBDesignable

class RoundedButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
        
    }
    
    @IBInspectable var borderWidht: CGFloat = 0 {
        didSet {
            
            self.layer.borderWidth = borderWidht
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            
            self.layer.borderColor = borderColor.cgColor
        }
    }


}
