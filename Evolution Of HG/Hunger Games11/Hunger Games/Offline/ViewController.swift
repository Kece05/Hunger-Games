//
//  ViewController.swift
//  Hunger Games
//
//  Created by kbice on 8/18/19.
//  Copyright © 2019 Keller Bice. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let defaults = UserDefaults.standard
    @IBOutlet weak var lol: UITextView!
    @IBOutlet weak var lols: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if defaults.string(forKey: "name") == nil {
            lols.setTitle("Selected", for: .normal)
        } else {
            if defaults.string(forKey: "name") == "bmwC" {
                lols.setTitle("Selected", for: .normal)
            } else {
                lols.setTitle("Select", for: .normal)
            }
        }
        lol.text = "Loadout:\nEpic Sword - Common Spear - Epic Sword\nName: BMW\nCoins:\(defaults.integer(forKey: "coins"))"
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
        defaults.set("bumbleC", forKey: "name")
        lols.setTitle("Selected", for: .normal)
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
