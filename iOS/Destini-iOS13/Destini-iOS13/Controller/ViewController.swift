//
//  ViewController.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var storyLabel: UILabel!
  @IBOutlet weak var choice1Button: UIButton!
  @IBOutlet weak var choice2Button: UIButton!
  
  var storyBrain = StoryBrain()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    updateUI()
  }
  
  
  @IBAction func choiceMade(_ sender: UIButton) {
    storyBrain.nextStory(pick: sender.currentTitle!)
    
    updateUI()
  }
  
  func updateUI(){
    let chapter = storyBrain.storyChapter
    
    storyLabel.text = storyBrain.stories[chapter].title
    choice1Button.setTitle(storyBrain.stories[chapter].choice1, for: .normal)
    choice2Button.setTitle(storyBrain.stories[chapter].choice2, for: .normal)
  }
}

