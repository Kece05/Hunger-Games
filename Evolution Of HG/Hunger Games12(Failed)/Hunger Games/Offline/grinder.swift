//
//  grinder.swift
//  Hunger Games
//
//  Created by kbice on 7/9/20.
//  Copyright © 2020 Keller Bice. All rights reserved.
//

import UIKit

class grinder: UIViewController {

    let defaults = UserDefaults.standard
    @IBOutlet weak var lol: UITextView!
    @IBOutlet weak var lols: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if defaults.bool(forKey: "grind") {
            if defaults.string(forKey: "name") == "fast" {
                lols.setTitle("Selected", for: .normal)
            } else {
                lols.setTitle("Select", for: .normal)
            }
            lol.text = "Loadout:\nSteel Sword - Laserbeam - Steel Sword\nName: Grinder Command\nCoins:\(defaults.integer(forKey: "coins"))"
        } else {
            lols.setTitle("Buy", for: .normal)
            lol.text = "Loadout:\nSteel Sword - Laserbeam - Steel Sword\nCost: 2,500,000\nXp needed:5,000,000\nName: Grinder Command\nCoins:\(defaults.integer(forKey: "coins"))"
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
        }
    }
    
    @IBAction func B(_ sender: Any) {
        if lols.titleLabel?.text == "Buy" && defaults.integer(forKey: "coins") >= 5000000 && defaults.integer(forKey: "xp") >= 25000000 {
            defaults.set(true, forKey: "grind")
            defaults.set("fast", forKey: "name")
            lols.setTitle("Selected", for: .normal)
            defaults.set(defaults.integer(forKey: "coins")-5000000, forKey:"coins")
            lol.text = "Loadout:\nSteel Sword - Laserbeam - Steel Sword\nCost: 2,500,000\nName: Grinder Command\nCoins:\(defaults.integer(forKey: "coins"))"
        }
        if lols.titleLabel?.text != "Buy" {
            defaults.set("fast", forKey: "name")
            lols.setTitle("Selected", for: .normal)
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
