//
//  Ads.swift
//  Hunger Games
//
//  Created by kbice on 7/23/20.
//  Copyright © 2020 Keller Bice. All rights reserved.
//

import UIKit
import GoogleMobileAds

class Ads: UIViewController, GADRewardedAdDelegate, GADBannerViewDelegate {
    
    @IBOutlet weak var xp: UIButton!
    @IBOutlet weak var coins: UIButton!
    var rewardedCoins: GADRewardedAd?
    var rewardedXp: GADRewardedAd?
    var bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerLandscape)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-8752456779554035/4472169924"
        
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        rewardedCoins = GADRewardedAd(adUnitID: "ca-app-pub-8752456779554035/1886315287")
        rewardedCoins?.load(GADRequest())
        rewardedXp = GADRewardedAd(adUnitID: "ca-app-pub-8752456779554035/6482545155")
        rewardedXp?.load(GADRequest())
    }
    
    @IBAction func coins(_ sender: Any) {
        if rewardedCoins?.isReady == true {
            rewardedCoins?.present(fromRootViewController: self, delegate:self)
        }
    }
    
    @IBAction func xp(_ sender: Any) {
        if rewardedXp?.isReady == true {
            rewardedXp?.present(fromRootViewController: self, delegate:self)
        }
    }
    
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        if reward.amount == 15000 {
            UserDefaults.standard.setValue(UserDefaults.standard.integer(forKey: "coins")+15000, forKey: "coins")
        } else {
            UserDefaults.standard.setValue(UserDefaults.standard.integer(forKey: "xp")+10000, forKey: "xp")
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
    }
    */

}
