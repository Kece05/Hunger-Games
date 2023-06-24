//
//  GameScene.swift
//  Hunger Games
//
//  Created by kbice on 5/27/19.
//  Copyright © 2019 Keller Bice. All rights reserved.
//

import SpriteKit
import GameplayKit
import AudioToolbox

enum collider : UInt32 {
    case player = 1
    case wall = 2
    case bullet = 16
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var anotherAllow = true
    var starting = CGPoint()
    var runningAction = false
    var wasJustHunting = true
    var hunting = false
    var anotherone = 0
    var viewController: UIViewController?
    var hasMeds = false
    var player = SKLabelNode()
    let how = CGVector(dx: CGFloat.random(in: -1...1), dy: CGFloat.random(in: -1...1))
    var gameOver = false
    var kills = 0
    var sprites = [SKSpriteNode]()
    var game : Timer!
    var tiems = 1
    var thisIsfun = 1.0
    var speeded = 1
    let nimation = SKAction.animate(with: [SKTexture(imageNamed: "1M"),SKTexture(imageNamed: "2M"),SKTexture(imageNamed: "3M")], timePerFrame: 0.4)
    var looking = [String : CGPoint]()
    var health = CGFloat(200)
    var dos = false
    var total1 = 5
    var timerssrs = 1
    var textur = SKTexture()
    var now = String()
    var total2 = 5
    var numb = 1.0
    var timess = 20
    var cam = SKCameraNode()
    let base = SKShapeNode(circleOfRadius: 150)
    let joy = SKShapeNode(circleOfRadius: 75)
    let df = SKShapeNode()
    var rotation = CGFloat(0)
    var tot = Int()
    var disx = CGFloat()
    var disy = CGFloat()
    var move = false
    var killCount = SKLabelNode()
    var victoryRoyale = false
    var distance = CGFloat()
    var x = -800
    var y = -200
    let map = SKNode()
    var mapView = SKShapeNode(circleOfRadius: 150)
    var cam2 = SKCameraNode()
    let topLayer = SKTileMapNode(tileSet: SKTileSet(named: "Sample Grid Tile Set")!, columns: 264, rows: 264, tileSize: CGSize(width: 128, height: 128))
    let shores = SKTileMapNode(tileSet: SKTileSet(named: "Sample Grid Tile Set")!, columns: 262, rows: 262, tileSize: CGSize(width: 128, height: 128))
    let stopping = SKTileMapNode(tileSet: SKTileSet(named: "Sample Grid Tile Set")!, columns: 261, rows: 261, tileSize: CGSize(width: 128, height: 128))
    var hide = false
    var beginingPosition = CGPoint()
    var rand = Int.random(in: 10...50)
    var positions = CGPoint()
    var count = 0
    var reallyWantoSayIt = 0.0
    var times = 0
    var lastUpdateTime: TimeInterval = 0
    var killLabel = SKLabelNode()
    var allowRotation = false
    var taskBot = SKSpriteNode()
    var inve1 = SKSpriteNode()
    var inve2 = SKSpriteNode()
    var inve3 = SKSpriteNode()
    var healthBarT = SKSpriteNode()
    var healthBarB = SKSpriteNode()
    var start = SKLabelNode()
    var tapPosition : CGPoint? = nil
    var laps = 0
    var timer1 = [String:Timer]()
    var time1 : Timer!
    var time2 : Timer!
    var time3 : Timer!
    var time4 : Timer!
    var time5 : Timer!
    var time6 : Timer!
    var time7 : Timer!
    var time8 : Timer!
    var time9 : Timer!
    var time10 : Timer!
    var time11 : Timer!
    var time12 : Timer!
    var time13 : Timer!
    var time14 : Timer!
    var time15 : Timer!
    var time16 : Timer!
    var time17 : Timer!
    var time18 : Timer!
    var time19 : Timer!
    var ctimer = 600
    var fireButton = SKShapeNode(circleOfRadius: 125)
    var copy1 = SKShapeNode(rectOf: CGSize(width: 150, height: 150))
    var copy2 = SKShapeNode(rectOf: CGSize(width: 150, height: 150))
    var copy3 = SKShapeNode(rectOf: CGSize(width: 150, height: 150))
    var whichFire = String()
    var timer : Timer!
    var anotherlist = [String:Bool]()
    var BotsHealth = [String:Int]()
    var SomeMuchVars = 0.0
    var swords = CGFloat()
    var gameTimer : Timer!
    var bots = [String:SKSpriteNode]()
    var t1 = [String:SKSpriteNode]()
    var t2 = [String:SKSpriteNode]()
    var teamHunting = [String:SKSpriteNode]()
    var damageM = 0
    var hungerM = true
    var delet = false
    var CM = true
    var CMD = true
    var gm = false
    var pm = false
    var mm = false
    var instr = true
    var gravity : Timer!
    lazy var ply : SKSpriteNode? = {
        return self.childNode(withName: "//player") as? SKSpriteNode
    }()
    var meters = SKLabelNode()
    
