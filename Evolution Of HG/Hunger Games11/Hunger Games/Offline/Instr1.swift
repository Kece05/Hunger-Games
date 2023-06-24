//
//  Instr1.swift
//  Hunger Games
//
//  Created by kbice on 11/10/19.
//  Copyright © 2019 Keller Bice. All rights reserved.
//

import UIKit

class Instr1: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var fancy: UIButton!
    var gradientLayer: CAGradientLayer!
    
    override func viewDidLoad() {
        if UIScreen.main.nativeBounds.height == 960 {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "sorry", sender: nil)
            }
        }
        if UserDefaults.standard.integer(forKey: "joe") == 1 {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "no", sender: nil)
            }
        }

        fancy.layer.cornerRadius = fancy.frame.height / 4
        fancy.layer.shadowColor = UIColor.blue.cgColor
        fancy.layer.shadowRadius = 2
        fancy.layer.shadowOpacity = 0.5
        fancy.layer.shadowOffset = CGSize(width: 0, height: 0)
        createGradientLayer()
        // Do any additional setup after loading the view.
    }
    
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
     
        gradientLayer.frame = self.view.bounds
     
        gradientLayer.colors = [UIColor.black.cgColor,UIColor.systemBlue.cgColor,UIColor.black.cgColor]
     
        self.view.layer.insertSublayer(gradientLayer, at: 1)
    }
    
    @objc func joe() {
        UserDefaults.standard.set(1 ,forKey:"joe")
        performSegue(withIdentifier: "no", sender: nil)
    }

    @IBAction func start(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "RealGame") as! GameViewController
        UserDefaults.standard.set(true, forKey: "in")
        UserDefaults.standard.set(true, forKey: "cm")
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
