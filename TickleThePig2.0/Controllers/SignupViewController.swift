//
//  SignupViewController.swift
//  TickleThePig2.0
//
//  Created by Brian Broeking on 10/1/19.
//  Copyright © 2019 Brian Broeking. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class SignupViewController: UIViewController {

    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var usernameText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    func setUpElements(){
        errorLabel.alpha = 0
    }
    
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    func validateFields() -> String? {
        
        // Fields are filled
        if firstNameText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "please fill in all fields"
        }
        let cleanedPassword = passwordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if isPasswordValid(cleanedPassword) == false {
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        return nil
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        // Validate
        let error = validateFields()
        if error != nil {
            showError(error!)
        }
        else{
            let firstname = firstNameText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastname = lastNameText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let screenname = usernameText.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            // Create
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if err != nil {
                    self.showError("Error creating user")
                }
                else {
                    let db = Firestore.firestore()
                    print(result!.user.uid)
                    db.collection("users").document(result!.user.uid).setData(["firstname": firstname, "lastname": lastname]) { (error) in
                        if error != nil {
                            self.showError("Error saving user data")
                        }
                    }
                    db.collection("tickles").document(result!.user.uid).setData(["availableTickles": 3, "numTickles": 0, "uid": result!.user.uid, "username": screenname])
                }
                // Transition
                self.transitionToHome()
            }
        }
    }
    
    func showError(_ message: String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        let tabViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.tabViewController) as? UITabBarController
        view.window?.rootViewController = tabViewController
        view.window?.makeKeyAndVisible()
    }
    
}
