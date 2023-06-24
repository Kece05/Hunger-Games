//
//  viViewController.swift
//  Hunger Games
//
//  Created by kbice on 5/10/20.
//  Copyright © 2020 Keller Bice. All rights reserved.
//

import UIKit

class viViewController: UIViewController {

    @IBOutlet weak var first: UILabel!
    var appDelegate: AppDelegate!
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        first.text = "\(String(describing: UserDefaults.standard.string(forKey: "winner")!))"
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func leave(_ sender: Any) {
        appDelegate.MCPHandler.session.disconnect()
        if UserDefaults.standard.bool(forKey: "host") {
            appDelegate.MCPHandler.advertiseSelf(advertise: false)
        }
        performSegue(withIdentifier: "leave", sender: nil)
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
