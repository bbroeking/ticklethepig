//
//  ViewController.swift
//  TickleThePig2.0
//
//  Created by Brian Broeking on 5/11/18.
//  Copyright © 2018 Brian Broeking. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        let uid = Auth.auth().currentUser // can be used to keep session 
        let db = Firestore.firestore()

    }
    
}

