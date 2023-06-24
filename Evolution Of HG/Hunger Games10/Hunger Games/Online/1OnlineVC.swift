//
//  1OnlineVC.swift
//  Hunger Games
//
//  Created by kbice on 5/7/20.
//  Copyright © 2020 Keller Bice. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class _OnlineVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
       
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
       
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component:Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if allowSend {
            selectedOne = pickerData[row]
            gameMode.text = "Game Mode: \(pickerData[row])"
            do {
                let message = ["Mode":"Game Mode: \(selectedOne)","sender":appDelegate.MCPHandler.peerID!.displayName] as [String : String]
                let messagedata = try JSONSerialization.data(withJSONObject: message, options: .prettyPrinted)
                try appDelegate.MCPHandler.session.send(messagedata, toPeers: appDelegate.MCPHandler.session.connectedPeers, with: .reliable)
            } catch {
                print("didn't work")
            }
        }
    }

    @IBOutlet weak var gameMode: UILabel!
    @IBOutlet weak var start: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var players: UITableView!
    @IBOutlet weak var backs: UIButton!
    var appDelegate: AppDelegate!
    var playersName = [String]()
    var count = String()
    var pickerData = ["Free-for-All","Lucky One"]
    var selectedOne = "Free-for-All"
    @IBOutlet weak var buttton: UIButton!
    var allowSend = true

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        allowSend = true
        if allowSend {
            UserDefaults.standard.set(false, forKey: "Ingame")
            if !UserDefaults.standard.bool(forKey: "host") {
                start.alpha = 0.0
                pickerView.alpha = 0.0
            }
            appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            do {
                let message = ["Mode":"Game Mode: 1v1","sender":appDelegate.MCPHandler.peerID!.displayName] as [String : String]
                let messagedata = try JSONSerialization.data(withJSONObject: message, options: .prettyPrinted)
                try appDelegate.MCPHandler.session.send(messagedata, toPeers: appDelegate.MCPHandler.session.connectedPeers, with: .reliable)
            } catch {
                print(error)
            }
        
            players.delegate = self
            players.dataSource = self
            pickerView.delegate = self
            pickerView.dataSource = self
            players.register(UINib(nibName: "Player", bundle: nil), forCellReuseIdentifier: "customMessageCell")
            playersName.append(appDelegate.MCPHandler.peerID!.displayName)
            NotificationCenter.default.addObserver(self, selector: #selector(recivedData(notification:)), name: NSNotification.Name(rawValue: "DidReciveDataNotification"), object: nil)
        }
    }
    
    @IBAction func back(_ sender: Any) {
        appDelegate.MCPHandler.session.disconnect()
        if UserDefaults.standard.bool(forKey: "host") {
            appDelegate.MCPHandler.advertiseSelf(advertise: false)
        }
        performSegue(withIdentifier: "bye", sender: nil)
    }
    
    @IBAction func start(_ sender: Any) {
        if allowSend {
            do {
                if selectedOne == "Lucky One" {
                    let message = ["sender":appDelegate.MCPHandler.peerID!.displayName, "Mode":"start", "player":playersName.randomElement()!] as [String : String]
                    let messagedata = try JSONSerialization.data(withJSONObject: message, options: .prettyPrinted)
                    try appDelegate.MCPHandler.session.send(messagedata, toPeers: appDelegate.MCPHandler.session.connectedPeers, with: .reliable)
                } else {
                    let message = ["sender":appDelegate.MCPHandler.peerID!.displayName, "Mode":"start"] as [String : String]
                    let messagedata = try JSONSerialization.data(withJSONObject: message, options: .prettyPrinted)
                    try appDelegate.MCPHandler.session.send(messagedata, toPeers: appDelegate.MCPHandler.session.connectedPeers, with: .reliable)
                }
            } catch {
                print(error)
            }
            begin()
        }
    }
    
    func begin() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "gamr") as! GameViewControllerOnline
        UserDefaults.standard.set(playersName, forKey: "name")
        self.present(newViewController, animated: false, completion: nil)
        allowSend = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! Player
        cell.Name.text = playersName[indexPath.row]
        return cell
    }
    
    @objc func recivedData(notification:NSNotification) {
        if allowSend {
            let userInfo = notification.userInfo! as Dictionary
            let recivedData:NSData = userInfo["data"] as! NSData
            var name = String()
            var mess = NSDictionary()
            do {
                let message = try JSONSerialization.jsonObject(with: recivedData as Data, options: .fragmentsAllowed) as! NSDictionary
                mess = message
                if message["Car"] == nil {
                    if message["Mode"] as? String == "start" {
                        if message["player"] != nil {
                            UserDefaults.standard.set(message["player"], forKey: "player")
                        }
                    } else {
                        if  message["sender"] != nil {
                            name = message["sender"] as! String
                            gameMode.text = message["Mode"] as? String
                        }
                    }
                }
            } catch {
                print(error)
            }
            if  mess["Car"] == nil {
                playersName.append(name)
                playersName = playersName.removingDuplicates()
                if count != name {
                    do {
                        let message = ["data":"1","sender":appDelegate.MCPHandler.peerID!.displayName] as [String : String]
                        let messagedata = try JSONSerialization.data(withJSONObject: message, options: .prettyPrinted)
                        try appDelegate.MCPHandler.session.send(messagedata, toPeers: appDelegate.MCPHandler.session.connectedPeers, with: .reliable)
                    } catch {
                        print(error)
                    }
                     updateTableview()
                    count = name
                }
            }
        }
    }
    
    func updateTableview(){
        if allowSend {
            self.players.reloadData()
         
            if self.players.contentSize.height > self.players.frame.size.height {
                players.scrollToRow(at: NSIndexPath(row: playersName.count - 1, section: 0) as IndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
            }
        }
    }

}
