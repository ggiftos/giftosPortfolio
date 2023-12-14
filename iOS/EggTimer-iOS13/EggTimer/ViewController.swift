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
  
  @IBOutlet weak var timerStatus: UILabel!
  @IBOutlet weak var timerProgressBar: UIProgressView!
  
  let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
  var timer = Timer()
  var totalTime = 0
  var secondsPassed = 0
  
  let alarmSound = URL(fileURLWithPath: Bundle.main.path(forResource: "alarm_sound", ofType: "mp3")!)
  var audioPlayer = AVAudioPlayer()
  
  override func viewDidLoad() {
    timerProgressBar.progress = 1.0
  }

  @IBAction func hardnessSelected(_ sender: UIButton) {
    
    timer.invalidate()
    let hardness = sender.currentTitle!
    totalTime = eggTimes[hardness]!
    
    timerProgressBar.progress = 0.0
    secondsPassed = 0
    timerStatus.text = hardness
    
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updatesecondsRemaining), userInfo: nil, repeats: true)
  }
  
  @objc func updatesecondsRemaining() {
    if secondsPassed < totalTime {
      
      secondsPassed += 1
      timerProgressBar.progress = Float(secondsPassed) / Float(totalTime)
      
    } else{
      
      playAlarm()
      
      timer.invalidate()
      timerStatus.text = "Done!"
      DispatchQueue.main.asyncAfter(deadline: .now() + 10){
        self.timerStatus.text = "How do you like your eggs?"
      }
      
    }
  }
  
  func playAlarm (){
    do {
      audioPlayer = try AVAudioPlayer(contentsOf: alarmSound)
      audioPlayer.play()
    } catch {
      print("error")
    }
  }
  
}
