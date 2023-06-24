//
//  FinalController.swift
//  Hunger Games
//
//  Created by kbice on 9/26/19.
//  Copyright © 2019 Keller Bice. All rights reserved.
//

import UIKit

class FinalController: UIViewController {
    
    @IBOutlet weak var Kills: UILabel!
    @IBOutlet weak var XP: UILabel!
    @IBOutlet weak var Coins: UILabel!
    let please = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if please.bool(forKey: "win") {
            Kills.text = "Victory Is Yours!\n\nKilled: \(please.integer(forKey: "kills")-1)"
        } else {
            Kills.text = "\n\nKilled: \(please.integer(forKey: "kills")-1)"
        }
        if !UserDefaults.standard.bool(forKey: "cm") {
            please.set((please.integer(forKey: "xp")+please.integer(forKey: "place")*25), forKey: "xp")
            XP.text = "XP Earned: \((please.integer(forKey: "place")*25))"
            please.set((please.integer(forKey: "coins")+please.integer(forKey: "place")+please.integer(forKey: "kills")*75), forKey: "coins")
            Coins.text = "Coin(s) Earned: \((please.integer(forKey: "place")+please.integer(forKey: "kills")*75))"
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
