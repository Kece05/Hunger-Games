//
//  GameScene.swift
//  k
//
//  Created by kbice on 5/7/20.
//  Copyright © 2020 Keller Bice. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScen: SKScene, SKPhysicsContactDelegate {
    
    var health = CGFloat(200)
    var time = 180
    var cam = SKCameraNode()
    let base = SKShapeNode(circleOfRadius: 150)
    let joy = SKShapeNode(circleOfRadius: 75)
    let df = SKShapeNode()
    var rotation = CGFloat(0)
    let nimation = SKAction.animate(with: [SKTexture(imageNamed: "1M"),SKTexture(imageNamed: "2M"),SKTexture(imageNamed: "3M")], timePerFrame: 0.4)
    var disx = CGFloat()
    var disy = CGFloat()
    var kills = 0
    var move = false
    var killCount = SKLabelNode()
    var distance = CGFloat()
    var now = String()
    var x = -800
    var y = -200
    var hide = false
    var gameTimer: Timer!
    var timer : Timer!
    var starting = CGPoint()
    var player = SKLabelNode()
    var swords = CGFloat()
    let rand = 100
    var numb = 1.0
    var textur = SKTexture()
    var thisIsfun = 1.0
    var anotherone = 0
    var reallyWantoSayIt = 0.0
    var SomeMuchVars = 0.0
    let map = SKNode()
    var mapView = SKShapeNode(circleOfRadius: 150)
    var cam2 = SKCameraNode()
    let topLayer = SKTileMapNode(tileSet: SKTileSet(named: "Sample Grid Tile Set")!, columns: 264, rows: 264, tileSize: CGSize(width: 128, height: 128))
    let shores = SKTileMapNode(tileSet: SKTileSet(named: "Sample Grid Tile Set")!, columns: 262, rows: 262, tileSize: CGSize(width: 128, height: 128))
    let stopping = SKTileMapNode(tileSet: SKTileSet(named: "Sample Grid Tile Set")!, columns: 261, rows: 261, tileSize: CGSize(width: 128, height: 128))
    var killLabel = SKLabelNode()
    var inve1 = SKSpriteNode()
    var inve2 = SKSpriteNode()
    var inve3 = SKSpriteNode()
    var healthBarT = SKSpriteNode()
    var healthBarB = SKSpriteNode()
    var fireButton = SKShapeNode(circleOfRadius: 125)
    var copy1 = SKShapeNode(rectOf: CGSize(width: 150, height: 150))
    var copy2 = SKShapeNode(rectOf: CGSize(width: 150, height: 150))
    var copy3 = SKShapeNode(rectOf: CGSize(width: 150, height: 150))
    var whichFire = String()
    lazy var ply : SKSpriteNode? = {
        return self.childNode(withName: "//player") as? SKSpriteNode
    }()
    
    override func didMove(to view: SKView) {
        self.view?.showsPhysics = false
        let textures = SKTextureAtlas(named: "Cars").textureNames
        self.ply!.name = "ply"
        var data = UserDefaults.standard.string(forKey: "name")!
        ply!.texture = SKTexture(imageNamed: data)
        ply!.size = SKTexture(imageNamed: data).size()
        self.anchorPoint = .zero
        physicsWorld.speed = 0.9
        if ply!.texture!.name == "mountainC" {
            ply!.scale(to: CGSize(width: ply!.size.width/6, height: ply!.size.height/6))
            for i in 1...3 {
                if let childp = ply?.childNode(withName: String(i)) as? SKSpriteNode {
                    if i == 1 {
                        childp.position = CGPoint(x: 160, y: 340.5)
                        childp.size = CGSize(width: childp.size.width*1.5, height: childp.size.height*1.5)
                    } else if i == 2 {
                        childp.position = CGPoint(x: 20, y: 425)
                        childp.size = CGSize(width: childp.size.width*2, height: childp.size.height*2)
                    } else {
                        childp.position = CGPoint(x: -160, y: 340.5)
                        childp.size = CGSize(width: childp.size.width*1.5, height: childp.size.height*1.5)
                    }
                }
            }
        } else if ply!.texture!.name == "racerC" {
            ply!.scale(to: CGSize(width: ply!.size.width/4, height: ply!.size.height/4))
            for i in 1...3 {
                if let childp = ply?.childNode(withName: String(i)) as? SKSpriteNode {
                    var game = String()
                    if i == 1 {
                        game = UserDefaults.standard.string(forKey: "1")!
                    } else if i == 2 {
                        game = UserDefaults.standard.string(forKey: "2")!
                    } else {
                        game = UserDefaults.standard.string(forKey: "3")!
                    }

                    childp.texture = SKTexture(imageNamed: game)
                    childp.size = CGSize(width: childp.size.width*1.5, height: childp.size.height*1.5)
                    if i == 1 {
                        childp.position = CGPoint(x: 150, y: 440)
                    } else if i == 2 {
                        if childp.texture!.name == "LegendarySniperG" || childp.texture?.name == "EpicSniperG" {
                            childp.position = CGPoint(x: 20, y: 440)
                        } else {
                            childp.position = CGPoint(x: 0, y: 440)
                        }
                    } else {
                        childp.position = CGPoint(x: -150, y: 440)
                    }
                    if childp.texture!.name == "LegendarySniperG" || childp.texture?.name == "EpicSniperG" {
                        childp.size = CGSize(width: childp.size.width*2, height: childp.size.height*2)
                    } else {
                        childp.size = CGSize(width: childp.size.width*1.5, height: childp.size.height*1.5)
                    }
                }
            }
        } else {
            ply!.scale(to: CGSize(width: ply!.size.width/3, height: ply!.size.height/3))
        }
        killCount = self.childNode(withName: "killcount") as! SKLabelNode
        killLabel = self.childNode(withName: "gameCount") as! SKLabelNode
        
        physicsWorld.contactDelegate = self
        cam = self.childNode(withName: "follow") as! SKCameraNode
        player = self.childNode(withName: "players") as! SKLabelNode
        cam2 = self.childNode(withName: "f") as! SKCameraNode
        mapView.name = "show"
        map.xScale = 1
        map.yScale = 1
        self.ply?.physicsBody = SKPhysicsBody(rectangleOf: ply!.size, center: ply!.position)
        self.ply!.physicsBody?.categoryBitMask = collider.player.rawValue
        self.ply!.physicsBody?.contactTestBitMask = collider.player.rawValue | collider.bullet.rawValue
        self.ply!.physicsBody?.collisionBitMask = collider.player.rawValue | collider.bullet.rawValue
        let tileSet = SKTileSet(named: "Sample Grid Tile Set")!
        if (UIDevice.current.model.prefix(3)) == "iPh" {
            numb = 1.75
            SomeMuchVars = 1.65
            anotherone = 100
            reallyWantoSayIt = 15.0
        } else {
            SomeMuchVars = 1.2
            thisIsfun = 1.4
            reallyWantoSayIt = 25.0
        }
        cam2.xScale = CGFloat(Double(rand)*0.018360606060606)
        cam2.yScale = CGFloat(Double(rand)*0.018360606060606)
        
        let grassTiles = tileSet.tileGroups.first { $0.name == "Grass"}
        let cobblestoneTitle = tileSet.tileGroups.first { $0.name == "Cobblestone"}
        stopping.numberOfColumns = rand
        stopping.numberOfRows = rand
        stopping.fill(with: cobblestoneTitle)
        map.addChild(stopping)
        stopping.anchorPoint = CGPoint(x:0.5,y:0.5)
        
        topLayer.numberOfColumns = rand-3
        topLayer.numberOfRows = rand-3
        topLayer.fill(with: grassTiles)
        
        self.camera = cam
        self.addChild(joy)
        self.joy.position.x = ply!.position.x + 600
        self.joy.position.y = ply!.position.y - 600
        self.joy.fillColor = UIColor.white
        self.joy.strokeColor = UIColor.white
        self.joy.zPosition = 2
        
        self.addChild(base)
        self.base.position.x = ply!.position.x - 500
        self.base.position.y = ply!.position.y - 100
        self.base.fillColor = UIColor.gray
        self.base.strokeColor = UIColor.gray
        self.base.zPosition = 1
        self.base.alpha = 0.2
        
        self.fireButton.position.x = ply!.position.x + 800
        self.fireButton.position.y = ply!.position.y - 200
        self.fireButton.fillColor = UIColor.darkGray
        self.fireButton.strokeColor = UIColor.darkGray
        self.fireButton.zPosition = 1
        self.fireButton.alpha = 0.4
        self.fireButton.name = "fire"
        self.addChild(fireButton)
        self.joy.alpha = 0.2
        self.mapView.position.x = ply!.position.x + 500
        self.mapView.position.y = ply!.position.y + 100
        self.mapView.zPosition = 3
        
        self.healthBarT.color = UIColor.green
        self.healthBarB.color = UIColor.red
        self.healthBarT.size = CGSize(width: 400, height: 50)
        self.healthBarB.size = CGSize(width: 400, height: 50)
        self.healthBarT.zPosition = 7
        self.healthBarB.zPosition = 7
        self.healthBarT.position = CGPoint(x:ply!.position.x, y:ply!.position.y+500)
        self.healthBarB.position = CGPoint(x:ply!.position.x, y:ply!.position.y+500)
        self.addChild(healthBarB)
        self.addChild(healthBarT)
        map.addChild(topLayer)
        self.addChild(map)
        
        copy1.strokeColor = UIColor.black
        copy1.lineWidth = 1
        copy1.fillColor = UIColor(displayP3Red: 142, green: 144, blue:153, alpha: 0.5)
        copy1.zPosition = -1
        
        copy2.strokeColor = UIColor.black
        copy2.fillColor = UIColor(displayP3Red: 142, green: 144, blue:153, alpha: 0.5)
        copy2.zPosition = -1
        copy1.lineWidth = 1
        
        copy3.strokeColor = UIColor.black
        copy3.fillColor = UIColor(displayP3Red: 142, green: 144, blue:153, alpha: 0.5)
        copy3.zPosition = -1
        copy1.lineWidth = 1
        
        self.inve2.zPosition = 8
        self.inve2.position = ply!.position
        self.inve2.name = "2"
        self.inve2.size = CGSize(width: 150, height: 150)
        self.inve2.color = UIColor(displayP3Red: 142, green: 144, blue:153, alpha: 0.5)
        self.addChild(inve2)
        copy1.name = "2"
        copy1.position = inve2.position
        inve2.addChild(copy1)
        
        self.inve3.color = UIColor(displayP3Red: 142, green: 144, blue:153, alpha: 0.5)
        self.inve3.zPosition = 8
        self.inve3.position = CGPoint(x: ply!.position.x - 400, y: ply!.position.y)
        self.inve3.name = "3"
        self.inve3.size = CGSize(width: 150, height: 150)
        inve2.addChild(inve3)
        copy2.name = "3"
        copy2.position = CGPoint(x: inve3.position.x + 400, y: inve3.position.y)
        inve3.addChild(copy2)
        
        self.inve1.color = UIColor(displayP3Red: 142, green: 144, blue:153, alpha: 0.5)
        self.inve1.zPosition = 8
        self.inve1.size = CGSize(width: 150, height: 150)
        self.inve1.position = CGPoint(x: ply!.position.x + 400, y: ply!.position.y)
        self.inve1.name = "I1"
        inve2.addChild(inve1)
        copy3.name = "1"
        copy3.position = CGPoint(x: inve1.position.x - 400, y: inve1.position.y)
        inve1.addChild(copy3)
        
        self.mapView.position = CGPoint(x: ply!.position.x+600, y: ply!.position.y+600)
        self.mapView.fillColor = UIColor.white
        self.mapView.strokeColor = UIColor.black
        
        self.mapView.zPosition = 6
        self.addChild(mapView)
        topLayer.anchorPoint = CGPoint(x:0.5,y:0.5)
        
        mapView.zPosition = 10
        inve2.zPosition = 10
        fireButton.zPosition = 10
        joy.zPosition = 10
        base.zPosition = 10
        healthBarB.zPosition = 10
        healthBarT.zPosition = 10
        killCount.zPosition = 10
        killLabel.zPosition = 10
        swords += 1.2
        
        for i in self.children {
            if let text = i as? SKSpriteNode {

                for i in 1...3 {
                    if let child = text.childNode(withName: String(i)) as? SKSpriteNode {
                        if text.texture?.name == "bmwC" {
                            if i == 1 || i == 3 {
                                child.texture = SKTexture(imageNamed: "EpicSwordS")
                            } else {
                                if Int.random(in: 1...2) == 1 {
                                    child.texture = SKTexture(imageNamed: "GreenSpearSP")
                                } else {
                                    child.texture = SKTexture(imageNamed: "GreenSpearSP")
                                }
                            }

                        } else if text.texture?.name == "bumbleC" {
                            if i == 1 || i == 3 {
                                child.texture = SKTexture(imageNamed: "LegendarySwordS")
                            } else {
                                child.texture = SKTexture(imageNamed: "RareSpearSP")
                            }
                        } else if text.texture?.name == "ferrieC" {
                            if i == 1 {
                                child.texture = SKTexture(imageNamed: "LegendarySwordS")
                            } else if i == 3 {
                                child.texture = SKTexture(imageNamed: "EpicSwordS")
                            } else {
                                child.texture = SKTexture(imageNamed: "RareMachineG")
                            }
                        } else if text.texture?.name == "lamboC" {
                            if i == 1 {
                                child.texture = SKTexture(imageNamed: "MythicalMachineG")
                            } else if i == 3  {
                                child.texture = SKTexture(imageNamed: "RareMachineG")
                            } else {
                                child.texture = SKTexture(imageNamed: "RareSpearSP")
                            }
                        } else if text.texture?.name == "mountainC" {
                            if i == 1 || i == 3 {
                                child.texture = SKTexture(imageNamed: "MythicalShotgunG")
                            } else {
                                child.texture = SKTexture(imageNamed: "EpicSniperG")
                            }
                        } else {
                            if text.name?.suffix(3) == "bot" {
                                if i == 1 {
                                    child.texture = SKTexture(imageNamed: "LegendarySniperG")
                                } else if i == 2 {
                                    child.texture = SKTexture(imageNamed: "1M")
                                } else {
                                    child.texture = SKTexture(imageNamed: "MythicalShotgunG")
                                }
                            }
                        }
                    }
                }
            }
        }
        
        for iss in 1...3 {
            if let childs = ply!.childNode(withName: String(iss)) as? SKSpriteNode {
                if iss == 1 {
                    inve1.texture = childs.texture
                    if childs.texture?.name.suffix(3) == "rdS" {
                        inve1.size = CGSize(width: ((childs.texture?.size().width)!*1.8), height: ((childs.texture?.size().height)!*1.8))
                        if childs.texture?.name.prefix(1) == "L" {
                            swords += 1.5
                        } else {
                            swords += 1
                        }
                    } else if childs.texture?.name.suffix(2) == "SP" {
                        inve1.size = CGSize(width: ((childs.texture?.size().width)!*1.6), height: ((childs.texture?.size().height)!)*1.6)
                    } else if childs.texture?.name.suffix(2) == "nG" {
                        inve1.size = CGSize(width: ((childs.texture?.size().width)!*2.3), height: ((childs.texture?.size().height)!)*2.3)
                    } else if childs.texture?.name.suffix(2) == "rG" {
                        inve1.size = CGSize(width: ((childs.texture?.size().width)!*1.7), height: ((childs.texture?.size().height)!)*1.7)
                    } else if childs.texture?.name.suffix(2) == "1M" {
                        inve1.size = CGSize(width: (childs.texture?.size().width)!*2, height: (childs.texture?.size().height)!*2)
                    } else {
                        inve1.size = CGSize(width: (childs.texture?.size().width)!*5, height: (childs.texture?.size().height)!*5)
                    }
                } else if iss == 2 {
                    inve2.texture = childs.texture
                    if childs.texture?.name.suffix(3) == "rdS" {
                        if childs.texture?.name.prefix(1) == "L" {
                            swords += 1.5
                        } else {
                            swords += 1
                        }
                        inve2.size = CGSize(width: ((childs.texture?.size().width)!*1.8), height: ((childs.texture?.size().height)!*1.8))
                    } else if childs.texture?.name.suffix(2) == "SP" {
                        inve2.size = CGSize(width: ((childs.texture?.size().width)!*1.6), height: ((childs.texture?.size().height)!)*1.6)
                    } else if childs.texture?.name.suffix(2) == "nG" {
                        inve2.size = CGSize(width: ((childs.texture?.size().width)!*2.3), height: ((childs.texture?.size().height)!)*2.3)
                    } else if childs.texture?.name.suffix(2) == "rG" {
                        inve2.size = CGSize(width: ((childs.texture?.size().width)!*1.7), height: ((childs.texture?.size().height)!)*1.7)
                    } else if childs.texture?.name.suffix(2) == "1M" {
                        inve2.size = CGSize(width: (childs.texture?.size().width)!*2, height: (childs.texture?.size().height)!*2)
                    } else {
                        inve2.size = CGSize(width: (childs.texture?.size().width)!*5, height: (childs.texture?.size().height)!*5)
                    }
                } else {
                    inve3.texture = childs.texture
                    if childs.texture?.name.suffix(3) == "rdS" {
                        if childs.texture?.name.prefix(1) == "L" {
                            swords += 1.5
                        } else {
                            swords += 1
                        }
                        inve3.size = CGSize(width: ((childs.texture?.size().width)!*1.8), height: ((childs.texture?.size().height)!*1.8))
                    } else if childs.texture?.name.suffix(2) == "SP" {
                        inve3.size = CGSize(width: ((childs.texture?.size().width)!*1.6), height: ((childs.texture?.size().height)!)*1.6)
                    } else if childs.texture?.name.suffix(2) == "nG" {
                        inve3.size = CGSize(width: ((childs.texture?.size().width)!*2.3), height: ((childs.texture?.size().height)!)*2.3)
                    } else if childs.texture?.name.suffix(2) == "rG" {
                        inve3.size = CGSize(width: ((childs.texture?.size().width)!*1.7), height: ((childs.texture?.size().height)!)*1.7)
                    } else if childs.texture?.name.suffix(2) == "1M" {
                        inve3.size = CGSize(width: (childs.texture?.size().width)!*2, height: (childs.texture?.size().height)!*2)
                    } else {
                        inve3.size = CGSize(width: (childs.texture?.size().width)!*5, height: (childs.texture?.size().height)!*5)
                    }
                }
            }
        }
        gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
    }
    
    @objc func countdown() {
           if time > 0 {
               time -= 1
               killLabel.text = fun(time: TimeInterval(time))
           } else if time == 0  {
               //end
           }
       }
    
    func fun(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        var name1 = String()
        var name2 = String()
        if contact.bodyB.node?.name != nil {
            name1 = contact.bodyB.node!.name!
        }
        if contact.bodyA.node?.name != nil {
            name2 = contact.bodyA.node!.name!
        }
       
       if name1 == "ply" {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
        
        let osss = name1.prefix(2)
        var nums2:Int? = Int()
        if Int(osss) != nil {
            nums2 = 4
        } else {
            nums2 = 3
        }
        
        
        let oss = name2.prefix(2)
        var nums3:Int? = Int()
        if Int(oss) != nil {
            nums3 = 4
        } else {
            nums3 = 3
        }
        
        var mame = String()
        if name2.count == 5 || name2.count == 4 {
            mame = name2
        } else if name1.count == 5 || name1.count == 4  {
            mame = name1
        } else {
            mame = "no"
        }
        
        var emam = String()
        if name2.count == 3 {
            emam = name2
        } else if name1.count == 3 {
            emam = name1
        } else {
            emam = "no"
        }
        
        if emam != "ply" && (name1 == "map" || name2 == "map") {
            health -= 100
            healthBarT.size = CGSize(width: CGFloat(health*2), height: healthBarT.size.height)
            healthBarT.position.x = ply!.position.x + CGFloat(healthBarB.size.width-CGFloat((200-health))) - 400
        }
         
        
        if contact.bodyA.node != nil && contact.bodyB.node != nil {
            if name2.prefix(name2.count-nums3!) == "bulletminibullet" || name1.prefix(name1.count-nums2!) == "bulletminibullet" {
                if emam != "no" {
                    health -= CGFloat.random(in: 10...30)/swords
                    healthBarT.size = CGSize(width: CGFloat(health*2), height: healthBarT.size.height)
                    healthBarT.position.x = ply!.position.x + CGFloat(healthBarB.size.width-CGFloat((200-health))) - 400
                }
            } else if name2.prefix(name2.count-nums3!) == "bulletEpicSniperG" || name1.prefix(name1.count-nums2!) == "bulletEpicSniperG" {
                if emam != "no" {
                    health -= CGFloat.random(in: 125...175)/swords
                    healthBarT.size = CGSize(width: CGFloat(health*2), height: healthBarT.size.height)
                    healthBarT.position.x = ply!.position.x + CGFloat(healthBarB.size.width-CGFloat((200-health))) - 400

                }
            } else if name2.prefix(name2.count-nums3!) == "bulletLegendarySniperG" || name1.prefix(name1.count-nums2!) == "bulletLegendarySniperG" {
               if emam != "no" {
                    health -= CGFloat.random(in: 150...210)/swords
                    healthBarT.size = CGSize(width: CGFloat(health*2), height: healthBarT.size.height)
                    healthBarT.position.x = ply!.position.x + CGFloat(healthBarB.size.width-CGFloat((200-health))) - 400

                }
            } else if name2.prefix(name2.count-nums3!) == "bulletMythicalShotgunG" || name1.prefix(name1.count-nums2!) == "bulletMythicalShotgunG" {
               if emam != "no" {
                    health -= CGFloat.random(in: 15...45)/swords
                    healthBarT.size = CGSize(width: CGFloat(health*2), height: healthBarT.size.height)
                    healthBarT.position.x = ply!.position.x + CGFloat(healthBarB.size.width-CGFloat((200-health))) - 400

                }
            } else if name2.prefix(name2.count-nums3!) == "bulletGreenSpearSP" || name1.prefix(name1.count-nums2!) == "bulletGreenSpearSP" {
                if emam != "no" {
                    health -= CGFloat.random(in: 20...50)/swords
                    healthBarT.size = CGSize(width: CGFloat(health*2), height: healthBarT.size.height)
                    healthBarT.position.x = ply!.position.x + CGFloat(healthBarB.size.width-CGFloat((200-health))) - 400
                }
            } else if name2.prefix(name2.count-nums3!) == "bulletRareSpearSP" || name1.prefix(name1.count-nums2!) == "bulletRareSpearSP" {
               if emam != "no" {
                    health -= CGFloat.random(in: 35...75)/swords
                    healthBarT.size = CGSize(width: CGFloat(health*2), height: healthBarT.size.height)
                    healthBarT.position.x = ply!.position.x + CGFloat(healthBarB.size.width-CGFloat((200-health))) - 400
                }
            } else if name2.prefix(name2.count-nums3!) == "bulletRareMachineG" || name1.prefix(name1.count-nums2!) == "bulletRareMachineG" {
               if emam != "no" {
                    health -= CGFloat.random(in: 15...40)/swords
                    healthBarT.size = CGSize(width: CGFloat(health*2), height: healthBarT.size.height)
                    healthBarT.position.x = ply!.position.x + CGFloat(healthBarB.size.width-CGFloat((200-health))) - 400

                }
            } else if name2.prefix(name2.count-nums3!) == "bulletMythicalMachineG" || name1.prefix(name1.count-nums2!) == "bulletMythicalMachineG" {
                if emam != "no" {
                    health -= CGFloat.random(in: 25...50)/swords
                    healthBarT.size = CGSize(width: CGFloat(health*2), height: healthBarT.size.height)
                    healthBarT.position.x = ply!.position.x + CGFloat(healthBarB.size.width-CGFloat((200-health))) - 400

                }
            } else if name2.prefix(name2.count-nums3!) == "bulletGreenPistolP" || name1.prefix(name1.count-nums2!) == "bulletGreenPistolP" {
               if emam != "no" {
                    health -= CGFloat.random(in: 30...70)/swords
                    healthBarT.size = CGSize(width: CGFloat(health*2), height: healthBarT.size.height)
                    healthBarT.position.x = ply!.position.x + CGFloat(healthBarB.size.width-CGFloat((200-health))) - 400

                }
            }
        }
        
        if name1.prefix(6) == "bullet" && mame != "no" {
            if name1.suffix(10).prefix(5) == "Spear" {
                if ply!.texture!.name != "racerC" {
                    now = "2"
                }
                if let child = ply!.childNode(withName: now) as? SKSpriteNode {
                    child.texture = textur
                    child.alpha = 1.0
                   if self.now == "1" {
                        self.inve1.texture = textur
                        self.inve1.size = CGSize(width: ((textur.size().width)*1.6), height: ((textur.size().height))*1.6)
                   } else if self.now == "2" {
                        self.inve2.texture = textur
                        self.inve2.size = CGSize(width: ((textur.size().width)*1.6), height: ((textur.size().height))*1.6)
                    } else {
                        self.inve3.texture = textur
                        self.inve3.size = CGSize(width: ((textur.size().width)*1.6), height: ((textur.size().height))*1.6)
                    }
                }
            }
            contact.bodyB.node?.removeAllActions()
            contact.bodyB.node?.run(SKAction.scale(to: CGSize(width: 0, height: 0), duration: 1), completion: {
                contact.bodyB.node?.removeFromParent()
            })
        }
        if (name1.suffix(3) == "ply" || name2.suffix(3) == "ply") {
            kills += 1
        }
        
        if health <= 0 {
            //end
        }
    }
    
    func spear(whicha:SKSpriteNode, moew:String,name:String) {
        let spear = SKSpriteNode()
        textur = SKTexture()
        if let child = whicha.childNode(withName: moew) as? SKSpriteNode {
            spear.texture = child.texture
            textur = child.texture!
            spear.size = CGSize(width: textur.size().width*2, height: textur.size().height*2)
            spear.zPosition = 3
            var position = CGPoint()
            if whicha.texture!.name == "racerC" {
                position = child.convert(CGPoint(x: child.position.x, y: 825), to: whicha.parent!)
            } else if whicha.parent != nil {
                position = child.convert(CGPoint(x: child.position.x, y: 475), to: whicha.parent!)
            }
            spear.position = position
            if whicha.name == "ply" {
                if moew == "1" {
                    self.inve1.size = CGSize(width: 150, height: 150)
                    inve1.texture = nil
                    child.texture = nil
                    child.alpha = 0.0
                    self.inve1.color = UIColor(displayP3Red: 142, green: 144, blue:153, alpha: 0.5)
                } else if moew == "2" {
                    self.inve2.size = CGSize(width: 150, height: 150)
                    inve2.texture = nil
                    child.texture = nil
                    child.alpha = 0.0
                    self.inve2.color = UIColor(displayP3Red: 142, green: 144, blue:153, alpha: 0.5)
                } else {
                    self.inve3.size = CGSize(width: 150, height: 150)
                    inve3.texture = nil
                    child.texture = nil
                    child.alpha = 0.0
                    self.inve3.color = UIColor(displayP3Red: 142, green: 144, blue:153, alpha: 0.5)
                }
                starting = position
            }
        }
        now = whichFire
        spear.name = "bullet" + spear.texture!.name + whicha.name!.suffix(3)
        spear.physicsBody?.categoryBitMask = collider.bullet.rawValue
        spear.physicsBody?.collisionBitMask = collider.player.rawValue | collider.wall.rawValue
        spear.physicsBody?.contactTestBitMask = collider.player.rawValue | collider.wall.rawValue
        spear.physicsBody?.affectedByGravity = true
        spear.physicsBody = SKPhysicsBody(rectangleOf: spear.size)
        self.addChild(spear)
        spear.zRotation = whicha.zRotation
        let dx = 5000 * cos(whicha.zRotation+1.5707963268)
        let dy = 5000 * sin(whicha.zRotation+1.5707963268)
        spear.run(SKAction.move(by: CGVector(dx:dx, dy: dy), duration: 2)) {
            spear.removeFromParent()
            if whicha.name == "ply" {
                if let child = whicha.childNode(withName: self.now) as? SKSpriteNode {
                    child.texture = self.textur
                    child.alpha = 1.0
                    if self.now == "1" {
                        self.inve1.texture = self.textur
                        self.inve1.size = CGSize(width: ((self.textur.size().width)*1.6), height: ((self.textur.size().height))*1.6)
                    } else if self.now == "2" {
                        self.inve2.texture = self.textur
                        self.inve2.size = CGSize(width: ((self.textur.size().width)*1.6), height: ((self.textur.size().height))*1.6)
                    } else {
                        self.inve3.texture = self.textur
                        self.inve3.size = CGSize(width: ((self.textur.size().width)*1.6), height: ((self.textur.size().height))*1.6)
                    }
                }
            }
        }
    }
    
    func shoot(whicha: SKSpriteNode, meow:String,name:String) {
        let Shoot = SKSpriteNode(imageNamed: "bullet")
        Shoot.zPosition = 3
        var name = String()
        Shoot.size = CGSize(width: Shoot.size.width*1.7, height: Shoot.size.height*1.7)
        if let child = whicha.childNode(withName: meow) as? SKSpriteNode {
            var postt = CGPoint()
            if whicha.texture!.name == "racerC" && whicha.parent != nil {
                postt = child.convert(CGPoint(x: child.position.x, y:200), to: whicha.parent!)
            } else if whicha.parent != nil {
                postt = child.convert(CGPoint(x: child.position.x, y: 135), to: whicha.parent!)
            }
            Shoot.position = postt
            name = child.texture!.name
        }
        Shoot.name = "bullet" + name + whicha.name!.suffix(3)
        Shoot.physicsBody?.categoryBitMask = collider.bullet.rawValue
        Shoot.physicsBody?.collisionBitMask = collider.player.rawValue | collider.wall.rawValue
        Shoot.physicsBody?.contactTestBitMask = collider.player.rawValue | collider.wall.rawValue
        Shoot.physicsBody?.affectedByGravity = true
        Shoot.physicsBody = SKPhysicsBody(rectangleOf: Shoot.size)
        self.addChild(Shoot)
        Shoot.zRotation = whicha.zRotation
        let dx = 10000 * cos(whicha.zRotation+1.5707963268)
        let dy = 10000 * sin(whicha.zRotation+1.5707963268)
        Shoot.run(SKAction.move(by: CGVector(dx:dx, dy: dy), duration: 3)) {
            Shoot.removeFromParent()
        }
    }
    
    func shotgun(whicha:SKSpriteNode,meow:String,name:String) {
        let bullets = SKSpriteNode(imageNamed: "shells")
        var name = String()
        if let child = whicha.childNode(withName: meow) as? SKSpriteNode {
            bullets.size = CGSize(width: SKTexture(imageNamed: "shells").size().width, height: SKTexture(imageNamed: "shells").size().height)
            bullets.zPosition = 3
            var position = CGPoint()
            if (whicha.texture!.name == "mountainC" || whicha.texture!.name == "racerC") && whicha.parent != nil {
                position = child.convert(CGPoint(x: child.position.x, y:200), to: whicha.parent!)
            } else if whicha.parent != nil{
                position = child.convert(CGPoint(x: child.position.x, y:100), to: whicha.parent!)
            }
            bullets.position = position
            name = child.texture!.name
        }
        bullets.name = "bullet" + name + whicha.name!.prefix(3)
        bullets.physicsBody?.categoryBitMask = collider.bullet.rawValue
        bullets.physicsBody?.collisionBitMask = collider.player.rawValue | collider.wall.rawValue
        bullets.physicsBody?.contactTestBitMask = collider.player.rawValue | collider.wall.rawValue
        bullets.physicsBody = SKPhysicsBody(rectangleOf: bullets.size)
        bullets.physicsBody?.affectedByGravity = true
        bullets.zRotation = whicha.zRotation
        for _ in 1...10 {
            let copy = bullets.copy() as? SKSpriteNode
            let dx = 10000 * cos(whicha.zRotation+CGFloat.random(in: 1.178097245...1.963495409))
            let dy = 10000 * sin(whicha.zRotation+CGFloat.random(in: 1.178097245...1.963495409))
            self.addChild(copy!)
            copy!.run(SKAction.move(by: CGVector(dx:dx, dy: dy), duration: TimeInterval(CGFloat.random(in: 0.2...1.9)))) {
                copy!.removeFromParent()
            }
        }
    }
    
    func sniper(whicha:SKSpriteNode,meow:String,name:String) {
        let bullet = SKSpriteNode(imageNamed: "sniperbullet")
        var anem = String()
        if let child = whicha.childNode(withName: meow) as? SKSpriteNode {
            bullet.size = CGSize(width: SKTexture(imageNamed: "sniperbullet").size().width*3, height: SKTexture(imageNamed: "sniperbullet").size().height*3)
            bullet.zPosition = 3
            var position = CGPoint()
            if (whicha.texture!.name == "racerC" ||  whicha.texture!.name == "mountainC") && whicha.parent != nil {
                position = child.convert(CGPoint(x: child.position.x, y: 550), to: whicha.parent!)
            } else if whicha.parent != nil{
                position = child.convert(CGPoint(x: child.position.x, y: 275), to: whicha.parent!)
            }
            bullet.position = position
            anem = child.texture!.name
            starting = position
        }
        bullet.name = "bullet" + anem + whicha.name!.suffix(3)
        bullet.physicsBody?.categoryBitMask = collider.bullet.rawValue
        bullet.physicsBody?.collisionBitMask = collider.player.rawValue | collider.wall.rawValue
        bullet.physicsBody?.contactTestBitMask = collider.player.rawValue | collider.wall.rawValue
        bullet.physicsBody?.affectedByGravity = true
        bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.size)
        self.addChild(bullet)
        bullet.zRotation = whicha.zRotation
        let dx = 20000 * cos(whicha.zRotation+1.5707963268)
        let dy = 20000 * sin(whicha.zRotation+1.5707963268)
        bullet.run(SKAction.move(by: CGVector(dx:dx, dy: dy), duration: 2)) {
            bullet.removeFromParent()
        }
    }
    
    func pistol(whicha:SKSpriteNode,meow:String,name:String) {
        let bullet = SKSpriteNode(imageNamed: "pistolbullet")
        var name = String()
        if let child = whicha.childNode(withName: meow) as? SKSpriteNode {
            bullet.size = CGSize(width: SKTexture(imageNamed: "pistolbullet").size().width*1.5, height: SKTexture(imageNamed: "pistolbullet").size().height*1.5)
            bullet.zPosition = 3
            let position = child.convert(CGPoint(x: child.position.x, y: 90), to: whicha.parent!)
            bullet.position = position
            name = child.texture!.name
        }
        bullet.name = "bullet" + name + whicha.name!.suffix(3)
        bullet.physicsBody?.categoryBitMask = collider.bullet.rawValue
        bullet.physicsBody?.collisionBitMask = collider.player.rawValue | collider.wall.rawValue
        bullet.physicsBody?.contactTestBitMask = collider.player.rawValue | collider.wall.rawValue
        bullet.physicsBody?.affectedByGravity = true
        bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.size)
        self.addChild(bullet)
        bullet.zRotation = whicha.zRotation
        let dx = 10000 * cos(whicha.zRotation+1.5707963268)
        let dy = 10000 * sin(whicha.zRotation+1.5707963268)
        bullet.run(SKAction.move(by: CGVector(dx:dx, dy: dy), duration: 3.5)) {
            bullet.removeFromParent()
        }
    }
    
    func mini(whicha:SKSpriteNode,meow:String,name:String) {
        let bullet = SKSpriteNode(imageNamed: "minibullet")
        if let child = whicha.childNode(withName: meow) as? SKSpriteNode {
            bullet.size = CGSize(width: SKTexture(imageNamed: "minibullet").size().width*3, height: SKTexture(imageNamed: "minibullet").size().height*3)
            bullet.zPosition = 3
            let position = child.convert(CGPoint(x: child.position.x, y: 110), to: whicha.parent!)
            bullet.position = position
        }
        bullet.name = "bullet" + bullet.texture!.name + whicha.name!.suffix(3)
        bullet.physicsBody?.categoryBitMask = collider.bullet.rawValue
        bullet.physicsBody?.collisionBitMask = collider.player.rawValue | collider.wall.rawValue
        bullet.physicsBody?.contactTestBitMask = collider.player.rawValue | collider.wall.rawValue
        bullet.physicsBody?.affectedByGravity = true
        bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.size)
        self.addChild(bullet)
        bullet.zRotation = whicha.zRotation
        let dx = 10000 * cos(whicha.zRotation+1.5707963268)
        let dy = 10000 * sin(whicha.zRotation+1.5707963268)
        bullet.run(SKAction.move(by: CGVector(dx:dx, dy: dy), duration: 1)) {
            bullet.removeFromParent()
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if touch.location(in: self).x <= ply!.position.x-500 && UserDefaults.standard.bool(forKey: "mm") {
                joy.position = touch.location(in: self)
                base.position = touch.location(in: self)
                x = Int(touch.location(in: self).x) - Int(ply!.position.x)
                y = Int(touch.location(in: self).y) - Int(ply!.position.y)
            }
            if atPoint(touch.location(in: self)).name == "show" {
                self.camera = cam2
                hide = true
                mapView.alpha = 0.0
                inve2.alpha = 0.0
                fireButton.alpha = 0.0
                move = false
                joy.alpha = 0.0
                base.alpha = 0.0
                healthBarB.alpha = 0.0
                healthBarT.alpha = 0.0
                killCount.alpha = 0.0
                killLabel.alpha = 0.0
                player.alpha = 0.0
                self.scene?.backgroundColor = UIColor.black
            } else if atPoint(touch.location(in: self)).name?.suffix(1) == "2"{
                copy1.lineWidth = 7
                copy2.lineWidth = 1
                copy3.lineWidth = 1
                whichFire = "2"
            } else if atPoint(touch.location(in: self)).name == "3" {
                copy1.lineWidth = 1
                copy2.lineWidth = 7
                copy3.lineWidth = 1
                whichFire = "3"
            } else if atPoint(touch.location(in: self)).name == "I1" {
                copy1.lineWidth = 1
                copy2.lineWidth = 1
                copy3.lineWidth = 7
                whichFire = "1"
            } else if atPoint(touch.location(in: self)).name == "fire" {
                if (inve1.texture?.name.suffix(2) == "eG" && whichFire == "1") || (inve3.texture?.name.suffix(2) == "eG" && whichFire == "3") || (inve2.texture?.name.suffix(2) == "eG" && whichFire == "2") {
                    timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { (Timew) in
                        self.shoot(whicha: self.ply!, meow: self.whichFire, name: "ply")
                    })
                }  else if whichFire == "1" && inve1.texture?.name.suffix(4) == "arSP" {
                    timer = Timer.scheduledTimer(withTimeInterval: 0, repeats: false, block: { (timew) in
                        self.spear(whicha: self.ply!, moew: self.whichFire, name: "ply")
                    })
                } else if whichFire == "2" && inve2.texture?.name.suffix(4) == "arSP" {
                    timer = Timer.scheduledTimer(withTimeInterval: 0, repeats: false, block: { (timew) in
                        self.spear(whicha: self.ply!, moew: self.whichFire, name: "ply")
                    })
                } else if whichFire == "3" && inve3.texture?.name.suffix(4) == "arSP" {
                    timer = Timer.scheduledTimer(withTimeInterval: 0, repeats: false, block: { (timew) in
                        self.spear(whicha: self.ply!, moew: self.whichFire, name: "ply")
                    })
                } else if whichFire == "1" && inve1.texture?.name.suffix(2) == "nG" {
                    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timew) in
                        self.shotgun(whicha: self.ply!, meow: self.whichFire, name: "ply")
                    })
                } else if whichFire == "2" && inve2.texture?.name.suffix(2) == "nG" {
                    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timew) in
                        self.shotgun(whicha: self.ply!, meow: self.whichFire, name: "ply")
                    })
                } else if whichFire == "3" && inve3.texture?.name.suffix(2) == "nG" {
                    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timew) in
                        self.shotgun(whicha: self.ply!, meow: self.whichFire, name: "ply")
                    })
                } else if whichFire == "1" && inve1.texture?.name.suffix(2) == "rG" {
                    timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true, block: { (timew) in
                        self.sniper(whicha: self.ply!, meow: self.whichFire, name: "ply")
                    })
                } else if whichFire == "2" && inve2.texture?.name.suffix(2) == "rG" {
                    timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true, block: { (timew) in
                        self.sniper(whicha: self.ply!, meow: self.whichFire, name: "ply")
                    })
                } else if whichFire == "3" && inve3.texture?.name.suffix(2) == "rG" {
                    timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true, block: { (timew) in
                        self.sniper(whicha: self.ply!, meow: self.whichFire, name: "ply")
                    })
                } else if whichFire == "1" && inve1.texture?.name.suffix(2) == "lP" {
                    timer = Timer.scheduledTimer(withTimeInterval: 0, repeats: false, block: { (timew) in
                        self.pistol(whicha: self.ply!, meow: self.whichFire, name: "ply")
                    })
                } else if whichFire == "2" && inve2.texture?.name.suffix(2) == "lP" {
                    timer = Timer.scheduledTimer(withTimeInterval: 0, repeats: false, block: { (timew) in
                        self.pistol(whicha: self.ply!, meow: self.whichFire, name: "ply")
                    })
                } else if whichFire == "3" && inve3.texture?.name.suffix(2) == "lP" {
                    timer = Timer.scheduledTimer(withTimeInterval: 0, repeats: false, block: { (timew) in
                        self.pistol(whicha: self.ply!, meow: self.whichFire, name: "ply")
                    })
                } else if whichFire == "1" && (inve1.texture?.name.suffix(2) == "1M" || inve1.texture?.name.suffix(2) == "2M" || inve1.texture?.name.suffix(2) == "3M") {
                    inve1.run(SKAction.repeatForever(nimation))
                    timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { (timew) in
                        self.mini(whicha: self.ply!, meow: self.whichFire, name: "ply")
                    })
                } else if whichFire == "2" && (inve2.texture?.name.suffix(2) == "1M" || inve2.texture?.name.suffix(2) == "2M" || inve2.texture?.name.suffix(2) == "3M") {
                    inve2.run(SKAction.repeatForever(nimation))
                    timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { (timew) in
                        self.mini(whicha: self.ply!, meow: self.whichFire, name: "ply")
                    })
                } else if whichFire == "3" && (inve3.texture?.name.suffix(2) == "1M" || inve3.texture?.name.suffix(2) == "2M" || inve3.texture?.name.suffix(2) == "3M"){
                    inve3.run(SKAction.repeatForever(nimation))
                    timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { (timew) in
                        self.mini(whicha: self.ply!, meow: self.whichFire, name: "ply")
                    })
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let loc = touch.location(in: self)
            if loc.x <= ply!.position.x-500 {
                if !hide {
                    if UserDefaults.standard.bool(forKey: "im") {
                        move = false
                    } else {
                        move = true
                    }
                    self.base.alpha = 0.4
                    self.joy.alpha = 0.4
                    let v = CGVector(dx: loc.x-base.position.x, dy: loc.y-base.position.y)
                    let angle = atan2(v.dy, v.dx)
                    let xDist: CGFloat = sin(angle-4.7123889804) * 125
                    let yDist: CGFloat = cos(angle-4.7123889804) * 125
                    ply!.zRotation = (angle-1.5707963268)
                    rotation = (angle)
                    if base.contains(loc) {
                        joy.position = loc
                    } else {
                        joy.position = CGPoint(x: base.position.x + xDist, y: base.position.y - yDist)
                    }
                    disx = base.position.x - joy.position.x
                    disy = base.position.y - joy.position.y
                    distance = sqrt(((disx)*(disx))+((disy)*(disy)))
                }
            }
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let loc = touch.location(in: self)
            if atPoint(loc).name == "fire" {
                if timer != nil {
                    timer.invalidate()
                }
                ply!.removeAllActions()
            }
            self.camera = cam
            if loc.x <= ply!.position.x {
                self.base.alpha = 0.0
                self.joy.alpha = 0.0
                if UserDefaults.standard.bool(forKey: "im") {
                    move = true
                } else {
                    move = false
                }
            }
            if hide {
                mapView.alpha = 1.0
                joy.alpha = 0.4
                base.alpha = 0.4
                healthBarB.alpha = 1.0
                healthBarT.alpha = 1.0
                killCount.alpha = 1.0
                killLabel.alpha = 1.0
                if inve2.texture?.name != nil {
                    inve2.alpha = 1.0
                    fireButton.alpha = 0.5
                } else {
                    fireButton.alpha = 0.5
                    inve2.alpha = 1
                }
                hide = false
                self.scene?.backgroundColor = UIColor.black
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        cam.position = ply!.position
        if (UIDevice.current.model.prefix(3)) == "iPh" {
            self.healthBarT.position = CGPoint(x:ply!.position.x + CGFloat(healthBarB.size.width-CGFloat((200-health))) - 400, y:ply!.position.y+UIScreen.main.bounds.height*CGFloat(SomeMuchVars)-215)
            self.healthBarB.position = CGPoint(x:ply!.position.x, y:ply!.position.y+UIScreen.main.bounds.height*CGFloat(SomeMuchVars)-215)
        } else {
            self.healthBarT.position = CGPoint(x:ply!.position.x + CGFloat(healthBarB.size.width-CGFloat((200-health))) - 400, y:ply!.position.y+UIScreen.main.bounds.height*CGFloat(SomeMuchVars)-500)
            self.healthBarB.position = CGPoint(x:ply!.position.x, y:ply!.position.y+UIScreen.main.bounds.height*CGFloat(SomeMuchVars)-500)
        }
        inve2.position = CGPoint(x: ply!.position.x, y: ply!.position.y-(UIScreen.main.bounds.height/2)-CGFloat(reallyWantoSayIt*10))
        fireButton.position = CGPoint(x: ply!.position.x+900, y: ply!.position.y-300)
        fireButton.position = CGPoint(x: ply!.position.x+900, y: ply!.position.y-300)
        self.base.position.x = ply!.position.x + CGFloat(x)
        self.base.position.y = ply!.position.y +  CGFloat(y)
        self.joy.position.x = base.position.x - disx
        self.joy.position.y = base.position.y - disy
        let oneSide = stopping.centerOfTile(atColumn: 0, row: 0)
        let twoSide = stopping.centerOfTile(atColumn: rand, row: rand)
        if !((oneSide.x <= ply!.position.x && oneSide.y <= ply!.position.y) && (twoSide.x >= ply!.position.x && twoSide.y >= ply!.position.y)) {
            health -= 3
            healthBarT.size = CGSize(width: CGFloat(health*2), height: healthBarT.size.height)
            healthBarT.position.x = ply!.position.x + CGFloat(healthBarB.size.width-CGFloat((200-health))) - 400
            if health <= 0 {
                        //ending
            }
        }
        self.mapView.position = CGPoint(x: fireButton.position.x-50, y: fireButton.position.y+UIScreen.main.bounds.height*CGFloat(numb)-75)
        player.position = CGPoint(x: ply!.position.x+UIScreen.main.bounds.width/2-CGFloat(75 - anotherone), y: mapView.position.y)
        killCount.position = CGPoint(x: mapView.position.x-100, y: mapView.position.y-250)
        killCount.text = "\(kills)"
        killLabel.position = CGPoint(x: mapView.position.x+50, y: mapView.position.y-250)
        player.text = "1 V 1"
 
        if move {
            let speed = distance/15
            let dx = Double((rotation-speed-10) * cos(ply!.zRotation+1.5707963268))
            let dy = Double((rotation-speed-10) * sin(ply!.zRotation+1.5707963268))
            self.ply!.position = CGPoint(x: (Double(ply!.position.x) - dx), y: (Double(ply!.position.y) - dy))
        }
    }
}
