//
//  EndGame.swift
//  FirstAppBack
//
//  Created by David Richardson on 7/29/19.
//  Copyright © 2019 David Richardson. All rights reserved.
//

import UIKit
class EndGame:UIViewController {
    var totalPoints: Int = 0
    var rounds: Int = 0
    var possiblePoints: Int = 0
    
    var colorTimer: Timer?
    
    @IBOutlet weak var totalPointsLabel: UILabel!
    @IBOutlet weak var roundsLabel: UILabel!
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var againBtn: UIButton!
    
    
    @IBOutlet weak var titleBackground: UIView!
    
    override func viewDidLoad() {
        againBtn.layer.cornerRadius = 5
        againBtn.layer.borderColor = UIColor.black.cgColor
        againBtn.layer.borderWidth = 2
        colorTimer = Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true, block: { (Timer) in
            self.newColor()
        })
        if(totalPoints > 0 && rounds > 0 && possiblePoints > 0) {
            totalPointsLabel.text = String(totalPoints) + " / " + String(possiblePoints*rounds)
            roundsLabel.text = String(rounds)
            averageLabel.text = String(totalPoints/rounds) + " / " + String(possiblePoints)
            let percentage = Double(totalPoints)/Double(possiblePoints*rounds)
            percentageLabel.text = String(Int(round(percentage*100))) + "%"
        }
        else {
            totalPointsLabel.text = String(0)
            roundsLabel.text = String(0)
            averageLabel.text = String(0)
            percentageLabel.text = "Sad face :-("
        }
    }
    func newColor() {
        let R = random(150) + 105
        let G = random(150) + 105
        let B = random(150) + 105
        titleBackground.backgroundColor = UIColor(red: CGFloat(R)/255, green: CGFloat(G)/255, blue: CGFloat(B)/255, alpha: 1.0)
    }
    func random(_ n:Int) -> Float {
        return Float(Int(arc4random_uniform(UInt32(n))))
    }
    @IBAction func playAgain(_ sender: Any) {
        colorTimer?.invalidate()
        print("timer stoped")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "gameScreen") as! ViewController
        self.present(vc, animated: true)
    }
}
