//
//  HuntInPack.swift
//  Hunger Games
//
//  Created by kbice on 8/27/19.
//  Copyright © 2019 Keller Bice. All rights reserved.
//
import SpriteKit

class HuntInPack {
    
    let hunter1 = SKNode()
    let defaults = UserDefaults.standard
    
    init(goto:SKSpriteNode, main:SKSpriteNode, Frames:Double, Area:String,Name:Int) {
        let disx = main.position.x - goto.position.x
        let disy = main.position.y - goto.position.y
        let distance = sqrt(((disx)*(disx))+((disy)*(disy)))
        let contains = 0...1000 ~= distance
        let angles = CGVector(dx:goto.position.y - main.position.y , dy:goto.position.x -
            main.position.x)
        if contains {
            hunter1.position = main.position
            let angle = atan2(angles.dx, angles.dy)
            if UserDefaults.standard.integer(forKey: "xp") < 5000 {
                main.run(SKAction.rotate(toAngle: angle-CGFloat.random(in: 0.7853981634...2.35619449), duration:0.6))
            } else if UserDefaults.standard.integer(forKey: "xp") < 25000 {
                main.run(SKAction.rotate(toAngle: angle-CGFloat.random(in: 1.178097245...1.963495409), duration:0.3))
            } else if UserDefaults.standard.integer(forKey: "xp") < 500000 {
                main.run(SKAction.rotate(toAngle: angle-CGFloat.random(in: 1.378097245...1.763495409), duration:0.3))
            } else if UserDefaults.standard.integer(forKey: "xp") < 75000 {
                main.run(SKAction.rotate(toAngle: angle-CGFloat.random(in: 1.1478097245...1.663495409), duration:0.3))
            } else {
                main.run(SKAction.rotate(toAngle: angle-1.570796327, duration:0.05))
            }
        } else {
            UserDefaults.standard.set(true, forKey: main.name!)
            let angle = atan2(angles.dx, angles.dy)
            main.run(SKAction.rotate(toAngle: (angle-1.5707963268), duration: 0.2))
            var speed = CGFloat(0)
            speed = 125.000107293380949/70
            let dx = Double((angle-speed-10) * cos(main.zRotation+1.5707963268))
            let dy = Double((angle-speed-10) * sin(main.zRotation+1.5707963268))
            hunter1.position = CGPoint(x: (Double(main.position.x) - dx), y: (Double(main.position.y) - dy))
        }
    }
}
