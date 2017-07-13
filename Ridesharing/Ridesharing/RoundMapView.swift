//
//  RoundMapView.swift
//  Ridesharing
//
//  Created by Billy on 7/13/17.
//  Copyright © 2017 Billy. All rights reserved.
//

import UIKit
import MapKit

class RoundMapView: MKMapView {
    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = frame.width / 2
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 10.0
    }
    
}
