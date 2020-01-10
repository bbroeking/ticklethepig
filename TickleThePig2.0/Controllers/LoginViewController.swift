//
//  LoginViewController.swift
//  TickleThePig2.0
//
//  Created by Brian Broeking on 10/1/19.
//  Copyright © 2019 Brian Broeking. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        // Clean text fields
        let email = emailText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else {
                self.transitionToHome()
            }
        }
    }
    func transitionToHome() {
        let tabViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.tabViewController) as? UITabBarController
        view.window?.rootViewController = tabViewController
        view.window?.makeKeyAndVisible()
    }
}
