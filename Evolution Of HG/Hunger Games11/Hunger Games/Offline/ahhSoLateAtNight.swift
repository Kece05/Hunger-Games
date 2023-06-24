//
//  ahhSoLateAtNight.swift
//  Hunger Games
//
//  Created by kbice on 9/30/19.
//  Copyright © 2019 Keller Bice. All rights reserved.
//

import UIKit

class ahhSoLateAtNight: UIViewController {

    let defaults = UserDefaults.standard
    @IBOutlet weak var lol: UITextView!
    @IBOutlet weak var lols: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if defaults.bool(forKey: "lam") {
            if defaults.string(forKey: "name") == "lamboC" {
                lols.setTitle("Selected", for: .normal)
            } else {
                lols.setTitle("Select", for: .normal)
            }
            lol.text = "Loadout:\nMythical Machine Gun - Rare Spear - Rare Machine Gun\nName: Lamborghini\nCoins:\(defaults.integer(forKey: "coins"))"
        } else {
            lols.setTitle("Buy", for: .normal)
            lol.text = "Loadout:\nMythical Machine Gun - Rare Spear - Mythical Machine Gun\nCost: 35000\nXp needed:70000\nName: Lamborghini\nCoins:\(defaults.integer(forKey: "coins"))"
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
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .right {
            self.performSegue(withIdentifier: "r", sender:  nil)
        } else if gesture.direction == .left {
            self.performSegue(withIdentifier: "l", sender:  nil)
        }
    }
    
    @IBAction func B(_ sender: Any) {
        if lols.titleLabel?.text == "Buy" && defaults.integer(forKey: "coins") >= 35000 && defaults.integer(forKey: "xp") >= 70000{
            defaults.set(true, forKey: "lam")
            lols.setTitle("Selected", for: .normal)
            defaults.set(defaults.integer(forKey: "coins")-35000, forKey:"coins")
            defaults.set("lamboC", forKey: "name")
            lol.text = "Loadout:\nMythical Shotgun - Rare Spear - Mythical Shotgun\nName: Lamborghini\nCoins:\(defaults.integer(forKey: "coins"))"
        }
        if lols.titleLabel?.text != "Buy" {
            lols.setTitle("Selected", for: .normal)
            defaults.set("lamboC", forKey: "name")
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
