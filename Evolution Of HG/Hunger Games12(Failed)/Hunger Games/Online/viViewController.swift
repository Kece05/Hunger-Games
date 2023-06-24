//
//  viViewController.swift
//  Hunger Games
//
//  Created by kbice on 5/10/20.
//  Copyright © 2020 Keller Bice. All rights reserved.
//

import UIKit
import GoogleMobileAds

class viViewController: UIViewController, GADBannerViewDelegate {

    var bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerLandscape)
    
    @IBOutlet weak var first: UILabel!
    var appDelegate: AppDelegate!
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(bannerView)
        bannerView.adUnitID = "ca-app-pub-8752456779554035/6871334060"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        
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
