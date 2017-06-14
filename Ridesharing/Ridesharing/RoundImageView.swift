//
//  RoundImageView.swift
//  Ridesharing
//
//  Created by Billy on 6/14/17.
//  Copyright © 2017 Billy. All rights reserved.
//

import UIKit

class RoundImageView: UIImageView {

    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
    }

}
