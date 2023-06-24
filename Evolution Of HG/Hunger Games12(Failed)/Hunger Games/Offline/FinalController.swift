//
//  FinalController.swift
//  Hunger Games
//
//  Created by kbice on 9/26/19.
//  Copyright © 2019 Keller Bice. All rights reserved.
//

import UIKit
import GoogleMobileAds

class FinalController: UIViewController, GADBannerViewDelegate {
    
    var bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerLandscape)

    @IBOutlet weak var Kills: UILabel!
    @IBOutlet weak var XP: UILabel!
    @IBOutlet weak var Coins: UILabel!
    var xps = 1
    let please = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-8752456779554035/9297067293"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        
        if please.bool(forKey: "win") {
            Kills.text = "Victory Is Yours!\n\nKilled: \(please.integer(forKey: "kills")-1)"
            xps = please.integer(forKey: "kills")*5
        } else {
            Kills.text = "\n\nKilled: \(please.integer(forKey: "kills")-1)"
            xps = please.integer(forKey: "kills")*2
        }
        if !UserDefaults.standard.bool(forKey: "cm") {
            XP.text = "XP Earned: \(please.integer(forKey: "place")*xps)"
            please.set((please.integer(forKey: "xp")+please.integer(forKey: "place")*xps), forKey: "xp")
            please.set((please.integer(forKey: "coins")+please.integer(forKey: "place")+please.integer(forKey: "kills")*(xps*please.integer(forKey: "kills")-1)/2), forKey: "coins")
            Coins.text = "Coin(s) Earned: \((please.integer(forKey: "place")+please.integer(forKey: "kills")*(xps*please.integer(forKey: "kills")-1)/2))"
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
                              constant: 0)
          ])
       }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
     ca-app-pub-8752456779554035/9297067293
    }
    */

}

