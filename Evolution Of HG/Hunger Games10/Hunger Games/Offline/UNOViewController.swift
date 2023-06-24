//
//  UNOViewController.swift
//  Hunger Games
//
//  Created by kbice on 8/18/19.
//  Copyright © 2019 Keller Bice. All rights reserved.
//

import UIKit

class UNOViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
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
        if pickerView.tag == 3 {
            if pickerData[row] == "Common Pistol" {
                iamge.setBackgroundImage(UIImage(named: "GreenPistolP"), for: .normal)
                three = "GreenPistolP"
            } else if pickerData[row] == "Common Spear" {
                iamge.setBackgroundImage(UIImage(named: "GreenSpearSP"), for: .normal)
                three = "GreenSpearSP"
            } else if pickerData[row] == "Rare Machine Gun" {
                iamge.setBackgroundImage(UIImage(named: "RareMachineG"), for: .normal)
                three = "RareMachineG"
            } else if pickerData[row] == "Rare Spear"  {
                iamge.setBackgroundImage(UIImage(named: "RareSpearSP"), for: .normal)
                three = "RareSpearSP"
            } else if pickerData[row] == "Mythical Machine Gun" {
                iamge.setBackgroundImage(UIImage(named: "MythicalMachineG"), for: .normal)
                three = "MythicalMachineG"
            } else if pickerData[row] == "Mythical Shotgun" {
                iamge.setBackgroundImage(UIImage(named: "MythicalShotgunG"), for: .normal)
                three = "MythicalShotgunG"
            } else if pickerData[row] == "Epic Sniper" {
                iamge.setBackgroundImage(UIImage(named: "EpicSniperG"), for: .normal)
                three = "EpicSniperG"
            } else if pickerData[row] == "Epic Sword" {
                iamge.setBackgroundImage(UIImage(named: "EpicSwordS"), for: .normal)
                three = "EpicSwordS"
            } else if pickerData[row] == "Legendary Sniper" {
                iamge.setBackgroundImage(UIImage(named: "LegendarySniperG"), for: .normal)
                three = "LegendarySniperG"
            } else if pickerData[row] == "Legendary Sword" {
                iamge.setBackgroundImage(UIImage(named: "LegendarySwordS"), for: .normal)
                three = "LegendarySwordS"
            } else if pickerData[row] == "Mini Gun" {
                iamge.setBackgroundImage(UIImage(named: "1M"), for: .normal)
                three = "1M"
            }
        } else if pickerView.tag == 2 {
            if pickerData[row] == "Common Pistol" {
                image2.setBackgroundImage(UIImage(named: "GreenPistolP"), for: .normal)
                two = "GreenPistolP"
            } else if pickerData[row] == "Common Spear" {
                image2.setBackgroundImage(UIImage(named: "GreenSpearSP"), for: .normal)
                two = "GreenSpearSP"
            } else if pickerData[row] == "Rare Machine Gun" {
                image2.setBackgroundImage(UIImage(named: "RareMachineG"), for: .normal)
                two = "RareMachineG"
            } else if pickerData[row] == "Rare Spear"  {
                image2.setBackgroundImage(UIImage(named: "RareSpearSP"), for: .normal)
                two = "RareSpearSP"
            } else if pickerData[row] == "Mythical Machine Gun" {
                image2.setBackgroundImage(UIImage(named: "MythicalMachineG"), for: .normal)
                two = "MythicalMachineG"
            } else if pickerData[row] == "Mythical Shotgun" {
                image2.setBackgroundImage(UIImage(named: "MythicalShotgunG"), for: .normal)
                two = "MythicalShotgunG"
            } else if pickerData[row] == "Epic Sniper" {
                image2.setBackgroundImage(UIImage(named: "EpicSniperG"), for: .normal)
                two = "EpicSniperG"
            } else if pickerData[row] == "Epic Sword" {
                image2.setBackgroundImage(UIImage(named: "EpicSwordS"), for: .normal)
                two = "EpicSwordS"
            } else if pickerData[row] == "Legendary Sniper" {
                image2.setBackgroundImage(UIImage(named: "LegendarySniperG"), for: .normal)
                two = "LegendarySniperG"
            } else if pickerData[row] == "Legendary Sword" {
                image2.setBackgroundImage(UIImage(named: "LegendarySwordS"), for: .normal)
                two = "LegendarySwordS"
            } else if pickerData[row] == "Mini Gun" {
                image2.setBackgroundImage(UIImage(named: "1M"), for: .normal)
                two = "1M"
            }
        } else if pickerView.tag == 1 {
            if pickerData[row] == "Common Pistol" {
                image1.setBackgroundImage(UIImage(named: "GreenPistolP"), for: .normal)
                one = "GreenPistolP"
            } else if pickerData[row] == "Common Spear" {
                image1.setBackgroundImage(UIImage(named: "GreenSpearSP"), for: .normal)
                one = "GreenSpearSP"
            } else if pickerData[row] == "Rare Machine Gun" {
                image1.setBackgroundImage(UIImage(named: "RareMachineG"), for: .normal)
                one = "RareMachineG"
            } else if pickerData[row] == "Rare Spear"  {
                image1.setBackgroundImage(UIImage(named: "RareSpearSP"), for: .normal)
                one = "RareSpearSP"
            } else if pickerData[row] == "Mythical Machine Gun" {
                image1.setBackgroundImage(UIImage(named: "MythicalMachineG"), for: .normal)
                one = "MythicalMachineG"
            } else if pickerData[row] == "Mythical Shotgun" {
                image1.setBackgroundImage(UIImage(named: "MythicalShotgunG"), for: .normal)
                one = "MythicalShotgunG"
            } else if pickerData[row] == "Epic Sniper" {
                image1.setBackgroundImage(UIImage(named: "EpicSniperG"), for: .normal)
                one = "EpicSniperG"
            } else if pickerData[row] == "Epic Sword" {
                image1.setBackgroundImage(UIImage(named: "EpicSwordS"), for: .normal)
                one = "EpicSwordS"
            } else if pickerData[row] == "Legendary Sniper" {
                image1.setBackgroundImage(UIImage(named: "LegendarySniperG"), for: .normal)
                one = "LegendarySniperG"
            } else if pickerData[row] == "Legendary Sword" {
                image1.setBackgroundImage(UIImage(named: "LegendarySwordS"), for: .normal)
                one = "LegendarySwordS"
            } else if pickerData[row] == "Mini Gun" {
                image1.setBackgroundImage(UIImage(named: "1M"), for: .normal)
                one = "1M"
            }
        }
    }
    
    @IBOutlet weak var iamge: UIButton!
    @IBOutlet weak var image2: UIButton!
    @IBOutlet weak var image1: UIButton!
    @IBOutlet var ad: UIView!
    var pickerData: [String] = [String]()
    var one = String()
    var two = String()
    var three = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        ad.addGestureRecognizer(gesture)
        gesture.numberOfTapsRequired = 2
        self.picker.delegate = self
        self.picker.dataSource = self
        self.Picker2.delegate = self
        self.Picker2.dataSource = self
        self.pickerr2.delegate = self
        self.pickerr2.dataSource = self
        picker.tag = 1
        pickerr2.tag = 2
        Picker2.tag = 3
        if UserDefaults.standard.string(forKey: "1") != nil {
            image1.setBackgroundImage(UIImage(named: UserDefaults.standard.string(forKey: "1")!), for: .normal)
            one = UserDefaults.standard.string(forKey: "1")!
        } else if UserDefaults.standard.string(forKey: "1") == nil {
            image1.setBackgroundImage(UIImage(named: "GreenPistolP"), for: .normal)
            one = "GreenPistolP"
        }
        
        if UserDefaults.standard.string(forKey: "2") != nil {
            image2.setBackgroundImage(UIImage(named: UserDefaults.standard.string(forKey: "2")!), for: .normal)
            two = UserDefaults.standard.string(forKey: "2")!
        } else if UserDefaults.standard.string(forKey: "2") == nil {
            image2.setBackgroundImage(UIImage(named: "GreenPistolP"), for: .normal)
            two = "GreenPistolP"
        }
        
        if UserDefaults.standard.string(forKey: "3") != nil {
            iamge.setBackgroundImage(UIImage(named: UserDefaults.standard.string(forKey: "3")!), for: .normal)
            three = UserDefaults.standard.string(forKey: "3")!
        } else if UserDefaults.standard.string(forKey: "3") == nil {
            iamge.setBackgroundImage(UIImage(named: "GreenPistolP"), for: .normal)
            three = "GreenPistolP"
        }
    
        pickerData = ["Common Pistol", "Common Spear", "Rare Machine Gun", "Rare Spear", "Mythical Machine Gun", "Mythical Shotgun", "Epic Sniper", "Epic Sword", "Legendary Sniper", "Legendary Sword", "Mini Gun"]
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var Picker2: UIPickerView!
    @IBOutlet weak var pickerr2: UIPickerView!
    
    @objc func tapped() {
        UserDefaults.standard.set(one, forKey: "1")
        UserDefaults.standard.set(two, forKey: "2")
        UserDefaults.standard.set(three, forKey: "3")
        UserDefaults.standard.set("racerC", forKey: "name")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "cool") as! Final4everViewController
        self.present(newViewController, animated: false, completion: nil)
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
