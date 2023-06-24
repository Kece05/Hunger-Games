import SpriteKit
import GameplayKit
import MultipeerConnectivity
import AudioToolbox

class GameScen: SKScene, SKPhysicsContactDelegate, StreamDelegate {
    
    var health = CGFloat(200)
    var time = 180
    var cam = SKCameraNode()
    let base = SKShapeNode(circleOfRadius: 150)
    let joy = SKShapeNode(circleOfRadius: 75)
    let df = SKShapeNode()
    var viewController: UIViewController?
    var rotation = CGFloat(0)
    var disx = CGFloat()
    let x = -800
    let y = -200
    var disy = CGFloat()
    var move = false
    var distance = CGFloat()
    var normalSize = CGSize()
    var gameTimer: Timer!
    var timer : Timer!
    let rand = 25
    var killLabel = SKLabelNode()
    var numb = 1.0
    var end = true
    var thisIsfun = 1.0
    var anoerone = 0
    var reallyWantoSayIt = 0.0
    var SomeMuchVars = 0.0
    let map = SKNode()
    var alive = true
    var playersAlive = 0
    var speared = SKSpriteNode()
    var firstime = true
    var spearO = [String:SKSpriteNode]()
    let topLayer = SKTileMapNode(tileSet: SKTileSet(named: "Sample Grid Tile Set")!, columns: 264, rows: 264, tileSize: CGSize(width: 128, height: 128))
    let shores = SKTileMapNode(tileSet: SKTileSet(named: "Sample Grid Tile Set")!, columns: 262, rows: 262, tileSize: CGSize(width: 128, height: 128))
    let stopping = SKTileMapNode(tileSet: SKTileSet(named: "Sample Grid Tile Set")!, columns: 261, rows: 261, tileSize: CGSize(width: 128, height: 128))
    var inve2 = SKSpriteNode()
    var healthBarT = SKSpriteNode()
    var healthBarB = SKSpriteNode()
    var fireButton = SKShapeNode(circleOfRadius: 125)
    var copy2 = SKShapeNode(rectOf: CGSize(width: 150, height: 150))
    lazy var ply : SKSpriteNode? = {
        return self.childNode(withName: "//player") as? SKSpriteNode
    }()
    var appDelegate: AppDelegate!
    var taskBot = SKSpriteNode()
    var others = [String:SKSpriteNode]()
    var names = [String]()
    var namep = [String]()
    override func didMove(to view: SKView) {
        if end {
            names = UserDefaults.standard.array(forKey: "name")! as! [String]
            namep = names
            playersAlive = names.count
            if firstime {
                self.view?.showsPhysics = false
                self.anchorPoint = .zero
                physicsWorld.speed = 0.9
                UserDefaults.standard.set(true, forKey: "Ingame")
                appDelegate = UIApplication.shared.delegate as? AppDelegate
                taskBot = self.childNode(withName: "bot") as! SKSpriteNode
                self.ply!.name = "ply"
                ply!.texture = SKTexture(imageNamed: "lamboC")
                ply!.size = SKTexture(imageNamed: "lamboC").size()
                self.anchorPoint = .zero
                physicsWorld.speed = 0.9
                
                if (UIDevice.current.model.prefix(3)) == "iPh" {
                    numb = 1.75
                    SomeMuchVars = 1.65
                    anoerone = 100
                    reallyWantoSayIt = 15.0
                } else {
                    SomeMuchVars = 1.2
                    thisIsfun = 1.4
                    reallyWantoSayIt = 25.0
                }
                
                ply!.scale(to: CGSize(width: ply!.size.width/1.5, height: ply!.size.height/1.5))
                names = names.filter { $0 != appDelegate.MCPHandler.peerID!.displayName }
                killLabel = self.childNode(withName: "gameCount") as! SKLabelNode
                for i in names {
                    var OnlineSprite = SKSpriteNode()
                    OnlineSprite = taskBot.copy() as! SKSpriteNode
                    OnlineSprite.texture = SKTexture(imageNamed: "lamboC")
                    OnlineSprite.size = SKTexture(imageNamed: "lamboC").size()
                    OnlineSprite.scale(to: CGSize(width: OnlineSprite.size.width/1.5, height: OnlineSprite.size.height/1.5))
                    OnlineSprite.physicsBody = SKPhysicsBody(rectangleOf: OnlineSprite.size)
                    OnlineSprite.physicsBody?.categoryBitMask = collider.player.rawValue
                    OnlineSprite.physicsBody?.contactTestBitMask = collider.player.rawValue | collider.bullet.rawValue
                    OnlineSprite.physicsBody?.collisionBitMask = collider.player.rawValue | collider.bullet.rawValue
                    others[i] = OnlineSprite
                }
                
                for i in others {
                    self.addChild(i.value)
                }
                taskBot.alpha = 0.0
                taskBot.zPosition = -1
                speared.position = CGPoint(x:Int.random(in: 10000...10000),y:Int.random(in: 10000...10000))
                ply?.physicsBody = SKPhysicsBody(rectangleOf: ply!.size, center: ply!.position)
                ply!.physicsBody?.categoryBitMask = collider.player.rawValue
                ply!.physicsBody?.contactTestBitMask = collider.player.rawValue | collider.bullet.rawValue
                ply!.physicsBody?.collisionBitMask = collider.player.rawValue | collider.bullet.rawValue
                for i in names {
                    let jskd = SKTexture(imageNamed: "RareSpearSP")
                    let spear = SKSpriteNode()
                    spear.texture = SKTexture(imageNamed: "RareSpearSP")
                    spear.size = CGSize(width: jskd.size().width*4, height: jskd.size().height*4)
                    spear.zPosition = 3
                    spear.physicsBody?.categoryBitMask = collider.bullet.rawValue
                    spear.physicsBody?.collisionBitMask = collider.player.rawValue | collider.wall.rawValue
                    spear.physicsBody?.contactTestBitMask = collider.player.rawValue | collider.wall.rawValue
                    spear.physicsBody?.affectedByGravity = false
                    spear.physicsBody = SKPhysicsBody(rectangleOf: spear.size)
                    self.addChild(spear)
                    spear.name = "\(i)"
                    spearO[i] = spear
                    
                }
                
                let textur = SKTexture(imageNamed: "RareSpearSP")
                normalSize = CGSize(width: textur.size().width*4, height: textur.size().height*4)
                
                physicsWorld.contactDelegate = self
                cam = self.childNode(withName: "follow") as! SKCameraNode
                map.xScale = 1
                map.yScale = 1
                let tileSet = SKTileSet(named: "Sample Grid Tile Set")!
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
                self.addChild(speared)
                copy2.strokeColor = UIColor.black
                copy2.fillColor = UIColor(displayP3Red: 142, green: 144, blue:153, alpha: 0.5)
                copy2.zPosition = -1
                
                self.inve2.zPosition = 8
                self.inve2.position = ply!.position
                self.inve2.name = "2"
                self.inve2.size = CGSize(width: 150, height: 150)
                self.inve2.color = UIColor(displayP3Red: 142, green: 144, blue:153, alpha: 0.5)
                self.addChild(inve2)
                copy2.name = "2"
                copy2.position = inve2.position
                copy2.lineWidth = 7
                inve2.addChild(copy2)
                
                topLayer.anchorPoint = CGPoint(x:0.5,y:0.5)
                
                inve2.zPosition = 10
                fireButton.zPosition = 10
                joy.zPosition = 10
                base.zPosition = 10
                healthBarB.zPosition = 10
                healthBarT.zPosition = 10
                
                for i in self.children {
                    if let text = i as? SKSpriteNode {
                        for i in 1...3 {
                            if let child = text.childNode(withName: String(i)) as? SKSpriteNode {
                                if i == 1 || i == 3 {
                                    child.texture = SKTexture(imageNamed: "LegendarySwordS")
                                } else {
                                    child.texture = SKTexture(imageNamed: "RareSpearSP")
                                }
                            }
                        }
                    }
                }
                
                if let childs = ply!.childNode(withName: "2") as? SKSpriteNode {
                    inve2.texture = SKTexture(imageNamed: "RareSpearSP")
                    inve2.size = CGSize(width: ((childs.texture?.size().width)!*1.6), height: ((childs.texture?.size().height)!)*1.6)
                    
                }
                gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
                
                
                NotificationCenter.default.addObserver(self, selector: #selector(revicedMode(notification:)), name: NSNotification.Name(rawValue: "NoLag"), object: nil)
                firstime = false
            } else {
                NotificationCenter.default.addObserver(self, selector: #selector(revicedMode(notification:)), name: NSNotification.Name(rawValue: "NoLag"), object: nil)
            }
        }
    }
    
    ///Fix the winning
    @objc func countdown() {
        if end {
            if time >= 178 {
               time -= 1
                killLabel.text = "Game Mode: FFA"
            } else if time >= 175 {
                time -= 1
                killLabel.text = "Damage Active: \(time-173)"
            } else if time != 0 {
                time -= 1
                killLabel.text = fun(time: TimeInterval(time))
            } else if time+26 == 0  {
                home()
            }
        }
    }
    
    func fun(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    func home() {
        if health <= 1 {
            UserDefaults.standard.set(true, forKey: "Ingame")
        } else {
            UserDefaults.standard.set(false, forKey: "Ingame")
        }
        if spearO.count == 0 {
            UserDefaults.standard.set(appDelegate.MCPHandler.peerID!.displayName, forKey: "winner")
        } else {
            UserDefaults.standard.set(spearO.first!.key, forKey: "winner")
        }
        self.viewController?.performSegue(withIdentifier: "won", sender: nil)
    }
    
    func NoHealth(kill:String) {
        alive = false
        playersAlive -= 1
        do {
            if playersAlive == 1 {
                let data = work2(px: Int16(x), py: Int16(y), r: ply!.zRotation, sx: Int16(-1000), sy: Int16(-1000), sr: 0, NoHealth: true, num: appDelegate.MCPHandler.peerID!.displayName, players: Int8(playersAlive), endGame: true)
                let Speardata = try JSONEncoder().encode(data)
                try appDelegate.MCPHandler.session.send(Speardata, toPeers: appDelegate.MCPHandler.session.connectedPeers, with: .reliable)
                ply!.removeAllChildren()
                ply!.alpha = 0.0
                ply!.zPosition = -2
                ply!.physicsBody? = SKPhysicsBody(rectangleOf: CGSize(width: 0, height: 0))
                healthBarB.removeFromParent()
                healthBarT.removeFromParent()
                killLabel.removeFromParent()
                inve2.removeFromParent()
                fireButton.removeFromParent()
                if kill != "none" {
                    spearO[kill]!.removeAllActions()
                }
                home()
            } else {
                let data = work2(px: Int16(x), py: Int16(y), r: ply!.zRotation, sx: Int16(-1000), sy: Int16(-1000), sr: 0, NoHealth: true, num: appDelegate.MCPHandler.peerID!.displayName, players: Int8(playersAlive), endGame: false)
                let Speardata = try JSONEncoder().encode(data)
                try appDelegate.MCPHandler.session.send(Speardata, toPeers: appDelegate.MCPHandler.session.connectedPeers, with: .reliable)
                ply!.removeAllChildren()
                ply!.alpha = 0.0
                ply!.zPosition = -2
                healthBarB.removeFromParent()
                healthBarT.removeFromParent()
                killLabel.removeFromParent()
                namep = namep.filter { $0 != appDelegate.MCPHandler.peerID!.displayName }
                inve2.removeFromParent()
                fireButton.removeFromParent()
                if kill != "none" {
                    spearO[kill]!.removeAllActions()
                    spearO.removeValue(forKey: kill)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if end {
            let bodya = contact.bodyA.node?.name
            let bodyb = contact.bodyB.node?.name
            var theOne = String()
            if time <= 173 {
                if bodya == "ply" {
                    theOne = bodyb!
                } else if bodyb == "ply" {
                    theOne = bodya!
                }

                if (bodya == ply!.name && bodyb != "bot") || (bodyb == ply!.name && bodya != "bot") && spearO[theOne] != nil {
                    health -= CGFloat(Int.random(in: 25...100))
                    healthBarT.size = CGSize(width: CGFloat(health*2), height: healthBarT.size.height)
                    healthBarT.position.x = ply!.position.x + CGFloat(healthBarB.size.width-CGFloat((200-health))) - 400
                    spearO[theOne]!.removeAllActions()
                    spearO[theOne]!.run(SKAction.scale(to: CGSize(width: 0, height: 0), duration: 0.2), completion: {
                        self.spearO[theOne]!.position = CGPoint(x:10000,y:10000)
                        self.spearO[theOne]!.size = self.normalSize
                        self.spearO[theOne]!.xScale = 1
                        self.spearO[theOne]!.yScale = 1
                    })
                    if health <= 0 {
                        NoHealth(kill: theOne)
                    }
                } else {
                    speared.removeAllActions()
                    speared.run(SKAction.scale(to: CGSize(width: 0, height: 0), duration: 0.2), completion: {
                        self.speared.position = CGPoint(x:10000,y:10000)
                        self.speared.size = self.normalSize
                        self.speared.xScale = 1
                        self.speared.yScale = 1
                        if let child = self.ply!.childNode(withName: "2") as? SKSpriteNode {
                            child.texture = SKTexture(imageNamed: "RareSpearSP")
                            child.alpha = 1.0
                            self.inve2.texture = SKTexture(imageNamed: "RareSpearSP")
                            let tet = SKTexture(imageNamed: "RareSpearSP")
                            self.inve2.size = CGSize(width: ((tet.size().width)*1.6), height: ((tet.size().height))*1.6)
                            self.speared.name = "Yes"
                        }
                    })
                    if #available(iOS 13.0, *) {
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()
                    } else {
                        // Fallback on earlier versions
                        let generator = UIImpactFeedbackGenerator(style: .light)
                        generator.impactOccurred()
                    }
                }
            }
        }
    }
    
    func spear(name: String) {
        if speared.name != "No" {
            let textur = SKTexture(imageNamed: "RareSpearSP")
            speared.texture = SKTexture(imageNamed: "RareSpearSP")
            speared.size = CGSize(width: textur.size().width*1.5, height: textur.size().height*1.5)
            speared.zPosition = 3
            var position = CGPoint()
            if let child = ply!.childNode(withName: "2") as? SKSpriteNode {
                position = child.convert(CGPoint(x: child.position.x, y: 300), to: ply!.parent!)
                speared.position = position
                self.inve2.size = CGSize(width: 150, height: 150)
                inve2.texture = nil
                child.texture = nil
                child.alpha = 0.0
                self.inve2.color = UIColor(displayP3Red: 142, green: 144, blue:153, alpha: 0.5)
            }
            self.speared.name = "No"
            speared.physicsBody?.categoryBitMask = collider.bullet.rawValue
            speared.physicsBody?.collisionBitMask = collider.player.rawValue | collider.wall.rawValue
            speared.physicsBody?.contactTestBitMask = collider.player.rawValue | collider.wall.rawValue
            speared.physicsBody?.affectedByGravity = true
            speared.physicsBody = SKPhysicsBody(rectangleOf: speared.size)
            speared.zRotation = ply!.zRotation
            speared.xScale = 1
            speared.yScale = 1
            self.speared.size = self.normalSize
            let dx = CGFloat(5000) * cos(ply!.zRotation+1.5707963268)
            let dy = CGFloat(5000) * sin(ply!.zRotation+1.5707963268)
            speared.run(SKAction.move(by: CGVector(dx:dx, dy: dy), duration: 2)) {
                if let child = self.ply!.childNode(withName: "2") as? SKSpriteNode {
                    child.texture = SKTexture(imageNamed: "RareSpearSP")
                    child.alpha = 1.0
                    self.inve2.texture = SKTexture(imageNamed: "RareSpearSP")
                    let tet = SKTexture(imageNamed: "RareSpearSP")
                    self.inve2.size = CGSize(width: ((tet.size().width)*1.6), height: ((tet.size().height))*1.6)
                    self.speared.name = "Yes"
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if end {
            for touch in touches {
                if touch.location(in: self).x <= ply!.position.x-500 && UserDefaults.standard.bool(forKey: "mm") {
                    joy.position = touch.location(in: self)
                    base.position = touch.location(in: self)
                }
                if atPoint(touch.location(in: self)).name == "fire" {
                    timer = Timer.scheduledTimer(withTimeInterval: 0, repeats: false, block: { (timew) in
                        self.spear(name: self.appDelegate.MCPHandler.peerID!.displayName)
                    })
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if end {
            for touch in touches {
                let loc = touch.location(in: self)
                if loc.x <= ply!.position.x-500 {
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
                    ply!.run(SKAction.rotate(toAngle: (angle-1.5707963268), duration: 0.001))
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
        if end {
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
            }
        }
    }
    
    func removeCar(name:String) {
        others[name]!.removeFromParent()
        others[name]!.removeAllActions()
        others[name]!.removeAllChildren()
    }
    
    @objc func revicedMode(notification:NSNotification) {
        if end {
            do {
                let message = try JSONDecoder().decode(work2.self, from: notification.object as! Data)
                if playersAlive > Int(message.players) {
                    playersAlive = Int(message.players)
                    namep = namep.filter { $0 != message.num }
                }
                if message.endGame {
                    home()
                }
                if message.NoHealth {
                    removeCar(name: message.num)
                    
                } else {
                    let x = CGFloat(message.px)
                    let y = CGFloat(message.py)
                    let sx = CGFloat(message.sx)
                    let sy = CGFloat(message.sy)
                    others[message.num]!.position = CGPoint(x: x, y: y)
                    others[message.num]!.zRotation = message.r
                    if spearO[message.num] != nil {
                        spearO[message.num]!.position = CGPoint(x: sx, y: sy)
                        spearO[message.num]!.zRotation = message.sr
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if end {
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
            print(namep)
            self.joy.position.y = base.position.y - disy
            let oneSide = stopping.centerOfTile(atColumn: 0, row: 0)
            let twoSide = stopping.centerOfTile(atColumn: rand, row: rand)
            if !((oneSide.x <= ply!.position.x && oneSide.y <= ply!.position.y) && (twoSide.x >= ply!.position.x && twoSide.y >= ply!.position.y)) && time <= 175 {
                health -= 3
                healthBarT.size = CGSize(width: CGFloat(health*2), height: healthBarT.size.height)
                healthBarT.position.x = ply!.position.x + CGFloat(healthBarB.size.width-CGFloat((200-health))) - 400
                if health <= 0 && alive{
                    NoHealth(kill: "none")
                    namep = namep.filter { $0 != appDelegate.MCPHandler.peerID!.displayName }
                }
            }
            killLabel.position = CGPoint(x: fireButton.position.x-100, y: fireButton.position.y+UIScreen.main.bounds.height*CGFloat(numb)-75)
            if move {
                let speed = distance/13
                let dx = Double((rotation-speed-10) * cos(ply!.zRotation+1.5707963268))
                let dy = Double((rotation-speed-10) * sin(ply!.zRotation+1.5707963268))
                self.ply!.position = CGPoint(x: (Double(ply!.position.x) - dx), y: (Double(ply!.position.y) - dy))
            }
            if alive {
                do {
                    let x = (ply!.position.x*1000000).rounded()/1000000
                    let y = (ply!.position.y*1000000).rounded()/1000000
                    let sx = (speared.position.x*1000000).rounded()/1000000
                    let sy = (speared.position.y*1000000).rounded()/1000000
                    let data = work2(px: Int16(x), py: Int16(y), r: ply!.zRotation, sx: Int16(sx), sy: Int16(sy), sr: speared.zRotation, NoHealth: false, num: appDelegate.MCPHandler.peerID!.displayName, players: Int8(playersAlive), endGame: false)
                    let Speardata = try JSONEncoder().encode(data)
                    try appDelegate.MCPHandler.session.send(Speardata, toPeers: appDelegate.MCPHandler.session.connectedPeers, with: .reliable)
                } catch {
                }
            }
        }
    }
}

struct work2:Codable {
    let px: Int16
    let py: Int16
    let r: CGFloat
    let sx: Int16
    let sy: Int16
    let sr: CGFloat
    let NoHealth: Bool
    let num: String
    let players: Int8
    let endGame: Bool
}
