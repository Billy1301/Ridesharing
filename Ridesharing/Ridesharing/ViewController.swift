//
//  ViewController.swift
//  Ridesharing
//
//  Created by Billy on 6/13/17.
//  Copyright © 2017 Billy. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }

}