    override func didMove(to view: SKView) {
        
        self.view?.showsPhysics = false
        let textures = SKTextureAtlas(named: "Cars").textureNames
        self.ply!.name = "ply"
        if UserDefaults.standard.bool(forKey: "OTM") {
            damageM = 400
        }
        
        
        if UserDefaults.standard.bool(forKey: "HM") {
            hungerM = false
        }
        
        if UserDefaults.standard.bool(forKey: "gm") {
            gm = true
        }
        
        if UserDefaults.standard.bool(forKey: "pm") {
            pm = true
        }
        
        if UserDefaults.standard.bool(forKey: "mm") {
            mm = true
        }
        
        if UserDefaults.standard.bool(forKey: "cm") {
            CM = false
        }
        if UserDefaults.standard.bool(forKey: "in") {
            instr = false
            UserDefaults.standard.set(false,forKey: "cm")
            
        }
        if gm {
            rand = 100
        }
        
        var data = String()
        if !instr {
            data = "bumbleC"
        } else {
            data = UserDefaults.standard.string(forKey: "name")!
        }
        ply!.texture = SKTexture(imageNamed: data)
        ply!.size = SKTexture(imageNamed: data).size()
        self.anchorPoint = .zero
        physicsWorld.speed = 0.9
        if ply!.texture!.name == "mountainC" {
            ply!.scale(to: CGSize(width: ply!.size.width/6*1.5, height: ply!.size.height/6*1.5))
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
            ply!.scale(to: CGSize(width: ply!.size.width/4*1.5, height: ply!.size.height/4*1.5))
            for i in 1...3 {
                if let childp = ply?.childNode(withName: String(i)) as? SKSpriteNode {
                    var game = String()
                    if i == 1 {
                        game = UserDefaults.standard.string(forKey: "1")!
                    } else if i == 2 {
                        game = UserDefaults.standard.string(forKey: "2")!
                        if game == "meds" {
                            hasMeds = true
                        }
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
        } else if ply!.texture!.name == "medic" {
            ply!.scale(to: CGSize(width: ply!.size.width, height: ply!.size.height))
            for i in 1...3 {
                if let childp = ply?.childNode(withName: String(i)) as? SKSpriteNode {
                    if i == 1 {
                        childp.position = CGPoint(x: 50, y: 340.5/4)
                        childp.size = CGSize(width: childp.size.width*0.5, height: childp.size.height*0.5)
                    } else if i == 2 {
                        childp.position = CGPoint(x: 0, y: 100)
                        childp.size = CGSize(width: childp.size.width, height: childp.size.height/3)
                    } else {
                        childp.position = CGPoint(x: -50, y: 340.5/4)
                        childp.size = CGSize(width: childp.size.width*0.5, height: childp.size.height*0.5)
                    }
                }
            }
        } else {
            ply!.scale(to: CGSize(width: ply!.size.width/3*1.5, height: ply!.size.height/3*1.5))
        }
        meters = self.childNode(withName: "'") as! SKLabelNode
        taskBot = self.childNode(withName: "bot") as! SKSpriteNode
        killCount = self.childNode(withName: "killcount") as! SKLabelNode
        player = self.childNode(withName: "players") as! SKLabelNode
        killLabel = self.childNode(withName: "gameCount") as! SKLabelNode
        var asds = Int()
        if !instr {
           asds = 1
        } else {
            asds = UserDefaults.standard.integer(forKey: "gameMode")
            asds *= 2
            if asds != 1 {
                asds -= 1
            }
        }
        gameOver = false
        physicsWorld.contactDelegate = self
        cam = self.childNode(withName: "follow") as! SKCameraNode
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
        if pm {
            rand = 25
        }
        if gm {
            rand = 100
        }
        if !CM && instr {
            rand = Int(UserDefaults.standard.string(forKey: "size")!)!
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
        anotherlist["ply"] = true
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
        if !CM && instr {
            self.start = self.childNode(withName: "Start") as! SKLabelNode
            start.alpha = 1
            start.text = "Start"
        } else if !instr {
            self.start = self.childNode(withName: "Start") as! SKLabelNode
            start.text = "Move around"
        }
        
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
        for column in 0 ..< rand-3 {
            for row in 0 ..< rand-3 {
                var max = 20
                if gm {
                    max = 5
                } else if pm {
                    max = 40
                }
                if Int.random(in: 1...max) == 1 {
                    let spr = SKSpriteNode()
                    spr.texture = SKTexture(imageNamed: "wall")
                    spr.name = "wall"
                    spr.size = CGSize(width: (spr.texture?.size())!.width*CGFloat.random(in: 1...3), height: (spr.texture?.size())!.height*CGFloat.random(in: 1...3))
                    spr.physicsBody?.categoryBitMask = collider.wall.rawValue
                    spr.physicsBody?.collisionBitMask = collider.player.rawValue | collider.bullet.rawValue
                    spr.physicsBody?.contactTestBitMask =  collider.player.rawValue | collider.bullet.rawValue
                    spr.physicsBody = SKPhysicsBody(rectangleOf: spr.size)
                    spr.position = topLayer.centerOfTile(atColumn: column, row: row)
                    if gm {
                        self.physicsWorld.gravity = how
                        spr.physicsBody?.applyForce(how)
                        spr.physicsBody?.isDynamic = true
                    }
                    self.addChild(spr)
                }
            }
        }

        
        map.addChild(topLayer)
        self.addChild(map)
        if pm {
            player.alpha = 0
        }
        
        mapView.zPosition = 10
        inve2.zPosition = 10
        fireButton.zPosition = 10
        joy.zPosition = 10
        base.zPosition = 10
        if UIDevice.current.model != "iPad" {
            meters.zPosition = 10
        }
        healthBarB.zPosition = 10
        healthBarT.zPosition = 10
        killCount.zPosition = 10
        killLabel.zPosition = 10
        player.zPosition = 10
        
        taskBot.physicsBody = nil
        
        let model = UIDevice.current.model
        if model == "iPad" {
            meters.alpha = 0.0
        }
        swords += 1.2
        if CM {
            ctimer = 300
        } else {
            ctimer = 600
        }
        start.zPosition = 6
        killLabel.text = fun(time: TimeInterval(ctimer))
        
        gameTimr()
        victoryRoyale = false
    
        let pos = topLayer.centerOfTile(atColumn: 0, row: rand/2)
        let po = topLayer.centerOfTile(atColumn: rand-5, row: rand/2)
        stopping.name = "map"
        total1 = (asds + 1)/2
        total2 = total1
        tot = total2 + total1
        for i in 1...tot-1 {
            if !pm {
                let copy = taskBot.copy() as! SKSpriteNode
                self.addChild(copy)
                copy.texture = SKTexture(imageNamed: textures.randomElement()!)
                copy.size = (copy.texture?.size())!
                if copy.texture!.name == "mountainC" {
                    copy.scale(to: CGSize(width: copy.size.width/6*1.5, height: copy.size.height/6*1.5))
                    for i in 1...3 {
                        if let childp = copy.childNode(withName: String(i)) as? SKSpriteNode {
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
                } else {
                    copy.scale(to: CGSize(width: copy.size.width/3*1.5, height: copy.size.height/3*1.5))
                }
                copy.physicsBody = SKPhysicsBody(rectangleOf: copy.size)
                copy.physicsBody?.categoryBitMask = collider.player.rawValue
                copy.physicsBody?.contactTestBitMask =  collider.player.rawValue | collider.bullet.rawValue
                copy.name = "\(i)bot"
                copy.zPosition = 4
                BotsHealth[copy.name!] = 200
                bots[copy.name!] = copy
                anotherlist[copy.name!] = true
                if i == 1 {
                    timer1[copy.name!] = time1
                } else if i == 2 {
                    timer1[copy.name!] = time2
                } else if i == 3 {
                    timer1[copy.name!] = time3
                } else if i == 4 {
                    timer1[copy.name!] = time4
                } else if i == 5 {
                    timer1[copy.name!] = time5
                } else if i == 6 {
                    timer1[copy.name!] = time6
                } else if i == 7 {
                    timer1[copy.name!] = time7
                } else if i == 8 {
                    timer1[copy.name!] = time8
                } else if i == 9 {
                    timer1[copy.name!] = time9
                } else if i == 10 {
                    timer1[copy.name!] = time10
                } else if i == 11 {
                    timer1[copy.name!] = time11
                } else if i == 12 {
                    timer1[copy.name!] = time12
                } else if i == 13 {
                    timer1[copy.name!] = time13
                } else if i == 14 {
                    timer1[copy.name!] = time14
                } else if i == 15 {
                    timer1[copy.name!] = time15
                } else if i == 16 {
                    timer1[copy.name!] = time16
                } else if i == 17 {
                    timer1[copy.name!] = time17
                } else if i == 18 {
                    timer1[copy.name!] = time18
                } else if i == 19 {
                    timer1[copy.name!] = time19
                }
                if i % 2 == 0 && hungerM {
                    copy.position = po
                    t1[copy.name!] = copy
                } else {
                    copy.position = pos
                    t2[copy.name!] = copy
                }
            } else {
                self.NewCar()
            }
        }
        t1[ply!.name!] = ply!
        ply!.position = po
        
        
        if !pm {
            for i in 1...tot-1 {
                if i % 2 == 0 && hungerM {
                    teamHunting[t1["\(i)bot"]!.name!] = t2.randomElement()!.value
                } else {
                    teamHunting[t2["\(i)bot"]!.name!] = t1.randomElement()!.value
                }
            }
            
        }
        for i in taskBot.children {
            i.zPosition = -1
            i.alpha = 0
        }
        if ply!.texture?.name == "fast" {
            speeded += Int(2)
        }
        taskBot.alpha = 0
        for i in self.children {
            if let text = i as? SKSpriteNode {
                if gm {
                    sprites.append(text)
                }
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

                        } else if text.texture?.name == "fast" {
                            if i == 1 || i == 3 {
                                child.texture = SKTexture(imageNamed: "metal")
                            } else {
                                child.texture = SKTexture(imageNamed: "laser")
                            }

                        } else if text.texture?.name == "medic" {
                            if i == 1 {
                                child.texture = SKTexture(imageNamed: "MythicalMachineG")
                            } else if i == 3 {
                                child.texture = SKTexture(imageNamed: "MythicalShotgunG")
                            } else {
                                child.texture = SKTexture(imageNamed: "meds")
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
                        if childs.texture?.name.prefix(1) == "L" {
                            swords += 1.5
                        } else {
                            swords += 1
                        }
                        inve1.size = CGSize(width: ((childs.texture?.size().width)!*1.8), height: ((childs.texture?.size().height)!*1.8))
                    } else if childs.texture?.name.suffix(2) == "SP" {
                        inve1.size = CGSize(width: ((childs.texture?.size().width)!*1.6), height: ((childs.texture?.size().height)!)*1.6)
                    } else if childs.texture?.name.suffix(2) == "nG" {
                        inve1.size = CGSize(width: ((childs.texture?.size().width)!*2.3), height: ((childs.texture?.size().height)!)*2.3)
                    } else if childs.texture?.name.suffix(2) == "rG" {
                        inve1.size = CGSize(width: ((childs.texture?.size().width)!*1.7), height: ((childs.texture?.size().height)!)*1.7)
                    } else if childs.texture?.name.suffix(2) == "1M" {
                        inve1.size = CGSize(width: (childs.texture?.size().width)!*2, height: (childs.texture?.size().height)!*2)
                    } else if childs.texture?.name.suffix(2) == "al" {
                        inve1.size = CGSize(width: ((childs.texture?.size().width)!*1.8), height: ((childs.texture?.size().height)!*1.8))
                        swords += 4
                    } else if childs.texture?.name.suffix(2) == "er" {
                        inve1.size = CGSize(width: ((childs.texture?.size().width)!*5.7), height: ((childs.texture?.size().height)!*5.7))
                    } else if childs.texture?.name.suffix(3) == "eds" {
                        inve1.size = CGSize(width: 100, height: 100)
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
                        inve2.size = CGSize(width: ((childs.texture?.size().width)!*6), height: ((childs.texture?.size().height)!*6))
                    } else if childs.texture?.name.suffix(2) == "SP" {
                        inve2.size = CGSize(width: ((childs.texture?.size().width)!*1.6), height: ((childs.texture?.size().height)!)*1.6)
                    } else if childs.texture?.name.suffix(2) == "nG" {
                        inve2.size = CGSize(width: ((childs.texture?.size().width)!*2.3), height: ((childs.texture?.size().height)!)*2.3)
                    } else if childs.texture?.name.suffix(2) == "rG" {
                        inve2.size = CGSize(width: ((childs.texture?.size().width)!*1.7), height: ((childs.texture?.size().height)!)*1.7)
                    } else if childs.texture?.name.suffix(2) == "1M" {
                        inve2.size = CGSize(width: (childs.texture?.size().width)!*2, height: (childs.texture?.size().height)!*2)
                    } else if childs.texture?.name.suffix(2) == "al" {
                        inve2.size = CGSize(width: ((childs.texture?.size().width)!*1.8), height: ((childs.texture?.size().height)!*1.8))
                        swords += 4
                    } else if childs.texture?.name.suffix(2) == "er" {
                        inve2.size = CGSize(width: ((childs.texture?.size().width)!*5.7), height: ((childs.texture?.size().height)!*5.7))
                    } else if childs.texture?.name.suffix(3) == "eds" {
                        inve2.size = CGSize(width: 100, height: 100)
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
                    } else if childs.texture?.name.suffix(2) == "al" {
                        inve3.size = CGSize(width: ((childs.texture?.size().width)!*1.8), height: ((childs.texture?.size().height)!*1.8))
                        swords += 4
                    } else if childs.texture?.name.suffix(2) == "er" {
                        inve3.size = CGSize(width: ((childs.texture?.size().width)!*5.7), height: ((childs.texture?.size().height)!*5.7))
                    } else if childs.texture?.name.suffix(3) == "eds" {
                        inve3.size = CGSize(width: 100, height: 100)
                    } else {
                        inve3.size = CGSize(width: (childs.texture?.size().width)!*5, height: (childs.texture?.size().height)!*5)
                    }
                }
            }
        }
        taskBot.zPosition = -1
        for i in taskBot.children {
            i.zPosition = -1
            i.alpha = 0
        }
    }
    
    @objc func tdown() {
        tiems -= 1
        if tiems == 0 {
            inve2.texture = SKTexture(imageNamed: "meds")
            inve2.size = CGSize(width: 100, height: 100)
            tiems += Int.random(in: 5...10)
        }
    }
    
    
    func gameTimr() {
        gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        if ply!.texture!.name == "medic" || (ply!.texture!.name == "racerC" && hasMeds) {
            game = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(tdown), userInfo: nil, repeats: true)
        }
        if gm {
            gravity = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(gravitys), userInfo: nil, repeats: true)
        }
    }
    
    func NewCar() {
        let Name1 = SKSpriteNode()
        let textures = SKTextureAtlas(named: "Cars").textureNames
        Name1.texture = SKTexture(imageNamed: textures.randomElement()!)
        Name1.size = (Name1.texture?.size())!
        let sp1 = SKSpriteNode()
        let sp2 = SKSpriteNode()
        let sp3 = SKSpriteNode()
        sp1.name = "1"
        sp2.name = "2"
        sp3.name = "3"
        sp1.size = CGSize(width: 40, height: 121)
        sp2.size = CGSize(width: 40, height: 121)
        sp3.size = CGSize(width: 40, height: 121)
        Name1.addChild(sp1)
        Name1.addChild(sp2)
        Name1.addChild(sp3)
        sp1.position = CGPoint(x: 110.679, y: 85.736)
        sp2.position = CGPoint(x: 0, y: 183.985)
        sp3.position = CGPoint(x: -110.679, y: 85.736)
        if Name1.texture!.name == "mountainC" {
            Name1.scale(to: CGSize(width: Name1.size.width/6*1.5, height: Name1.size.height/6*1.5))
            for i in 1...3 {
                if let childp = Name1.childNode(withName: String(i)) as? SKSpriteNode {
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
        } else {
            Name1.scale(to: CGSize(width: Name1.size.width/3*1.5, height: Name1.size.height/3*1.5))
        }
        Name1.physicsBody = SKPhysicsBody(rectangleOf: Name1.size)
        Name1.physicsBody?.categoryBitMask = collider.player.rawValue
        Name1.physicsBody?.collisionBitMask = collider.player.rawValue | collider.bullet.rawValue | collider.wall.rawValue
        Name1.physicsBody?.contactTestBitMask =  collider.player.rawValue | collider.bullet.rawValue | collider.wall.rawValue
        Name1.name = "1bot"
        Name1.zPosition = 4
        BotsHealth[Name1.name!] = 200
        bots[Name1.name!] = Name1
        
        anotherlist["1bot"] = true
        timer1[Name1.name!] = time1
        let pos = topLayer.centerOfTile(atColumn: Int.random(in: 0...rand-3), row: rand/Int.random(in: 1...rand-3))
        Name1.position = pos
        t2[Name1.name!] = Name1
        teamHunting[Name1.name!] = ply!
        self.addChild(Name1)
        for i in 1...3 {
            if let child = Name1.childNode(withName: String(i)) as? SKSpriteNode {
                if Name1.texture?.name == "bmwC" {
                    if i == 1 || i == 3 {
                        child.texture = SKTexture(imageNamed: "EpicSwordS")
                    } else {
                        if Int.random(in: 1...2) == 1 {
                            child.texture = SKTexture(imageNamed: "GreenSpearSP")
                        } else {
                            child.texture = SKTexture(imageNamed: "GreenSpearSP")
                        }
                    }

                } else if Name1.texture?.name == "bumbleC" {
                    if i == 1 || i == 3 {
                        child.texture = SKTexture(imageNamed: "LegendarySwordS")
                    } else {
                        child.texture = SKTexture(imageNamed: "RareSpearSP")
                    }
                } else if Name1.texture?.name == "ferrieC" {
                    if i == 1 {
                        child.texture = SKTexture(imageNamed: "LegendarySwordS")
                    } else if i == 3 {
                        child.texture = SKTexture(imageNamed: "EpicSwordS")
                    } else {
                        child.texture = SKTexture(imageNamed: "RareMachineG")
                    }
                } else if Name1.texture?.name == "lamboC" {
                    if i == 1 {
                        child.texture = SKTexture(imageNamed: "MythicalMachineG")
                    } else if i == 3  {
                        child.texture = SKTexture(imageNamed: "RareMachineG")
                    } else {
                        child.texture = SKTexture(imageNamed: "RareSpearSP")
                    }
                } else if Name1.texture?.name == "mountainC" {
                    if i == 1 || i == 3 {
                        child.texture = SKTexture(imageNamed: "MythicalShotgunG")
                    } else {
                        child.texture = SKTexture(imageNamed: "EpicSniperG")
                    }
                } else {
                    if Name1.name?.suffix(3) == "bot" {
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
    
    @objc func countdown() {
        if ctimer > 0 {
            ctimer -= 1
            killLabel.text = fun(time: TimeInterval(ctimer))
        } else if ctimer == 0 && anotherlist["ply"]! {
            returnToMainMenu()
        }
    }
    
    @objc func gravitys() {
        if timess > 0 {
            timess -= 1
        } else {
            for i in sprites {
                i.position = CGPoint(x: CGFloat.random(in: -4000...4000.0), y: CGFloat.random(in: -4000...4000.0))
            }
            self.physicsWorld.gravity = CGVector(dx: 0.25, dy: 0.25)
            timess = 20
        }
    }
    
    func returnToMainMenu() {
        anotherlist["ply"]! = false
        let lol = UserDefaults.standard
        if bots.count == 0 {
            lol.set(kills+1, forKey: "kills")
            lol.set(kills*10, forKey: "place")
            lol.set(true, forKey:"win")
        } else {
            lol.set(kills+1, forKey: "kills")
            lol.set(kills, forKey: "place")
            lol.set(false, forKey:"win")
        }
        self.isPaused = true
        gameTimer.invalidate()
        self.removeAllChildren()
        self.removeAllActions()
        self.removeFromParent()
        gameOver = false
        if !instr {
            UserDefaults.standard.set(false, forKey: "in")
            UserDefaults.standard.set(1 ,forKey:"joe")
        }
        self.viewController!.performSegue(withIdentifier: "menu", sender: nil)
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
               if mame != "no" && BotsHealth[mame] != nil {
                    BotsHealth[mame] = BotsHealth[mame]! - Int.random(in: 5...20) - damageM
                    if name2.suffix(3) == "ply" {
                        mapView.fillColor = UIColor.random
                    }
                    let isx = contact.contactPoint.x - starting.x
                    let isy = contact.contactPoint.y - starting.y
                    let distances = sqrt(((isx)*(isx))+((isy)*(isy)))
                    meters.text = "\(roundf(Float(distances/300)))M"
                } else if emam != "no" {
                    health -= CGFloat.random(in: 10...30)/swords + CGFloat(damageM)
                    healthBarT.size = CGSize(width: CGFloat(health*2), height: healthBarT.size.height)
                    healthBarT.position.x = ply!.position.x + CGFloat(healthBarB.size.width-CGFloat((200-health))) - 400

                }
            } else if name2.prefix(name2.count-nums3!) == "bulletEpicSniperG" || name1.prefix(name1.count-nums2!) == "bulletEpicSniperG" {
               if mame != "no" && BotsHealth[mame] != nil {
                    BotsHealth[mame] = BotsHealth[mame]! - Int.random(in: 125...175) - damageM
                    if name2.suffix(3) == "ply" {
                        mapView.fillColor = UIColor.random
                    }
                    let isx = contact.contactPoint.x - starting.x
                    let isy = contact.contactPoint.y - starting.y
                    let distances = sqrt(((isx)*(isx))+((isy)*(isy)))
                    meters.text = "\(roundf(Float(distances/300)))M"
                } else if emam != "no" {
                    health -= CGFloat.random(in: 125...175)/swords + CGFloat(damageM)
                    healthBarT.size = CGSize(width: CGFloat(health*2), height: healthBarT.size.height)
                    healthBarT.position.x = ply!.position.x + CGFloat(healthBarB.size.width-CGFloat((200-health))) - 400

                }
            } else if name2.prefix(name2.count-nums3!) == "bulletLegendarySniperG" || name1.prefix(name1.count-nums2!) == "bulletLegendarySniperG" {
               if mame != "no" && BotsHealth[mame] != nil {
                    BotsHealth[mame] = BotsHealth[mame]! - Int.random(in: 150...210) - damageM
                    if name1.suffix(3) == "ply" {
                        mapView.fillColor = UIColor.random
                    }
                    let isx = contact.contactPoint.x - starting.x
                    let isy = contact.contactPoint.y - starting.y
                    let distances = sqrt(((isx)*(isx))+((isy)*(isy)))
                    meters.text = "\(roundf(Float(distances/300)))M"
                } else if emam != "no" {
                    health -= CGFloat.random(in: 150...210)/swords + CGFloat(damageM)
                    healthBarT.size = CGSize(width: CGFloat(health*2), height: healthBarT.size.height)
                    healthBarT.position.x = ply!.position.x + CGFloat(healthBarB.size.width-CGFloat((200-health))) - 400

                }
            } else if name2.prefix(name2.count-nums3!) == "bulletMythicalShotgunG" || name1.prefix(name1.count-nums2!) == "bulletMythicalShotgunG" {
               if mame != "no" && BotsHealth[mame] != nil {
                    BotsHealth[mame] = BotsHealth[mame]! - Int.random(in: 5...25) - damageM
                    if name1.suffix(3) == "ply" {
                        mapView.fillColor = UIColor.random
                    }
                    let isx = contact.contactPoint.x - starting.x
                    let isy = contact.contactPoint.y - starting.y
                    let distances = sqrt(((isx)*(isx))+((isy)*(isy)))
                    meters.text = "\(roundf(Float(distances/300)))M"
                } else if emam != "no" {
                    health -= CGFloat.random(in: 15...45)/swords + CGFloat(damageM)
                    healthBarT.size = CGSize(width: CGFloat(health*2), height: healthBarT.size.height)
                    healthBarT.position.x = ply!.position.x + CGFloat(healthBarB.size.width-CGFloat((200-health))) - 400

                }
            } else if name2.prefix(name2.count-nums3!) == "bulletGreenSpearSP" || name1.prefix(name1.count-nums2!) == "bulletGreenSpearSP" {
                if mame != "no" && BotsHealth[mame] != nil && BotsHealth[mame] != nil {
                    BotsHealth[mame] = BotsHealth[mame]! - Int.random(in: 7...30) - damageM
                    if name1.suffix(3) == "ply" {
                        mapView.fillColor = UIColor.random
                    }
                    let isx = contact.contactPoint.x - starting.x
                    let isy = contact.contactPoint.y - starting.y
                    let distances = sqrt(((isx)*(isx))+((isy)*(isy)))
                    meters.text = "\(roundf(Float(distances/300)))M"
                } else if emam != "no" {
                    health -= CGFloat.random(in: 20...50)/swords + CGFloat(damageM)
                    healthBarT.size = CGSize(width: CGFloat(health*2), height: healthBarT.size.height)
                    healthBarT.position.x = ply!.position.x + CGFloat(healthBarB.size.width-CGFloat((200-health))) - 400
                }
            } else if name2.prefix(name2.count-nums3!) == "bulletRareSpearSP" || name1.prefix(name1.count-nums2!) == "bulletRareSpearSP" {
               if mame != "no" && BotsHealth[mame] != nil {
                    BotsHealth[mame] = BotsHealth[mame]! - Int.random(in: 15...45) - damageM
                    if name1.suffix(3) == "ply" {
                        mapView.fillColor = UIColor.random
                    }
                    let isx = contact.contactPoint.x - starting.x
                    let isy = contact.contactPoint.y - starting.y
                    let distances = sqrt(((isx)*(isx))+((isy)*(isy)))
                    meters.text = "\(roundf(Float(distances/300)))M"
                } else if emam != "no" {
                    health -= CGFloat.random(in: 35...75)/swords + CGFloat(damageM)
                    healthBarT.size = CGSize(width: CGFloat(health*2), height: healthBarT.size.height)
                    healthBarT.position.x = ply!.position.x + CGFloat(healthBarB.size.width-CGFloat((200-health))) - 400
                }
            } else if name2.prefix(name2.count-nums3!) == "bulletRareMachineG" || name1.prefix(name1.count-nums2!) == "bulletRareMachineG" {
               if mame != "no" && BotsHealth[mame] != nil {
                    BotsHealth[mame] = BotsHealth[mame]! - Int.random(in: 5...20) - damageM
                    if name1.suffix(3) == "ply" {
                        mapView.fillColor = UIColor.random
                    }
                    let isx = contact.contactPoint.x - starting.x
                    let isy = contact.contactPoint.y - starting.y
                    let distances = sqrt(((isx)*(isx))+((isy)*(isy)))
                    meters.text = "\(roundf(Float(distances/300)))M"
                } else if emam != "no" {
                    health -= CGFloat.random(in: 15...40)/swords + CGFloat(damageM)
                    healthBarT.size = CGSize(width: CGFloat(health*2), height: healthBarT.size.height)
                    healthBarT.position.x = ply!.position.x + CGFloat(healthBarB.size.width-CGFloat((200-health))) - 400

                }
            } else if name2.prefix(name2.count-nums3!) == "bulletMythicalMachineG" || name1.prefix(name1.count-nums2!) == "bulletMythicalMachineG" {
                if (name2.suffix(3) == "bot") {
                    BotsHealth[mame] = BotsHealth[mame]! - Int.random(in: 10...25) - damageM
                    if name1.suffix(3) == "ply" {
                        mapView.fillColor = UIColor.random
                    }
                    let isx = contact.contactPoint.x - starting.x
                    let isy = contact.contactPoint.y - starting.y
                    let distances = sqrt(((isx)*(isx))+((isy)*(isy)))
                    meters.text = "\(roundf(Float(distances/300)))M"
                } else if emam != "no" {
                    health -= CGFloat.random(in: 25...50)/swords + CGFloat(damageM)
                    healthBarT.size = CGSize(width: CGFloat(health*2), height: healthBarT.size.height)
                    healthBarT.position.x = ply!.position.x + CGFloat(healthBarB.size.width-CGFloat((200-health))) - 400

                }
            } else if name2.prefix(name2.count-nums3!) == "bulletGreenPistolP" || name1.prefix(name1.count-nums2!) == "bulletGreenPistolP" {
               if mame != "no" && BotsHealth[mame] != nil {
                    BotsHealth[mame] = BotsHealth[mame]! - Int.random(in: 10...20) - damageM
                    if name1.suffix(3) == "ply" {
                        mapView.fillColor = UIColor.random
                    }
                    let isx = contact.contactPoint.x - starting.x
                    let isy = contact.contactPoint.y - starting.y
                    let distances = sqrt(((isx)*(isx))+((isy)*(isy)))
                    meters.text = "\(roundf(Float(distances/300)))M"
                } else if emam != "no" {
                    health -= CGFloat.random(in: 30...70)/swords + CGFloat(damageM)
                    healthBarT.size = CGSize(width: CGFloat(health*2), height: healthBarT.size.height)
                    healthBarT.position.x = ply!.position.x + CGFloat(healthBarB.size.width-CGFloat((200-health))) - 400

                }
            } else if name2 == "bulletbeamply" || name1 == "bulletbeamply" {
                if mame != "no" && BotsHealth[mame] != nil {
                     BotsHealth[mame] = BotsHealth[mame]! - 75 - damageM
                     if name1.suffix(3) == "ply" {
                         mapView.fillColor = UIColor.random
                     }
                     let isx = contact.contactPoint.x - starting.x
                     let isy = contact.contactPoint.y - starting.y
                     let distances = sqrt(((isx)*(isx))+((isy)*(isy)))
                     meters.text = "\(roundf(Float(distances/300)))M"
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
                starting = position
            }
            contact.bodyB.node?.removeAllActions()
            contact.bodyB.node?.run(SKAction.scale(to: CGSize(width: 0, height: 0), duration: 1), completion: {
                contact.bodyB.node?.removeFromParent()
            })
        }
        if name2.prefix(6) == "bullet" && emam != "no" {
            contact.bodyA.node?.removeAllActions()
            contact.bodyA.node?.run(SKAction.scale(to: CGSize(width: 0, height: 0), duration: 1), completion: {
                contact.bodyA.node?.removeFromParent()
                self.delet = true
                self.anotherAllow = true
            })
        }
            
       if mame != "no" && BotsHealth[mame] != nil {
            let os = mame.prefix(2)
            var nums:Int? = Int()
            if Int(os) != nil {
                nums = Int(os)
            } else {
                nums = Int(os.prefix(1))
            }
            if BotsHealth[mame] != nil {
                if BotsHealth[mame]! <= 0 {
                    if nums! % 2 == 0 && hungerM {
                        t1.removeValue(forKey: mame)
                    } else {
                       t2.removeValue(forKey: mame)
                    }
                    for i in teamHunting {
                        if i.value.name! == name2 {
                            if i.key != "ply" {
                                let fju = i.key.prefix(2)
                                var noo:Int? = Int()
                                if Int(fju) != nil {
                                    noo = Int(fju)
                                } else {
                                    noo = Int(fju.prefix(1))
                                }
                                if noo! % 2 == 0 && t2.count != 0 {
                                    teamHunting.updateValue(t2.randomElement()!.value, forKey: i.key)
                                } else if t1.count != 0{
                                    teamHunting.updateValue(t1.randomElement()!.value, forKey: i.key)
                                }
                            }
                        }
                    }
                    teamHunting.removeValue(forKey: mame)
                    if bots[mame] != nil {
                        bots[mame]!.removeAllActions()
                        bots[mame]!.removeFromParent()
                        bots.removeValue(forKey: mame)
                    }
                    timer1.removeValue(forKey:name1)
                    BotsHealth.removeValue(forKey: name1)
                    bots.removeValue(forKey: name1)
                    if (name1.suffix(3) == "ply" || name2.suffix(3) == "ply") && (nums! % 2 != 0 || !hungerM) {
                        kills += 1
                    }
                    if pm {
                        anotherlist[name2] = false
                    } else {
                        anotherlist[name2] = false
                    }
                    if nums! % 2 == 0 && hungerM && !pm {
                        total1 -= 1
                    } else {
                        total2 -= 1
                    }
                }
                if pm && BotsHealth["1bot"]! <= 0 {
                     NewCar()
                }
            }
        }
        if health <= 0 {
            self.total1 -= 1
            anotherlist["ply"] = false
            returnToMainMenu()
        }
        if total2 <= 0 && hungerM && !pm {
            returnToMainMenu()
            victoryRoyale = true
        }
        if !hungerM && total1+total2-1 <= 0 && !pm {
            victoryRoyale = true
            returnToMainMenu()
        }
    }
    
    func shoot(whicha: SKSpriteNode, meow:String,name:String) {
        if anotherlist[name]! {
            let Shoot = SKSpriteNode(imageNamed: "bullet")
            Shoot.zPosition = 3
            var name = String()
            Shoot.size = CGSize(width: Shoot.size.width*1.7, height: Shoot.size.height*1.7)
            if let child = whicha.childNode(withName: meow) as? SKSpriteNode {
                var postt = CGPoint()
                if whicha.texture!.name == "racerC" && whicha.parent != nil {
                    postt = child.convert(CGPoint(x: child.position.x, y:200), to: whicha.parent!)
                } else if whicha.texture!.name == "medic" && whicha.parent != nil {
                    postt = child.convert(CGPoint(x: child.position.x, y:50), to: whicha.parent!)
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
    }
    
    func spear(whicha:SKSpriteNode, moew:String,name:String) {
        if anotherlist[name]! {
            let spear = SKSpriteNode()
            anotherAllow = false
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
                self.anotherAllow = true
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
    }
    
    func shotgun(whicha:SKSpriteNode,meow:String,name:String) {
        if anotherlist[name]! {
            let bullets = SKSpriteNode(imageNamed: "shells")
            var name = String()
            if let child = whicha.childNode(withName: meow) as? SKSpriteNode {
                bullets.size = CGSize(width: SKTexture(imageNamed: "shells").size().width, height: SKTexture(imageNamed: "shells").size().height)
                bullets.zPosition = 3
                var position = CGPoint()
                if (whicha.texture!.name == "mountainC" || whicha.texture!.name == "racerC") && whicha.parent != nil {
                    position = child.convert(CGPoint(x: child.position.x, y:200), to: whicha.parent!)
                } else if whicha.texture!.name == "medic" && whicha.parent != nil {
                    position = child.convert(CGPoint(x: child.position.x, y:50), to: whicha.parent!)
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
    }
    
    func sniper(whicha:SKSpriteNode,meow:String,name:String) {
        if anotherlist[name]! {
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
    }
    
    func pistol(whicha:SKSpriteNode,meow:String,name:String) {
        if anotherlist[name]! {
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
    }
    
    func beam(whicha:SKSpriteNode,meow:String,name:String) {
        if anotherlist[name]! {
            let bullet = SKSpriteNode(imageNamed: "beam")
            if let child = whicha.childNode(withName: meow) as? SKSpriteNode {
                bullet.size = CGSize(width: SKTexture(imageNamed: "beam").size().width, height: SKTexture(imageNamed: "beam").size().height)
                bullet.zPosition = 3
                let position = child.convert(CGPoint(x: child.position.x, y: 200), to: whicha.parent!)
                bullet.position = position
            }
            bullet.name = "bulletbeamply"
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
    }
    
    func mini(whicha:SKSpriteNode,meow:String,name:String) {
        if anotherlist[name]! {
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
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if touch.location(in: self).x <= ply!.position.x-500 && mm {
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
                if start.alpha != 0.0 {
                    start.alpha = 0.0
                }
                if UIDevice.current.model != "iPad" {
                    meters.alpha = 0.0
                }
                healthBarB.alpha = 0.0
                healthBarT.alpha = 0.0
                killCount.alpha = 0.0
                killLabel.alpha = 0.0
                player.alpha = 0.0
                self.scene?.backgroundColor = UIColor.black
            } else if atPoint(touch.location(in: self)).name?.suffix(1) == "2" {
                copy1.lineWidth = 7
                copy2.lineWidth = 1
                copy3.lineWidth = 1
                if timer != nil {
                    timer.invalidate()
                }
                if (ply!.texture!.name == "medic" && inve2.texture!.name != "") || (ply!.texture!.name == "racerC" && hasMeds) {
                    inve2.texture = nil
                    if (health + 100) < 200 {
                        health += 100
                        healthBarT.size = CGSize(width: CGFloat(health*2), height: healthBarT.size.height)
                        healthBarT.position.x = ply!.position.x + CGFloat(healthBarB.size.width-CGFloat((200-health)))
                    } else {
                        health = 200
                        healthBarT.size = CGSize(width: CGFloat(health*2), height: healthBarT.size.height)
                        healthBarT.position.x = ply!.position.x + CGFloat(healthBarB.size.width-CGFloat((200-health)))
                    }
                }
                if start.text == "Select the spear" {
                    start.text = "Touch gray circle"
                }
                whichFire = "2"
            } else if atPoint(touch.location(in: self)).name == "3" && instr {
                copy1.lineWidth = 1
                copy2.lineWidth = 7
                copy3.lineWidth = 1
                if timer != nil {
                    timer.invalidate()
                }
                whichFire = "3"
            } else if atPoint(touch.location(in: self)).name == "I1" && instr {
                copy1.lineWidth = 1
                copy2.lineWidth = 1
                copy3.lineWidth = 7
                if timer != nil {
                    timer.invalidate()
                }
                whichFire = "1"
            } else if atPoint(touch.location(in: self)).name == "Start" {
                if instr {
                    CM = true
                    start.removeFromParent()
                }
            } else if atPoint(touch.location(in: self)).name == "fire" && anotherlist["ply"]! {
                if timer != nil {
                    timer.invalidate()
                }
                if start.text == "Touch gray circle" {
                    start.text = "Elminate other car"
                }
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
                } else if whichFire == "1" && inve1.texture?.name.suffix(2) == "er" {
                    timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { (timew) in
                        self.beam(whicha: self.ply!, meow: self.whichFire, name: "ply")
                    })
                } else if whichFire == "2" && inve2.texture?.name.suffix(2) == "er" {
                    timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { (timew) in
                        self.beam(whicha: self.ply!, meow: self.whichFire, name: "ply")
                    })
                } else if whichFire == "3" && inve3.texture?.name.suffix(2) == "er" {
                    timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { (timew) in
                        self.beam(whicha: self.ply!, meow: self.whichFire, name: "ply")
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
                    if start.text == "Move around" {
                        start.text = "Touch white cirle"
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
                if start.text == "Touch white cirle" {
                    start.text = "Select the spear"
                }
                mapView.alpha = 1.0
                joy.alpha = 0.4
                if !CM {
                    start.alpha = 1.0
                }
                base.alpha = 0.4
                if UIDevice.current.model != "iPad" {
                    meters.alpha = 1.0
                }
                healthBarB.alpha = 1.0
                healthBarT.alpha = 1.0
                killCount.alpha = 1.0
                killLabel.alpha = 1.0
                if !pm {
                 player.alpha = 1.0
                }
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
     
    func target(which:String,currentTime:TimeInterval) {
        if anotherlist[which]! {
            let whicha = bots[which]!
            let disxs = whicha.position.x - ply!.position.x
            let disys = whicha.position.y - ply!.position.y
            let distances = sqrt(((disxs)*(disxs))+((disys)*(disys)))
            let contain = 0...1000 ~= distances
            let row2 = self.topLayer.tileRowIndex(fromPosition: whicha.position)
            
            let column2 = self.topLayer.tileColumnIndex(fromPosition: whicha.position)
            let name2 = self.topLayer.tileDefinition(atColumn: column2, row: row2)?.name
            let os = whicha.name!.prefix(2)
            var nums:Int? = Int()
            if Int(os) != nil {
                nums = Int(os)
            } else {
                nums = Int(os.prefix(1))
            }
            if !contain {
                let deltaTime = currentTime - lastUpdateTime
                let currentFPS = 1 / deltaTime
                lastUpdateTime = currentTime
                if name2 == nil {
                    whicha.position = HuntInPack.init(goto: teamHunting[whicha.name!]!, main: whicha, Frames: currentFPS, Area:"nil", Name: nums!).hunter1.position
                } else {
                    whicha.position = HuntInPack.init(goto: teamHunting[whicha.name!]!, main: whicha, Frames: currentFPS, Area: name2!, Name: nums!).hunter1.position
                }
                if timer1[which] != nil {
                    timer1[which]!.invalidate()
                }
            } else if contain {
                let deltaTime = currentTime - lastUpdateTime
                let currentFPS = 1 / deltaTime
                lastUpdateTime = currentTime
                if name2 == nil {
                    whicha.position = HuntInPack.init(goto: teamHunting[whicha.name!]!, main: whicha, Frames: currentFPS, Area:"nil", Name: nums!).hunter1.position
                } else {
                   whicha.position = HuntInPack.init(goto: teamHunting[whicha.name!]!, main: whicha, Frames: currentFPS, Area: name2!, Name: nums!).hunter1.position
                }
                if timer1[which] == nil || !timer1[which]!.isValid || ((delet && bots[which]?.texture?.name == "bmw") || (delet && bots[which]?.texture?.name == "bumbleC")) {
                    if timer1[which] == nil || !timer1[which]!.isValid || delet {
                        if whicha.texture!.name == "bmwC" || whicha.texture!.name == "bumbleC" {
                            if anotherAllow == true {
                                if let child = whicha.childNode(withName: "2") as? SKSpriteNode {
                                    if child.texture!.name.suffix(2) == "SP" {
                                        timer1[which] = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { (timer) in
                                            self.spear(whicha: whicha, moew: "2", name: which)
                                        })
                                    } else {
                                        timer1[which] = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { (timer) in
                                            self.pistol(whicha: whicha, meow: "2", name: which)
                                        })
                                    }
                                }
                            }
                        } else if whicha.texture!.name == "mountainC" {
                            if Int.random(in: 1...2) == 1 {
                                timer1[which] = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true, block: { (timer) in
                                    if Int.random(in: 1...3) == 1 {
                                        self.shotgun(whicha:whicha, meow: "1", name: which)
                                    } else {
                                        self.shotgun(whicha:whicha, meow: "3", name: which)
                                    }
                                })
                            } else {
                                timer1[which] = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true, block: { (timer) in
                                    self.sniper(whicha: whicha, meow: "2", name: which)
                                })
                            }
                        } else if whicha.texture!.name == "lamboC" || whicha.texture!.name == "ferrieC" {
                            if whicha.texture!.name == "lamboC" {
                                timer1[which] = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { (timer) in
                                    self.shoot(whicha:whicha, meow: "3", name: which)
                                })
                            } else {
                                timer1[which] = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { (timer) in
                                    self.shoot(whicha:whicha, meow: "2", name: which)
                                })
                            }
                        }
                            
                    }

                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if !gameOver {
            meters.position = CGPoint(x: ply!.position.x - 500, y: ply!.position.y+(UIScreen.main.bounds.height))
            cam.position = ply!.position
            var to = true
            if total1+total2-1 < 0 {
                to = false
            }
            if pm {
                to = true
            }
            if gm {
                cam2.position = ply!.position
            }
            if to {
                for i in 1...tot {
                    if bots["\(i)bot"] != nil && CM {
                        target(which: "\(i)bot", currentTime: currentTime)
                    } else if pm && CM {
                        target(which: "1bot", currentTime: currentTime)
                    }
                }
            }
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
            if !CM {
                start.position.x = ply!.position.x - 700
                start.position.y = ply!.position.y + 200
            }
            
            let oneSide = stopping.centerOfTile(atColumn: 0, row: 0)
            let twoSide = stopping.centerOfTile(atColumn: rand, row: rand)
            if !((oneSide.x <= ply!.position.x && oneSide.y <= ply!.position.y) && (twoSide.x >= ply!.position.x && twoSide.y >= ply!.position.y)) {
                    if instr {
                    health -= 3
                    healthBarT.size = CGSize(width: CGFloat(health*2), height: healthBarT.size.height)
                    healthBarT.position.x = ply!.position.x + CGFloat(healthBarB.size.width-CGFloat((200-health))) - 400
                    if health <= 0 {
                        self.total1 -= 1
                        anotherlist["ply"] = false
                        returnToMainMenu()
                    }
                }
            }
            self.mapView.position = CGPoint(x: fireButton.position.x-50, y: fireButton.position.y+UIScreen.main.bounds.height*CGFloat(numb)-75)
            player.position = CGPoint(x: ply!.position.x+UIScreen.main.bounds.width/2-CGFloat(75 - anotherone), y: mapView.position.y)
            killCount.position = CGPoint(x: mapView.position.x-100, y: mapView.position.y-250)
            killCount.text = "\(kills)"
            killLabel.position = CGPoint(x: mapView.position.x+50, y: mapView.position.y-250)
            if !hungerM || !CM && !pm {
                player.text = "1 V \(total2+total1-1)"
            } else {
                if pm {
                    player.text = "\(total1) V ∞"
                } else {
                    player.text = "\(total1) V \(total2)"
                }
            }
            
            if move {
                var speed = distance/15
                speed *= CGFloat(speeded)
                let dx = Double((rotation-speed-10) * cos(ply!.zRotation+1.5707963268))
                let dy = Double((rotation-speed-10) * sin(ply!.zRotation+1.5707963268))
                self.ply!.position = CGPoint(x: (Double(ply!.position.x) - dx), y: (Double(ply!.position.y) - dy))
            }
        }
    }
    
}
extension SKTexture {
    var name : String {
        return self.description.slice(start: "'",to: "'")!
    }
}
extension String {
    func slice(start: String, to: String) -> String! {
        return (range(of: start)?.upperBound).flatMap {
            sInd in
            
            (range(of: to, range: sInd..<endIndex)?.lowerBound).map
                {
                    eInd in
                    substring(with:sInd..<eInd)
                    
            }
        }
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0.75...1),
                       green: .random(in: 0.75...1),
                       blue: .random(in: 0.75...1),
                       alpha: 1.0)
    }
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}

extension Dictionary where Value: Equatable {
    func keysForValue(value: Value) -> [Key] {
        return compactMap { (key: Key, val: Value) -> Key? in
            value == val ? key : nil
        }
    }
}
