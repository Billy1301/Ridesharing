//
//  CircleView.swift
//  Ridesharing
//
//  Created by Billy on 6/14/17.
//  Copyright © 2017 Billy. All rights reserved.
//

import UIKit

class CircleView: UIView {

    @IBInspectable var borderColor: UIColor? {
        didSet {
            setupView()
        }
    }
    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = frame.width / 2
        layer.borderWidth = 1.5
        layer.borderColor = borderColor?.cgColor
        
    }

}
