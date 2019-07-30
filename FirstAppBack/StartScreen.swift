//
//  StartScreen.swift
//  FirstAppBack
//
//  Created by David Richardson on 7/26/19.
//  Copyright © 2019 David Richardson. All rights reserved.
//

import UIKit
class StartScreen: UIViewController {
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var goBtn: UIButton!
    
    var colorTimer: Timer?
    override func viewDidLoad() {
        goBtn.layer.cornerRadius = 5
        goBtn.layer.borderColor = UIColor.black.cgColor
        goBtn.layer.borderWidth = 2
        colorTimer = Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true, block: { (Timer) in
            self.newColor()
        })
    }
    func newColor() {
        let R = random(150) + 105
        let G = random(150) + 105
        let B = random(150) + 105
        background.backgroundColor = UIColor(red: CGFloat(R)/255, green: CGFloat(G)/255, blue: CGFloat(B)/255, alpha: 1.0)
        print("timer running")
    }
    @IBAction func stopTimer(_ sender: Any) {
        colorTimer?.invalidate()
        print("timer stoped")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "gameScreen") as! ViewController
        self.present(vc, animated: true)
    }
    func random(_ n:Int) -> Float {
        return Float(Int(arc4random_uniform(UInt32(n))))
    }
}
