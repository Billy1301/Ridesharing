//
//  RoundedShadowView.swift
//  Ridesharing
//
//  Created by Billy on 6/14/17.
//  Copyright © 2017 Billy. All rights reserved.
//

import UIKit

class RoundedShadowView: UIView {

    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = 5.0
        layer.shadowOpacity = 0.3
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }

}
