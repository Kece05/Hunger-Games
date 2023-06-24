//
//  GotSchoolTomorrowandis1019pm.swift
//  Hunger Games
//
//  Created by kbice on 9/30/19.
//  Copyright © 2019 Keller Bice. All rights reserved.
//

import UIKit

class GotSchoolTomorrowandis1019pm: UIViewController {

    let defaults = UserDefaults.standard
    @IBOutlet weak var lol: UITextView!
    @IBOutlet weak var lols: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if defaults.bool(forKey: "jeep") {
            if defaults.string(forKey: "name") == "mountainC" {
                lols.setTitle("Selected", for: .normal)
            } else {
                lols.setTitle("Select", for: .normal)
            }
            lol.text = "Loadout:\nRare Machine - Epic Sniper - Rare Machine\nName: Jeep Command\nCoins:\(defaults.integer(forKey: "coins"))"
        } else {
            lols.setTitle("Buy", for: .normal)
            lol.text = "Loadout:\nRare Machine - Epic Sniper - Rare Machine\nCost: 50000\nXp needed:100000\nName: Jeep Command\nCoins:\(defaults.integer(forKey: "coins"))"
        }
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let left = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        left.direction = .left
        self.view.addGestureRecognizer(left)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(taps))
        tap.numberOfTapsRequired = 3
        tap.numberOfTouchesRequired = 3
        self.view.addGestureRecognizer(tap)
        
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
    
    @objc func taps() {
        self.performSegue(withIdentifier: "lucky person", sender: nil)
    }
    
    @IBAction func B(_ sender: Any) {
        if lols.titleLabel?.text == "Buy" && defaults.integer(forKey: "coins") >= 50000 && defaults.integer(forKey: "xp") >= 100000{
            defaults.set(true, forKey: "jeep")
            defaults.set("mountainC", forKey: "name")
            lols.setTitle("Selected", for: .normal)
            defaults.set(defaults.integer(forKey: "coins")-50000, forKey:"coins")
            lol.text = "Loadout:\nRare Machine Gun - Epic Sniper - Rare Machine Gun\nName: Jeep Command\nCoins:\(defaults.integer(forKey: "coins"))"
        }
        if lols.titleLabel?.text != "Buy" {
            defaults.set("mountainC", forKey: "name")
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
