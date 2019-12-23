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
    
    var oinkPlayer:AVAudioPlayer? = nil
    func loadSound(filename: String) -> AVAudioPlayer {
      let url = Bundle.main.url(forResource: filename, withExtension: "mp3")
      var player = AVAudioPlayer()
      do {
        try player = AVAudioPlayer(contentsOf: url!)
        player.prepareToPlay()
      } catch {
        print("Error loading \(url!): \(error.localizedDescription)")
      }
      return player
    }
    
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
        pig.loadGif(name: "pig")
        self.getTickleCount()
        
        let recognizer2 = TickleGestureRecognizer(target: self,
          action:#selector(handleTickle(recognizer:)))
        recognizer2.delegate = self
        view.addGestureRecognizer(recognizer2)
        
//        self.oinkPlayer = self.loadSound(filename: "oink")
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
