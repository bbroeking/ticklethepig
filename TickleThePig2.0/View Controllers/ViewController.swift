//
//  ViewController.swift
//  TickleThePig2.0
//
//  Created by Brian Broeking on 5/11/18.
//  Copyright © 2018 Brian Broeking. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser != nil {
            switchStoryboard()
        }
    }
    func switchStoryboard() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "tabBar") as UIViewController
        self.navigationController?.pushViewController(controller, animated: true)
//        self.present(controller, animated: true, completion: nil)
    }
}



