//
//  sViewController.swift
//  Hunger Games
//
//  Created by kbice on 9/30/19.
//  Copyright © 2019 Keller Bice. All rights reserved.
//

import UIKit

class sViewController: UIViewController {

    let defaults = UserDefaults.standard
    @IBOutlet weak var lol: UITextView!
    @IBOutlet weak var lols: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if defaults.bool(forKey: "bum") {
            if defaults.string(forKey: "name") == "bumbleC" {
                lols.setTitle("Selected", for: .normal)
            } else {
                lols.setTitle("Select", for: .normal)
            }
            lol.text = "Loadout:\nLegendary Sword - Rare Spear - Legendary Sword\nName: Bumble\nCoins:\(defaults.integer(forKey: "coins"))"
        } else {
            lols.setTitle("Buy", for: .normal)
            lol.text = "Loadout:\nLegendary Sword - Rare Spear - Legendary Sword\nCost: 2500\nXp needed:5000\nName: Bumble\nCoins:\(defaults.integer(forKey: "coins"))"
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
        if lols.titleLabel?.text == "Buy" && defaults.integer(forKey: "coins") >= 2500 && defaults.integer(forKey: "xp") >= 5000 {
            defaults.set(true, forKey: "bum")
            lols.setTitle("Selected", for: .normal)
            defaults.set(defaults.integer(forKey: "coins")-2500, forKey:"coins")
            defaults.set("bumbleC", forKey: "name")
            lol.text = "Loadout:\nLegendary Sword - Rare Spear - Legendary Sword\nName: Bumble\nCoins:\(defaults.integer(forKey: "coins"))"
        }
        if lols.titleLabel?.text != "Buy" {
            lols.setTitle("Selected", for: .normal)
            defaults.set("bmwC", forKey: "name")
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
