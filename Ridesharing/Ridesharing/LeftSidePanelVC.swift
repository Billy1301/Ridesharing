//
//  LeftSidePanelVC.swift
//  Ridesharing
//
//  Created by Billy on 6/14/17.
//  Copyright © 2017 Billy. All rights reserved.
//

import UIKit
import Firebase

class LeftSidePanelVC: UIViewController {

    let currentUserID = FIRAuth.auth()?.currentUser?.uid
    
    
    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var accountTypeLbl: UILabel!
    @IBOutlet weak var userImage: RoundImageView!
    @IBOutlet weak var pickupModeLbl: UILabel!
    @IBOutlet weak var pickupModeSwitch: UISwitch!
    @IBOutlet weak var loginOutBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        pickupModeSwitch.isOn = false
        pickupModeSwitch.isHidden = true
        pickupModeLbl.isHidden = true
        
        observePassengersAndDrivers()
        
        if FIRAuth.auth()?.currentUser == nil {
            userEmailLbl.text = ""
            accountTypeLbl.text = ""
            userImage.isHidden = true
            loginOutBtn.setTitle("Sign Up / Login", for: .normal)
        } else {
            userEmailLbl.text = FIRAuth.auth()?.currentUser?.email
            accountTypeLbl.text = ""
            userImage.isHidden = false
            loginOutBtn.setTitle("Logout", for: .normal)
        }
        
    }
    
    func observePassengersAndDrivers(){
        
        DataService.instance.REF_USERS.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    if snap.key == FIRAuth.auth()?.currentUser?.uid {
                        self.accountTypeLbl.text = "PASSENGER"
                    }
                }
            }
        })
        
        DataService.instance.REF_DRIVERS.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    if snap.key == FIRAuth.auth()?.currentUser?.uid {
                        self.accountTypeLbl.text = "DRIVER"
                        self.pickupModeSwitch.isHidden = false
                        
                        let switchStatus = snap.childSnapshot(forPath: "isPickupModeEnabled").value as! Bool
                        self.pickupModeSwitch.isOn = switchStatus
                        self.pickupModeLbl.isHidden = false
                    }

                }
            }
        })
    }
    
    @IBAction func switchWasToggled(_ sender: Any) {
        if pickupModeSwitch.isOn {
            pickupModeLbl.text = "PICKUP MODE ENABLED"
            DataService.instance.REF_DRIVERS.child(currentUserID!).updateChildValues(["isPickupModeEnabled": true])
        } else {
            pickupModeLbl.text = "PICKUP MODE DISABLED"
            DataService.instance.REF_DRIVERS.child(currentUserID!).updateChildValues(["isPickupModeEnabled": false])
        }
    }
    

    @IBAction func signUpLoginBtnWasPressed(_ sender: Any) {
        if FIRAuth.auth()?.currentUser == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
            
            present(loginVC!, animated: true, completion: nil)
        } else {
            do {
                try FIRAuth.auth()?.signOut()
                userEmailLbl.text = ""
                accountTypeLbl.text = ""
                userImage.isHidden = true
                pickupModeLbl.text = ""
                pickupModeSwitch.isHidden = true
                loginOutBtn.setTitle("Sign Up / Login", for: .normal)
            } catch (let error) {
                print(error)
            }
        }
    }
}
