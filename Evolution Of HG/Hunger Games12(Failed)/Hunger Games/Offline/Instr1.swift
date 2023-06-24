//
//  Instr1.swift
//  Hunger Games
//
//  Created by kbice on 11/10/19.
//  Copyright © 2019 Keller Bice. All rights reserved.
//

import UIKit
import GoogleMobileAds

class Instr1: UIViewController, UIScrollViewDelegate, GADBannerViewDelegate, GADRewardedAdDelegate {
    
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        label.alpha = 0
        fancy.layer.cornerRadius = fancy.frame.height / 4
        fancy.layer.shadowColor = UIColor.blue.cgColor
        fancy.layer.shadowRadius = 2
        fancy.layer.shadowOpacity = 0.5
        fancy.alpha = 1
        fancy.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    var tiem : Timer!
    @IBOutlet weak var fancy: UIButton!
    var gradientLayer: CAGradientLayer!
    var bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerLandscape)
    @IBOutlet weak var label: UILabel!
    var video: GADRewardedAd?
    
    override func viewDidLoad() {
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-8752456779554035/4116236268"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        fancy.alpha = 0
        video = GADRewardedAd(adUnitID: "ca-app-pub-8752456779554035/9668370876")
        video?.load(GADRequest())
        tiem = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ad), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }
    
   
    @objc func ad() {
        if video?.isReady == true {
            video?.present(fromRootViewController: self, delegate:self)
            tiem.invalidate()
        }
    }
    
    @objc func joe() {
        UserDefaults.standard.set(1 ,forKey:"joe")
        performSegue(withIdentifier: "no", sender: nil)
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
                              constant: 0)
          ])
       }

    @IBAction func start(_ sender: Any) {
        if UserDefaults.standard.integer(forKey: "joe") == 1 {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "no", sender: nil)
            }
        } else {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "RealGame") as! GameViewController
            UserDefaults.standard.set(true, forKey: "in")
            UserDefaults.standard.set(true, forKey: "cm")
            self.present(newViewController, animated: false, completion: nil)
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
