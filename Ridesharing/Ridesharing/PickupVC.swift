//
//  PickupVC.swift
//  Ridesharing
//
//  Created by Billy on 7/13/17.
//  Copyright © 2017 Billy. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class PickupVC: UIViewController {
    
    @IBOutlet weak var pickupMapView: RoundMapView!
    
    var pickupCoordinate: CLLocationCoordinate2D!
    var passengerKey: String!
    var regionRadius: CLLocationDistance = 2000
    var pin: MKPlacemark? = nil
    var locationPlacemark: MKPlacemark!
    var currentUserID = FIRAuth.auth()?.currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationPlacemark = MKPlacemark(coordinate: pickupCoordinate)
        dropPinFor(placemark: locationPlacemark)
        centerMapOnLocation(location: locationPlacemark.location!)
        
        DataService.instance.REF_TRIPS.child(passengerKey).observe(.value, with: { (tripSnapshot) in
            if tripSnapshot.exists() {
                if tripSnapshot.childSnapshot(forPath: "tripIsAccepted").value as? Bool == true {
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        })
       
    }
    
    func initData(coordinate: CLLocationCoordinate2D, passengerKey: String) {
        self.pickupCoordinate = coordinate
        self.passengerKey = passengerKey
    }

    @IBAction func cancelBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }


    @IBAction func acceptTripBtnPressed(_ sender: Any) {
        UpdateService.instance.acceptTrip(withPassengerKey: passengerKey, forDriverKey: currentUserID!)
        presentingViewController?.shouldPresentLoadingView(true)
    }
   
}

extension PickupVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "pickupPoint"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(named: "destinationAnnotation")
        
        return annotationView
        
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        pickupMapView.setRegion(coordinateRegion, animated: true)
    }
    
    func dropPinFor(placemark: MKPlacemark) {
        pin = placemark
        
        for annotation in pickupMapView.annotations {
            pickupMapView.removeAnnotation(annotation)
        }
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        
        pickupMapView.addAnnotation(annotation)
    }
}
