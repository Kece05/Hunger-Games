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
        if UserDefaults.standard.bool(forKey: "wonned") {
            do {
                let message = ["data":appDelegate.MCPHandler.peerID!.displayName, "sender":appDelegate.MCPHandler.peerID!.displayName] as [String : Any]
                let messagedata = try JSONSerialization.data(withJSONObject: message, options: .prettyPrinted)
                try appDelegate.MCPHandler.session.send(messagedata, toPeers: appDelegate.MCPHandler.session.connectedPeers, with: .reliable)
            } catch {
                print("err")
            }
            first.text = "\(String(describing: appDelegate.MCPHandler.peerID!.displayName))"
        } else {
            if count == 0 {
                NotificationCenter.default.addObserver(self, selector: #selector(recivedMode(notification:)), name: NSNotification.Name(rawValue: "DidReciveDataNotification"), object: nil)
            }
            
        }
        UserDefaults.standard.set(true, forKey: "wonned")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func leave(_ sender: Any) {
        appDelegate.MCPHandler.session.disconnect()
        if UserDefaults.standard.bool(forKey: "host") {
            appDelegate.MCPHandler.advertiseSelf(advertise: false)
        }
        performSegue(withIdentifier: "leave", sender: nil)
    }
    
    @objc func recivedMode(notification:NSNotification) {
        count += 1
        let userInfo = notification.userInfo! as Dictionary
        let recivedData:NSData = userInfo["data"] as! NSData
        do {
            let message = try JSONSerialization.jsonObject(with: recivedData as Data, options: .fragmentsAllowed) as! NSDictionary
            if message["senderx"] != nil {
                first.text = message["sender"] as! String
            } 
        } catch {
            print(error)
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
