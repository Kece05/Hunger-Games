//
//  medicOne.swift
//  Hunger Games
//
//  Created by kbice on 7/9/20.
//  Copyright © 2020 Keller Bice. All rights reserved.
//

import UIKit

class medicOne: UIViewController {

    
    let defaults = UserDefaults.standard
    @IBOutlet weak var lol: UITextView!
    @IBOutlet weak var lols: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if defaults.bool(forKey: "medic") {
            if defaults.string(forKey: "name") == "medic" {
                lols.setTitle("Selected", for: .normal)
            } else {
                lols.setTitle("Select", for: .normal)
            }
            lol.text = "Loadout:\nMythical Machine Gun  - Heals - Mythical Shotgun\nName: Medic\nCoins:\(defaults.integer(forKey: "coins"))"
        } else {
            lols.setTitle("Buy", for: .normal)
            lol.text = "Loadout:\nMythical Machine Gun  - Heals - Mythical Shotgun\nCost: 500,000\nXp needed:750,000\nName: Medic\nCoins:\(defaults.integer(forKey: "coins"))"
        }
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let left = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        left.direction = .left
        self.view.addGestureRecognizer(left)
        
        let back = UITapGestureRecognizer(target: self, action: #selector(backs))
        back.numberOfTapsRequired = 2
        back.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(back)
            
    }
        
    @objc func backs() {
        performSegue(withIdentifier: "back", sender: nil)
    }
    
    @IBAction func B(_ sender: Any) {
        if lols.titleLabel?.text == "Buy" && defaults.integer(forKey: "coins") >= 500000 && defaults.integer(forKey: "xp") >= 750000{
            defaults.set(true, forKey: "medic")
            defaults.set("medic", forKey: "name")
            defaults.set(defaults.integer(forKey: "coins")-500000, forKey:"coins")
            lols.setTitle("Selected", for: .normal)
            lol.text = "Loadout:\nMythical Machine Gun  - Heals - Mythical Shotgun\nName: Medic\nCoins:\(defaults.integer(forKey: "coins"))"
        }
        if lols.titleLabel?.text != "Buy" {
            defaults.set("medic", forKey: "name")
            lols.setTitle("Selected", for: .normal)
        }
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .right {
            self.performSegue(withIdentifier: "r", sender:  nil)
        } else if gesture.direction == .left {
            self.performSegue(withIdentifier: "l", sender:  nil)
        }
    }
}
