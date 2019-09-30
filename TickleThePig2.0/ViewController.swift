//
//  ViewController.swift
//  TickleThePig2.0
//
//  Created by Brian Broeking on 5/11/18.
//  Copyright © 2018 Brian Broeking. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    
    @IBOutlet weak var TickleCounter: UILabel!
    @IBOutlet var barnImage: UIImageView!


    var tickleCount =  0 {
        didSet {
            let attributes: [NSAttributedStringKey:Any] = [
                .strokeWidth : 2.0,
                .strokeColor : #colorLiteral(red: 0.9271472146, green: 0.2466179687, blue: 0.9372549057, alpha: 1),
                .font : UIFont(name: "AvenirNext-Medium", size: 40)!
            ]
            let attributedString = NSAttributedString(string: "Tickles: \(tickleCount)", attributes: attributes)
            TickleCounter.attributedText = attributedString
        }
    }
    
    @IBAction func ticklePig(_ sender: Any) {
        tickleCount += 1
        audioPlayer.play()
//        audioPlayer.stop()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Build the background image
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background.png")
        self.view.insertSubview(backgroundImage, at: 0)
        self.barnImage.image = UIImage(named: "Cooper_Barn.png")
        
        // Adding Oink Sound When Tickled
        let sound = Bundle.main.url(forResource: "SupportFiles/oink", withExtension: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: sound!)
            audioPlayer.prepareToPlay()
        } catch let error as NSError {
            print(error.debugDescription)
        }
        
    }
    
}

