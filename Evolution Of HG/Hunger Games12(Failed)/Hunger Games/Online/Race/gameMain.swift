//
//  GameViewController.swift
//  k
//
//  Created by kbice on 5/7/20.
//  Copyright © 2020 Keller Bice. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import MultipeerConnectivity

class gameMain: UIViewController {

    var appDelegate: AppDelegate!
    var count = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let map = UserDefaults.standard.string(forKey: "map")
        if let view = self.view as! SKView? {
            if let scene = GameScene2(fileNamed: "\(map!)") {
                scene.scaleMode = .aspectFill
                view.ignoresSiblingOrder = true
                view.isMultipleTouchEnabled = true
                view.showsFPS = true
                view.showsNodeCount = false
                scene.viewController = self
                view.presentScene(scene)
            }
        }
    }
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
