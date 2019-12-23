//
//  HomeViewController.swift
//  TickleThePig2.0
//
//  Created by Brian Broeking on 10/1/19.
//  Copyright © 2019 Brian Broeking. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import AVFoundation


class HomeViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var db = Firestore.firestore()
    var currentUser = Auth.auth().currentUser
    var totalTickles: Int = 0
    var availableTickles: Int = 0
    
    var audioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var TickleCounter: UILabel!
    @IBOutlet weak var TotalTickleCounter: UILabel!
    @IBOutlet var barnImage: UIImageView!
    @IBOutlet weak var pig: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Build the background image
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background.png")
        self.view.insertSubview(backgroundImage, at: 0)
        self.barnImage.image = UIImage(named: "Cooper_Barn.png")
        pig.loadGif(name: "SupportFiles/pig")
        self.getTickleCount()
        
        let recognizer = TickleGestureRecognizer(target: self,
          action:#selector(handleTickle(recognizer:)))
        recognizer.delegate = self
        view.addGestureRecognizer(recognizer)
        
//        let sound = Bundle.main.path(forResource: "oink", ofType: "mp3")
//
//        do {
//            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
//        }
//        catch {
//            print(error)
//        }
    }
    
    func getTickleCount() {
        let docRef = db.collection("tickles").document(self.currentUser!.uid)
        
        docRef.addSnapshotListener { (document, error) in
            if let document = document, document.exists {
                self.availableTickles = document.get("availableTickles") as! Int
                self.totalTickles = document.get("numTickles") as! Int
                self.showTickleCount()
                self.showTotalCount()
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func showTickleCount() {
        if self.availableTickles > 0 {
            var counter: String = ""
            for _ in 1...self.availableTickles {
                counter.append("\u{1F437}")
            }
            self.TickleCounter.text = counter
        }
        else{
            self.TickleCounter.text = "Next Tickle In..."
        }
    }

    func showTotalCount(){
        self.TotalTickleCounter.text = "Times Tickled: \(self.totalTickles)"
    }
    
    @objc func handleTickle(recognizer: TickleGestureRecognizer) {
        if(self.availableTickles > 0){
            db.collection("tickles").document(self.currentUser!.uid).updateData(["numTickles": self.totalTickles + 1, "availableTickles": self.availableTickles - 1])
            self.getTickleCount()
        }
        print("tickled")
    }
    
}
