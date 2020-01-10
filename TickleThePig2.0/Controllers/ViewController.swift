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
import GoogleSignIn


class ViewController: UIViewController, GIDSignInDelegate {
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Auto SignIn
        if Auth.auth().currentUser != nil {
            switchStoryboard()
        }
        // Google Auth
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
        print(error.localizedDescription)
        return
        }
        guard let auth = user.authentication else { return }
        let credentials = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
        Auth.auth().signIn(with: credentials) { (authResult, error) in
        if let error = error {
        print(error.localizedDescription)
        } else {
        print("Login Successful.")
        self.switchStoryboard()
        //This is where you should add the functionality of successful login
        //i.e. dismissing this view or push the home view controller etc
        }
        }
    }
    func switchStoryboard() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "tabBar") as UIViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }

}



