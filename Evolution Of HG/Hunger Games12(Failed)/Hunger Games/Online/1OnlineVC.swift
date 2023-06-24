//
//  1OnlineVC.swift
//  Hunger Games
//
//  Created by kbice on 5/7/20.
//  Copyright © 2020 Keller Bice. All rights reserved.
//

import UIKit
import GoogleMobileAds

class _OnlineVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, GADBannerViewDelegate {

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
            if selectedOne == "Race" {
                text.placeholder = "Choose map(1-10) or don't and get random map:"
                counts = 1
            } else {
                text.placeholder = "Type Here"
                counts = 0
            }
            do {
                let message = ["Mode":"Game Mode: \(selectedOne)","sender":appDelegate.MCPHandler.peerID!.displayName] as [String : String]
                let messagedata = try JSONSerialization.data(withJSONObject: message, options: .prettyPrinted)
                try appDelegate.MCPHandler.session.send(messagedata, toPeers: appDelegate.MCPHandler.session.connectedPeers, with: .reliable)
            } catch {
            }
        }
    }
    
    var randomMap = String()
    @IBOutlet weak var gameMode: UILabel!
    @IBOutlet weak var start: UIButton!
    @IBOutlet weak var adfsdf: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
    var counts = 0
    @IBOutlet weak var players: UITableView!
    @IBOutlet weak var backs: UIButton!
    @IBOutlet weak var text: UITextField!
    var appDelegate: AppDelegate!
    var playersName = [String]()
    var count = String()
    var pickerData = ["Free-for-All","Lucky One","Race"]
    var selectedOne = "Free-for-All"
    @IBOutlet weak var buttton: UIButton!
    var allowSend = true
    var messages = ["The Chat"]
    var bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerLandscape)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-8752456779554035/4793294625"
        
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
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
            }
        
            players.delegate = self
            players.dataSource = self
            pickerView.delegate = self
            pickerView.dataSource = self
            adfsdf.delegate = self
            adfsdf.dataSource = self
            adfsdf.tag = 2
            text.delegate = self
            players.register(UINib(nibName: "Player", bundle: nil), forCellReuseIdentifier: "customMessageCell")
            adfsdf.register(UINib(nibName: "adsffaf", bundle: nil), forCellReuseIdentifier: "chatMessage")
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
                    let choosenOne = playersName.randomElement()!
                    let message = ["sender":appDelegate.MCPHandler.peerID!.displayName, "Mode":"start", "player":choosenOne] as [String : String]
                    let messagedata = try JSONSerialization.data(withJSONObject: message, options: .prettyPrinted)
                    try appDelegate.MCPHandler.session.send(messagedata, toPeers: appDelegate.MCPHandler.session.connectedPeers, with: .reliable)
                    begin2(winner: choosenOne)
                } else if selectedOne == "Free-for-All" {
                    let message = ["sender":appDelegate.MCPHandler.peerID!.displayName, "Mode":"start"] as [String : String]
                    let messagedata = try JSONSerialization.data(withJSONObject: message, options: .prettyPrinted)
                    try appDelegate.MCPHandler.session.send(messagedata, toPeers: appDelegate.MCPHandler.session.connectedPeers, with: .reliable)
                    begin()
                } else {
                    let random = ["map1","map2","map3","map4","map5","map6","map7","map8","map9","map10"]
                    let choose = random.randomElement()
                    if randomMap == "" || randomMap == "map" {
                        UserDefaults.standard.set(choose!, forKey: "map")
                        randomMap = choose!
                    } else {
                        UserDefaults.standard.set(randomMap, forKey: "map")
                    }
                    let message = ["sender":appDelegate.MCPHandler.peerID!.displayName, "Mode":"start","race":"race","map":randomMap] as [String : String]
                    let messagedata = try JSONSerialization.data(withJSONObject: message, options: .prettyPrinted)
                    try appDelegate.MCPHandler.session.send(messagedata, toPeers: appDelegate.MCPHandler.session.connectedPeers, with: .reliable)
                    begin3()
                }
            } catch {
            }
        }
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
          [NSLayoutConstraint(item: bannerView,
                              attribute: .bottom,
                              relatedBy: .equal,
                              toItem: bottomLayoutGuide,
                              attribute: .top,
                              multiplier: 1,
                              constant: 0),
           NSLayoutConstraint(item: bannerView,
                              attribute: .centerX,
                              relatedBy: .equal,
                              toItem: view,
                              attribute: .centerX,
                              multiplier: 1,
                              constant: -250)
          ])
       }
    
    func begin() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "gamr") as! GameViewControllerOnline
        UserDefaults.standard.set(playersName, forKey: "name")
        self.present(newViewController, animated: false, completion: nil)
        allowSend = false
    }
    
    func begin3() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "gmae") as! gameMain
        UserDefaults.standard.set(playersName, forKey: "name")
        self.present(newViewController, animated: false, completion: nil)
        allowSend = false
    }
    
    func begin2(winner:String) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "game") as! gamecontrol
        let urName = (appDelegate.MCPHandler.peerID!.displayName)
        UserDefaults.standard.set(playersName, forKey: "name")
        UserDefaults.standard.set(winner, forKey: "that")
        
        if winner == urName {
            UserDefaults.standard.set(true, forKey: "player")
        } else {
            UserDefaults.standard.set(false, forKey: "player")
        }
        allowSend = false
        self.present(newViewController, animated: false, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 2 {
            return messages.count
        } else {
            return playersName.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "chatMessage", for: indexPath) as! adsffaf
            cell.textsf.text = messages[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! Player
            cell.Name.text = playersName[indexPath.row]
            return cell
        }
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
                    if message["race"] != nil {
                        UserDefaults.standard.set(message["map"]!, forKey: "map")
                        begin3()
                    } else if message["Mode"] as? String == "start" {
                        if message["player"] != nil {
                            begin2(winner:message["player"] as! String)
                        } else {
                            begin()
                        }
                    } else if message["message"] != nil {
                        messages.append(message["message"] as! String)
                        updateTableview()
                    } else {
                        if message["sender"] != nil {
                            name = message["sender"] as! String
                            gameMode.text = message["Mode"] as? String
                        }
                    }
                }
            } catch {
            }
            if mess["Car"] == nil {
                playersName.append(name)
                playersName = playersName.removingDuplicates()
                if count != name {
                    do {
                        let message = ["data":"1","sender":appDelegate.MCPHandler.peerID!.displayName] as [String : String]
                        let messagedata = try JSONSerialization.data(withJSONObject: message, options: .prettyPrinted)
                        try appDelegate.MCPHandler.session.send(messagedata, toPeers: appDelegate.MCPHandler.session.connectedPeers, with: .reliable)
                    } catch {
                    }
                    updateTableview()
                    count = name
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        text.resignFirstResponder()
        if counts == 1  && (text.text! == "1" || text.text! == "2" || text.text! == "3" || text.text! == "4" || text.text! == "5" || text.text! == "6" || text.text! == "7" || text.text! == "8" || text.text! == "9" || text.text! == "10"){
            randomMap = "map\(text.text!)"
            text.placeholder = "Type Here"
            counts += 1
        } else {
            text.placeholder = "Enter a number 1-10"
        }
            do {
                let message = ["data":"1","sender":appDelegate.MCPHandler.peerID!.displayName,"message":text.text!] as [String : String]
                let messagedata = try JSONSerialization.data(withJSONObject: message, options: .prettyPrinted)
                try appDelegate.MCPHandler.session.send(messagedata, toPeers: appDelegate.MCPHandler.session.connectedPeers, with: .reliable)
            } catch {
            }
            messages.append(text.text!)
            text.text = ""
            updateTableview()
            return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        text.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func updateTableview(){
        if allowSend {
            self.players.reloadData()
            self.adfsdf.reloadData()
            
            if self.players.contentSize.height > self.players.frame.size.height {
                players.scrollToRow(at: NSIndexPath(row: playersName.count - 1, section: 0) as IndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
            }
            
            if self.adfsdf.contentSize.height > self.adfsdf.frame.size.height {
                adfsdf.scrollToRow(at: NSIndexPath(row: messages.count - 1, section: 0) as IndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
            }
        }
    }

}
