//
//  ViewController.swift
//  FirstAppBack
//
//  Created by David Richardson on 7/25/19.
//  Copyright © 2019 David Richardson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
   
    @IBOutlet weak var challengeColor: UIView!
    @IBOutlet weak var userColor: UIView!
  
    @IBOutlet weak var rgbLabel: UILabel!
 
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var checkBtn: UIButton!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    var userR: Float = 127.0
    var userG: Float = 127.0
    var userB: Float = 127.0
    
    var challengeR: Float = 127.0
    var challengeG: Float = 127.0
    var challengeB: Float = 127.0
    
    var possiblePoints = 105
    var totalPoints = 0
    var totalRounds = 0
    
    var countdownTimer: Timer?
    let totalTime = 60
    var timeRemaining: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        checkBtn.layer.cornerRadius = 5
        checkBtn.layer.borderColor = UIColor.black.cgColor
        checkBtn.layer.borderWidth = 2

        startGame()
        timeRemaining = totalTime
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (Timer) in
            self.timerLabel.text = self.timeFormatted(self.timeRemaining)
            if(self.timeRemaining > 0) {
                self.timeRemaining -= 1
            }else {
                self.endTimer()
            }
        })
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func endTimer() {
        countdownTimer?.invalidate()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "endGame") as! EndGame
        vc.totalPoints = totalPoints
        vc.rounds = totalRounds
        vc.possiblePoints = possiblePoints
        self.present(vc, animated: true)
    }
    
    func startGame() {
        userR = 127; userG = 127; userB = 127;
        updateValues(reset: true)
        //Create new color
        challengeR = Float(random(256))
        challengeG = Float(random(256))
        challengeB = Float(random(256))
        print("Challenge RGB: " + String(challengeR) + " " + String(challengeG) + " " + String(challengeB))
        //Set color
        challengeColor.backgroundColor = UIColor(red: CGFloat(challengeR/255), green: CGFloat(challengeG/255), blue: CGFloat(challengeB/255), alpha: 1.0)
    }
    
    func updateValues(reset: Bool) {
        //View
        userColor.backgroundColor = UIColor(red: CGFloat(userR/255), green: CGFloat(userG/255), blue: CGFloat(userB/255), alpha: 1.0)
        //Label
        rgbLabel.text = "R: " + String(Int(userR)) + " G: " + String(Int(userG)) + " B: " + String(Int(userB))
        if(reset) {
            //Red slider
            redSlider.value = 127.0/255
            //Green slider
            greenSlider.value = 127.0/255
            //Blue slider
            blueSlider.value = 127.0/255
        }
    }
    
    func random(_ n:Int) -> Int {
        return Int(arc4random_uniform(UInt32(n)))
    }
    
    @IBAction func redSliderChanged(_ sender: Any) {
        userR = redSlider.value*255
        updateValues(reset: false)
    }
    @IBAction func greenSliderChanged(_ sender: Any) {
        userG = greenSlider.value*255
        updateValues(reset: false)
    }
    @IBAction func blueSliderChanged(_ sender: Any) {
        userB = blueSlider.value*255
        updateValues(reset: false)
    }
    
    @IBAction func check(_ sender: Any) {
        print("check")
        totalRounds += 1
        var pointsR = 0
        var pointsG = 0
        var pointsB = 0
        
        let points = possiblePoints/3
        var roundPoints = 0
        if(!(userR <= challengeR - Float(points) || userR >= challengeR + Float(points))) {
            pointsR = points - abs(Int(userR) - Int(challengeR))
            roundPoints += pointsR
        }
        if(!(userG <= challengeG - Float(points) || userG >= challengeG + Float(points))) {
            pointsG = points - abs(Int(userG) - Int(challengeG))
            roundPoints += pointsG
        }
        if(!(userB <= challengeB - Float(points) || userB >= challengeB + Float(points))) {
            pointsB = points - abs(Int(userB) - Int(challengeB))
            roundPoints += pointsB
        }
        
        totalPoints += roundPoints
        print("Points: " + String(totalPoints))
        
        scoreLabel.text = "+" + String(roundPoints)
        scoreLabel.alpha = 1
        UIView.animate(withDuration: 4.5) {
            self.scoreLabel.alpha = 0
        }
        startGame()
    }
    
    
}

