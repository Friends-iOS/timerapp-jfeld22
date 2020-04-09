//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var timer = Timer()
    var player: AVAudioPlayer?
    let times = ["Exercise": 5,
                 "School": 10,
                 "Gaming": 15]
    var totalTime = 0
    @IBOutlet weak var titleLabel: UILabel!
    func playSound(name : String!) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    @IBAction func buttonPressed(_ sender: UIButton) {
        totalTime = times[sender.currentTitle!]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: true)
    }
    @objc func timerAction() {
        if(totalTime > 0) {
            totalTime -= 1
            titleLabel.text = String(totalTime) + " seconds left!"
        }
        else {
            titleLabel.text = "Done!"
            playSound(name : "alarm_sound")
        }
    }
}

