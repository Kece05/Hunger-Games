//
//  Final4everViewController.swift
//  Hunger Games
//
//  Created by kbice on 10/2/19.
//  Copyright © 2019 Keller Bice. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class Final4everViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, MCBrowserViewControllerDelegate {
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        appDelegate.MCPHandler.browers.dismiss(animated: true, completion: nil)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        appDelegate.MCPHandler.browers.dismiss(animated: true, completion: nil)
    }
    
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
        if pickerData[row] == "10v10" || pickerData[row] == "1v19" {
           names = "10v10"
        } else if pickerData[row] == "3v3" || pickerData[row] == "1v5" {
            names = "3v3"
        } else if pickerData[row] == "5v5" || pickerData[row] == "1v9" {
            names = "5v5"
        } else {
            names = "1v1"
        }
    }
    
    @IBOutlet var modes: UIView!
    var names = ""
    var pickerData: [String] = [String]()
    @IBOutlet weak var hope: UITextView!
    @IBOutlet weak var fancy: UIButton!
    @IBOutlet var view3: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var OTM: UISwitch!
    @IBOutlet weak var HM: UISwitch!
    @IBOutlet weak var im: UISwitch!
    @IBOutlet weak var cm: UISwitch!
    @IBOutlet weak var size: UITextField!
    @IBOutlet weak var gm: UISwitch!
    @IBOutlet weak var pm: UISwitch!
    @IBOutlet var viewss: UIView!
    @IBOutlet weak var mm: UISwitch!
    
    
    @IBAction func pms(_ sender: Any) {
        if HM.isOn && !pm.isOn {
            pickerData = ["1v1", "1v5", "1v9","1v19"]
        } else if pm.isOn {
            pickerData = ["1v∞"," "," "," "]
        } else {
            pickerData = ["1v1", "3v3", "5v5","10v10"]
        }
    
    }
    
    @IBAction func cmd(_ sender: Any) {
        if (cm.isOn) {
            size.alpha = 1
        } else {
            size.alpha = 0
        }
    }
    
    var appDelegate: AppDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modes.alpha = 0
        // Do any additional setup after loading the view.
        UserDefaults.standard.set(false, forKey: "connected")
        let tap = UITapGestureRecognizer(target: self, action: #selector(dis))
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.MCPHandler.setupPeerWithDisplayName(DisplayName: UIDevice.current.name)
        appDelegate.MCPHandler.setupSession()
        
        tap.numberOfTapsRequired = 1 
        self.view3.addGestureRecognizer(tap)
        if let joe = UserDefaults.standard.object(forKey: "OTM") as? Bool{
            OTM.isOn = joe
        }
        
        if let joe = UserDefaults.standard.object(forKey: "pm") as? Bool{
            pm.isOn = joe
        }
        
        if let mama = UserDefaults.standard.object(forKey: "HM") as? Bool {
            HM.isOn = mama
        }
        
        if let mama = UserDefaults.standard.object(forKey: "im") as? Bool {
            im.isOn = mama
        }
        
        if let mama = UserDefaults.standard.object(forKey: "mm") as? Bool {
            mm.isOn = mama
        }
        
        if let mama = UserDefaults.standard.object(forKey: "gm") as? Bool {
            gm.isOn = mama
        }
        
        if let mama = UserDefaults.standard.string(forKey: "size") {
            size.text = mama
        }
        
        if let mama = UserDefaults.standard.object(forKey: "cm") as? Bool {
            cm.isOn = mama
            if (cm.isOn) {
                size.alpha = 1
            } else {
                size.alpha = 0
            }
        }
        size.delegate = self
        appDelegate.MCPHandler.session.disconnect()
        
        if UIScreen.main.nativeBounds.height == 960 {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "sorry", sender: nil)
            }
        }
        self.start.delegate = self
        self.start.dataSource = self
        
        hope.text = "Coins: \(UserDefaults.standard.integer(forKey: "coins"))\nXP: \(UserDefaults.standard.integer(forKey: "xp"))"
        if UserDefaults.standard.string(forKey: "name") == nil {
            UserDefaults.standard.set("bmwC" ,forKey: "name")
            image.image = UIImage(named: "bmwC")
        } else {
            image.image = UIImage(named: UserDefaults.standard.string(forKey: "name")!)
        }
      
        if HM.isOn && !pm.isOn {
            pickerData = ["1v1", "1v5", "1v9","1v19"]
        } else if pm.isOn {
            pickerData = ["1v∞"," "," "," "]
        } else {
            pickerData = ["1v1", "3v3", "5v5","10v10"]
        }
        
        view3.backgroundColor = UIColor.random
        modes.layer.cornerRadius = 10
    }
    
    @IBOutlet weak var start: UIPickerView!
    
    @IBAction func JoinGame(_ sender: Any) {
        if appDelegate.MCPHandler.session != nil {
            appDelegate.MCPHandler.setupBrowser()
            appDelegate.MCPHandler.browers.delegate = self
            self.present(appDelegate.MCPHandler.browers, animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(true)
        if UserDefaults.standard.bool(forKey: "connected") {
            UserDefaults.standard.set(false, forKey: "host")
            do {
                let message = ["data":"1","sender":appDelegate.MCPHandler.peerID!.displayName] as [String : String]
                let messagedata = try JSONSerialization.data(withJSONObject: message, options: .prettyPrinted)
                try appDelegate.MCPHandler.session.send(messagedata, toPeers: appDelegate.MCPHandler.session.connectedPeers, with: .unreliable)
                
            } catch {
                print("didn't work")
            }
            UserDefaults.standard.set(im.isOn, forKey: "im")
            UserDefaults.standard.set(mm.isOn, forKey: "mm")
            self.performSegue(withIdentifier: "lobby", sender: nil)
            
        }
    }
    
    @IBAction func createGame(_ sender: Any) {
        appDelegate.MCPHandler.setupPeerWithDisplayName(DisplayName: UIDevice.current.name)
        appDelegate.MCPHandler.advertiseSelf(advertise: true)
        UserDefaults.standard.set(true, forKey: "host")
        performSegue(withIdentifier: "lobby", sender: nil)
        UserDefaults.standard.set(im.isOn, forKey: "im")
        UserDefaults.standard.set(mm.isOn, forKey: "mm")
    }
    
    @IBAction func cars(_ sender: Any) {
        if UserDefaults.standard.string(forKey: "name")! == "racerC" {
            performSegue(withIdentifier: "mountainC", sender: nil)
        } else {
            performSegue(withIdentifier: UserDefaults.standard.string(forKey: "name")!, sender: nil)
        }
    }
    @objc func dis() {
        self.viewss.endEditing(true)
    }
    
    @IBAction func ssfs(_ sender: Any) {
        if names == "10v10" {
            UserDefaults.standard.set(10, forKey: "gameMode")
        } else if names == "3v3" {
            UserDefaults.standard.set(3, forKey: "gameMode")
        } else if names == "5v5" {
            UserDefaults.standard.set(5, forKey: "gameMode")
        } else {
            UserDefaults.standard.set(1, forKey: "gameMode")
        }
        UserDefaults.standard.set(OTM.isOn, forKey: "OTM")
        UserDefaults.standard.set(HM.isOn, forKey: "HM")
        UserDefaults.standard.set(im.isOn, forKey: "im")
        UserDefaults.standard.set(mm.isOn, forKey: "mm")
        UserDefaults.standard.set(cm.isOn, forKey: "cm")
        UserDefaults.standard.set(gm.isOn, forKey: "gm")
        UserDefaults.standard.set(pm.isOn, forKey: "pm")
        if size.text == "2" || size.text == "1" || size.text == "0" || size.text == "3" || size.text == "4" {
            UserDefaults.standard.set("5", forKey: "size")
        } else if size.text == "" {
            UserDefaults.standard.set("40", forKey: "size")
        } else {
            UserDefaults.standard.set(size.text, forKey: "size")
        }
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "RealGame") as! GameViewController
        if size.text != nil  || !(cm.isOn) {
            self.present(newViewController, animated: false, completion: nil)
        }
    }

    @IBAction func settings(_ sender: Any) {
        animate()
    }
    
    @IBAction func back(_ sender: Any) {
        if HM.isOn && !pm.isOn {
            pickerData = ["1v1", "1v5", "1v9","1v19"]
        } else if pm.isOn {
            pickerData = ["1∞"," "," "," "]
        } else {
            pickerData = ["1v1", "3v3", "5v5","10v10"]
        }
        if (cm.isOn) {
            size.alpha = 1
        } else {
            size.alpha = 0
        }
        animateOut()
    }
    
    func animate() {
        self.view.addSubview(modes)
        modes.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.4) {
            self.modes.alpha = 1
            self.modes.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut() {
        UIView.animate(withDuration: 0.3, animations: {
            self.modes.transform = CGAffineTransform.init(scaleX: 0.1, y: 0.1)
            self.modes.alpha = 0
        }) { (success:Bool) in
            self.modes.removeFromSuperview()
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.viewss.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        size.resignFirstResponder()
        return true
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

