import SpriteKit
import GameplayKit
import MultipeerConnectivity
import AudioToolbox

class GameScene2: SKScene, SKPhysicsContactDelegate, StreamDelegate {
    
    var time = 4
    var cam = SKCameraNode()
    let base = SKShapeNode(circleOfRadius: 150)
    let joy = SKShapeNode(circleOfRadius: 75)
    var viewController: UIViewController?
    var rotation = CGFloat(0)
    var disx = CGFloat()
    let x = -800
    let y = -200
    var disy = CGFloat()
    var move = false
    var distance = CGFloat()
    var timer : Timer!
    var allowed = false
    var game : Timer!
    var multid = true
    var bad = true
    var timesd = 0
    var counter = SKLabelNode()
    var killLabel = SKLabelNode()
    var lastNum = ""
    var numb = 1.0
    var end = true
    var thisIsfun = 1.0
    var locd = CGPoint()
    var antiGras = true
    var vs = CGVector()
    var textures = [SKTexture]()
    var runturn = 0.001
    var speeded = 1
    var anoerone = 0
    var winnerString = ""
    var reallyWantoSayIt = 0.0
    var smalled = false
    var SomeMuchVars = 0.0
    var landBackground:SKTileMapNode!
    var landBackground2:SKTileMapNode!
    var playersAlive = 0
    var firstime = true
    var inve2 = SKSpriteNode()
    var copy2 = SKShapeNode(rectOf: CGSize(width: 150, height: 150))
    lazy var ply : SKSpriteNode? = {
        return self.childNode(withName: "//player") as? SKSpriteNode
    }()
    var appDelegate: AppDelegate!
    var taskBot = SKSpriteNode()
    var others = [String:SKSpriteNode]()
    var names = [String]()
    var checkpoints = Int()
    var checkpointN = [SKSpriteNode]()
    
    override func didMove(to view: SKView) {
        if end {
            names = UserDefaults.standard.array(forKey: "name")! as! [String]
            names.removeDuplicates()
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
                
                textures.append(SKTexture(imageNamed: "lc"))
                textures.append(SKTexture(imageNamed: "blackout"))
                textures.append(SKTexture(imageNamed: "tp"))
                textures.append(SKTexture(imageNamed: "antiGrass"))
                textures.append(SKTexture(imageNamed: "speed"))
                textures.append(SKTexture(imageNamed: "clear"))
                textures.append(SKTexture(imageNamed: "ptp"))
                textures.append(SKTexture(imageNamed: "small"))
                textures.append(SKTexture(imageNamed: "multi"))
                
                ply!.scale(to: CGSize(width: ply!.size.width/1.5, height: ply!.size.height/1.5))
                names = names.filter { $0 != appDelegate.MCPHandler.peerID!.displayName }
                names = names.filter { $0 != "" }
                killLabel = self.childNode(withName: "gameCount") as! SKLabelNode
                counter = self.childNode(withName: "time") as! SKLabelNode
                counter.fontSize = 75
                killLabel.fontSize = 45
                for i in names {
                    var OnlineSprite = SKSpriteNode()
                    OnlineSprite = taskBot.copy() as! SKSpriteNode
                    OnlineSprite.texture = SKTexture(imageNamed: "lamboC")
                    OnlineSprite.size = SKTexture(imageNamed: "lamboC").size()
                    OnlineSprite.scale(to: CGSize(width: OnlineSprite.size.width/1.5, height: OnlineSprite.size.height/1.5))
                    OnlineSprite.physicsBody = SKPhysicsBody(rectangleOf: OnlineSprite.size)
                    OnlineSprite.physicsBody?.categoryBitMask = collider.player.rawValue
                    OnlineSprite.physicsBody?.contactTestBitMask = collider.player.rawValue | 54 | 55
                    OnlineSprite.physicsBody?.collisionBitMask = collider.player.rawValue | 54
                    OnlineSprite.physicsBody?.affectedByGravity = false
                    OnlineSprite.zPosition = 8
                    OnlineSprite.physicsBody!.linearDamping = 0
                    others[i] = OnlineSprite
                }
                
                for i in others {
                    self.addChild(i.value)
                }
                
                for i in 1...4 {
                    let node = self.childNode(withName: "\(i)") as! SKSpriteNode
                    node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
                    node.physicsBody?.categoryBitMask = 0
                    node.physicsBody?.contactTestBitMask = 55
                    node.physicsBody?.collisionBitMask = 0
                    node.physicsBody?.isDynamic = false
                    node.physicsBody?.affectedByGravity = false
                    
                    checkpointN.append(node)
                }
                
                guard let landBackground = childNode(withName: "bottom") as? SKTileMapNode else {
                  fatalError("Background node not loaded")
                }
                self.landBackground = landBackground
                
                guard let landBackground2 = childNode(withName: "top") as? SKTileMapNode else {
                  fatalError("Background node not loaded")
                }
                self.landBackground2 = landBackground2
                
                taskBot.alpha = 0.0
                taskBot.zPosition = -1
                ply?.physicsBody = SKPhysicsBody(rectangleOf: ply!.size, center: ply!.position)
                ply!.physicsBody?.categoryBitMask = collider.player.rawValue
                ply!.physicsBody?.contactTestBitMask = collider.player.rawValue | 54
                ply!.physicsBody?.collisionBitMask = collider.player.rawValue | 54
                ply!.physicsBody?.affectedByGravity = false
                ply!.physicsBody?.linearDamping = 0
                killLabel.text = "Game Mode: Race"
                counter.text = "0:00"
                physicsWorld.contactDelegate = self
                cam = self.childNode(withName: "follow") as! SKCameraNode
                
                self.camera = cam
                self.addChild(joy)
                self.joy.position.x = ply!.position.x + 600
                self.joy.position.y = ply!.position.y - 600
                self.joy.fillColor = UIColor.white
                self.joy.strokeColor = UIColor.white
                self.joy.zPosition = 2
                self.joy.alpha = 0.2
                
                self.addChild(base)
                self.base.position.x = ply!.position.x - 500
                self.base.position.y = ply!.position.y - 100
                self.base.fillColor = UIColor.gray
                self.base.strokeColor = UIColor.gray
                self.base.zPosition = 1
                self.base.alpha = 0.2

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
                
                
                inve2.zPosition = 10
                joy.zPosition = 10
                base.zPosition = 10
                
                game = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
                
                
                NotificationCenter.default.addObserver(self, selector: #selector(revicedMode(notification:)), name: NSNotification.Name(rawValue: "NoLag"), object: nil)
                firstime = false
            } else {
                NotificationCenter.default.addObserver(self, selector: #selector(revicedMode(notification:)), name: NSNotification.Name(rawValue: "NoLag"), object: nil)
            }
        }
    }
    
    @objc func countdown() {
        if end {
            time -= 1
            if time == -6 {
                time += 5
            } else if time == -2 {
                if inve2.texture == nil && multid {
                    let texts = textures.randomElement()
                    if texts!.name == "multi" && Int.random(in:1...25) == 3 {
                        inve2.texture = texts
                        inve2.size = CGSize(width: 145, height: 145)
                    } else {
                    let text = textures.dropLast().randomElement()
                        inve2.texture = text
                        inve2.size = CGSize(width: 145, height: 145)
                    }
                }
            }
            if time == 4 || time == 3 {
                killLabel.text = "READY"
            } else if time == 2 {
                killLabel.text = "SET"
            } else if time == 1{
                killLabel.text = "GO"
            } else if time == 0 {
                killLabel.text = "0/12 Checkpoints"
            } else {
                timesd += 1
                allowed = true
                counter.text = "\(fun(time: TimeInterval(timesd)))"
            }
        }
    }
    
    func fun(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%2i:%02i", minutes, seconds)
    }
    
    func home(winner:String) {
        UserDefaults.standard.set(winner, forKey: "winner")
        end = false
        self.viewController?.performSegue(withIdentifier: "won", sender: nil)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if end {
            if #available(iOS 13.0, *) {
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()
            } else {
                // Fallback on earlier versions
                let generator = UIImpactFeedbackGenerator(style: .light)
                generator.impactOccurred()
            }
            let bodyb = contact.bodyB.node?.name
            let bodya = contact.bodyA.node?.name
            
            if (lastNum == "" || lastNum == "4") && bodyb == "1" && bodya == "ply" {
                lastNum = "1"
                checkpoints += 1
            } else if (lastNum == "1") && bodyb == "2" && bodya == "ply" {
                lastNum = "2"
                checkpoints += 1
            } else if (lastNum == "2") && bodyb == "3" && bodya == "ply" {
                lastNum = "3"
                checkpoints += 1
            } else if (lastNum == "3") && bodyb == "4" && bodya == "ply" {
                lastNum = "4"
                checkpoints += 1
            }
            killLabel.text = "\(checkpoints)/12 Checkpoints"
            
            if checkpoints == 12 {
                winnerString = "with"
                run(SKAction.wait(forDuration: 0.5)) {
                    self.home(winner:self.appDelegate.MCPHandler.peerID!.displayName)
                }

            }
            
            if bodyb == "blackout" && bodya == "ply" && bad {
                landBackground.alpha = 0.0
                landBackground2.alpha = 0.0
                ply!.alpha = 0.0
                run(SKAction.wait(forDuration: 10)) {
                    self.landBackground.alpha = 1.0
                    self.landBackground2.alpha = 1.0
                    self.ply!.alpha = 1.0
                }
            } else if bodyb == "lc" && bodya == "ply" && bad {
                runturn = 3
                run(SKAction.wait(forDuration: 5)) {
                    self.runturn = 0.001
                }
            } else if bodyb == "tp" && bodya == "ply" && bad {
                let mapsize = landBackground2.mapSize
                ply!.run(SKAction.move(to: CGPoint(x: CGFloat.random(in: 1...mapsize.width), y: CGFloat.random(in: 1...mapsize.height)), duration: 0.0))
            } else if bodyb == "antiGrass" && bodya == "ply" {
                antiGras = false
                ply!.texture = SKTexture(imageNamed: "ferrieC")
                run(SKAction.wait(forDuration: 3)) {
                    self.antiGras = true
                    self.ply!.texture = SKTexture(imageNamed: "lamboC")
                }
            } else if bodyb == "speed" && bodya == "ply" {
                speeded = 3
                ply!.texture = SKTexture(imageNamed: "racerC")
                run(SKAction.wait(forDuration: 3)) {
                    self.ply!.texture = SKTexture(imageNamed: "lamboC")
                    self.speeded = 1
                }
            } else if bodyb == "clear" && bodya == "ply" {
                bad = false
                ply!.texture = SKTexture(imageNamed: "mountainC")
                run(SKAction.wait(forDuration: 5)) {
                    self.ply!.texture = SKTexture(imageNamed: "lamboC")
                    self.bad = true
                }
            } else if bodyb == "multi" && bodya == "ply" {
                speeded = 3
                antiGras = false
                multid = false
                bad = false
                self.ply!.texture = SKTexture(imageNamed: "lamboC")
            } else if bodyb == "ptp" && bodya == "ply" && bad {
                ply!.run(SKAction.move(to: others.randomElement()!.value.position, duration: 0.0))
            } else if bodyb == "small" && bodya == "ply" && bad {
                do {
                    let data = work4(px: Int16(self.x), py: Int16(self.y), r: self.ply!.zRotation, num: self.appDelegate.MCPHandler.peerID!.displayName, players: Int8(self.playersAlive), winner: "\(self.winnerString)",posi: CGPoint(x: 0, y: 0), which: "small", size: CGSize(width: 0, height: 0), small: true, v: CGVector(dx: 0, dy: 0), skin: ply!.texture!.name)
                    let Speardata = try JSONEncoder().encode(data)
                    try self.appDelegate.MCPHandler.session.send(Speardata, toPeers: self.appDelegate.MCPHandler.session.connectedPeers, with: .reliable)
                } catch {
                }
                ply!.run(SKAction.scale(by: 0.5, duration: 1))
                speeded = Int(0.35)
                ply!.physicsBody!.affectedByGravity = true
                smalled = true
                ply?.physicsBody = SKPhysicsBody(rectangleOf: ply!.size)
                run(SKAction.wait(forDuration: 6)) {
                    self.speeded = 1
                    self.ply!.physicsBody!.affectedByGravity = false
                    self.ply!.run(SKAction.scale(by: 2, duration: 1))
                    self.smalled = false
                    self.ply?.physicsBody = SKPhysicsBody(rectangleOf: self.ply!.size)
                }
            }
            
            if bodyb == "lc" || bodyb == "impulse" || bodyb == "blackout" || bodyb == "tp" || bodyb == "antiGrass" || bodyb == "speed" || bodyb == "clear" || bodyb == "multi" || bodyb == "ptp" || bodyb == "small" {
                contact.bodyB.node?.removeFromParent()
            }
            if bodya == "ply" && smalled && !(bodyb == "lc" || bodyb == "impulse" || bodyb == "blackout" || bodyb == "tp" || bodyb == "antiGrass" || bodyb == "speed" || bodyb == "clear" || bodyb == "multi" || bodyb == "ptp" || bodyb == "small") {
                ply!.physicsBody?.applyImpulse(CGVector(dx: vs.dx*10, dy: vs.dy*10))
            }
            
            if !smalled {
                ply!.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 0))
            }
        }
    }
    
    func blackout(positio:CGPoint,size:CGSize) {
        let node = SKSpriteNode()
        node.texture = SKTexture(imageNamed:"blackout")
        node.name = "blackout"
        node.size = size
        node.position = positio
        node.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(size.width/2))
        node.zPosition = 6
        node.physicsBody!.categoryBitMask = 54
        node.physicsBody!.isDynamic = false
        node.physicsBody!.contactTestBitMask = collider.player.rawValue
        node.physicsBody!.collisionBitMask = collider.player.rawValue
        node.physicsBody!.affectedByGravity = false
        self.addChild(node)
    }
    
    func lc(positio:CGPoint,size:CGSize) {
        let node = SKSpriteNode()
        node.texture = SKTexture(imageNamed:"lc")
        node.name = "lc"
        node.size = size
        node.position = positio
        node.zPosition = 6
        node.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(size.width/2))
        node.physicsBody?.isDynamic = true
        node.physicsBody!.categoryBitMask = 54
        node.physicsBody!.contactTestBitMask = collider.player.rawValue
        node.physicsBody!.collisionBitMask = collider.player.rawValue
        node.physicsBody!.affectedByGravity = false
        self.addChild(node)
    }
    
    func tp(positio:CGPoint,size:CGSize) {
        let node = SKSpriteNode()
        node.texture = SKTexture(imageNamed:"tp")
        node.name = "tp"
        node.size = size
        node.position = positio
        node.zPosition = 6
        node.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(size.width/2))
        node.physicsBody?.isDynamic = true
        node.physicsBody!.categoryBitMask = 54
        node.physicsBody!.contactTestBitMask = collider.player.rawValue
        node.physicsBody!.collisionBitMask = collider.player.rawValue
        node.physicsBody!.affectedByGravity = false
        self.addChild(node)
    }
    
    func antiGrass(positio:CGPoint,size:CGSize) {
        let node = SKSpriteNode()
        node.texture = SKTexture(imageNamed:"antiGrass")
        node.name = "antiGrass"
        node.size = size
        node.position = positio
        node.zPosition = 6
        node.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(size.width/2))
        node.physicsBody?.isDynamic = true
        node.physicsBody!.categoryBitMask = 54
        node.physicsBody!.contactTestBitMask = collider.player.rawValue
        node.physicsBody!.collisionBitMask = collider.player.rawValue
        node.physicsBody!.affectedByGravity = false
        self.addChild(node)
    }
    
    func speed(positio:CGPoint,size:CGSize) {
        let node = SKSpriteNode()
        node.texture = SKTexture(imageNamed:"speed")
        node.name = "speed"
        node.size = size
        node.position = positio
        node.zPosition = 6
        node.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(size.width/2))
        node.physicsBody?.isDynamic = true
        node.physicsBody!.categoryBitMask = 54
        node.physicsBody!.contactTestBitMask = collider.player.rawValue
        node.physicsBody!.collisionBitMask = collider.player.rawValue
        node.physicsBody!.affectedByGravity = false
        self.addChild(node)
    }
    
    func clear(positio:CGPoint,size:CGSize) {
        let node = SKSpriteNode()
        node.texture = SKTexture(imageNamed:"clear")
        node.name = "clear"
        node.size = size
        node.position = positio
        node.zPosition = 6
        node.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(size.width/2))
        node.physicsBody?.isDynamic = true
        node.physicsBody!.categoryBitMask = 54
        node.physicsBody!.contactTestBitMask = collider.player.rawValue
        node.physicsBody!.collisionBitMask = collider.player.rawValue
        node.physicsBody!.affectedByGravity = false
        self.addChild(node)
    }
    
    func multi(positio:CGPoint,size:CGSize) {
        let node = SKSpriteNode()
        node.texture = SKTexture(imageNamed:"multi")
        node.name = "multi"
        node.size = size
        node.position = positio
        node.zPosition = 6
        node.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(size.width/2))
        node.physicsBody?.isDynamic = true
        node.physicsBody!.categoryBitMask = 54
        node.physicsBody!.contactTestBitMask = collider.player.rawValue
        node.physicsBody!.collisionBitMask = collider.player.rawValue
        node.physicsBody!.affectedByGravity = false
        self.addChild(node)
    }
    
    func ptp(positio:CGPoint) {
        let node = SKSpriteNode()
        node.texture = SKTexture(imageNamed:"ptp")
        node.name = "ptp"
        node.size = CGSize(width: 30, height: 30)
        node.position = positio
        node.zPosition = 6
        node.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(15))
        node.physicsBody?.isDynamic = true
        node.physicsBody!.categoryBitMask = 54
        node.physicsBody!.contactTestBitMask = collider.player.rawValue
        node.physicsBody!.collisionBitMask = collider.player.rawValue
        node.physicsBody!.affectedByGravity = false
        self.addChild(node)
    }
    
    func small(positio:CGPoint,size:CGSize) {
        let node = SKSpriteNode()
        node.texture = SKTexture(imageNamed:"small")
        node.name = "small"
        node.size = size
        node.position = positio
        node.zPosition = 6
        node.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(size.width/2))
        node.physicsBody?.isDynamic = true
        node.physicsBody!.categoryBitMask = 54
        node.physicsBody!.contactTestBitMask = collider.player.rawValue
        node.physicsBody!.collisionBitMask = collider.player.rawValue
        node.physicsBody!.affectedByGravity = false
        self.addChild(node)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if end {
            for touch in touches {
                if touch.location(in: self).x <= ply!.position.x-500 && UserDefaults.standard.bool(forKey: "mm") {
                    joy.position = touch.location(in: self)
                    base.position = touch.location(in: self)
                } else if touch.location(in: self).x >= ply!.position.x-500 {
                    if inve2.texture != nil {
                        let chosef = Int.random(in: 10...600)
                        let numb = CGSize(width: chosef, height: chosef)
                        if inve2.texture!.name == "blackout" {
                            timer = Timer.scheduledTimer(withTimeInterval: 0, repeats: false, block: { (timew) in
                                let pos = touch.location(in: self)
                                do {
                                    let data = work4(px: Int16(self.x), py: Int16(self.y), r: self.ply!.zRotation, num: self.appDelegate.MCPHandler.peerID!.displayName, players: Int8(self.playersAlive), winner: "\(self.winnerString)",posi: pos, which: "blackout", size: numb, small: false, v: CGVector(dx: 0, dy: 0), skin: self.ply!.texture!.name)
                                    let Speardata = try JSONEncoder().encode(data)
                                    try self.appDelegate.MCPHandler.session.send(Speardata, toPeers: self.appDelegate.MCPHandler.session.connectedPeers, with: .reliable)
                                } catch {
                                }
                                self.blackout(positio:pos, size: numb)
                                self.inve2.texture = nil
                            })
                        } else if inve2.texture!.name == "lc" {
                            timer = Timer.scheduledTimer(withTimeInterval: 0, repeats: false, block: { (timew) in
                                let pos = touch.location(in: self)
                                do {
                                    let data = work4(px: Int16(self.x), py: Int16(self.y), r: self.ply!.zRotation, num: self.appDelegate.MCPHandler.peerID!.displayName, players: Int8(self.playersAlive), winner: "\(self.winnerString)",posi: pos, which: "lc", size: numb, small: false, v: CGVector(dx: 0, dy: 0), skin: self.ply!.texture!.name)
                                    let Speardata = try JSONEncoder().encode(data)
                                    try self.appDelegate.MCPHandler.session.send(Speardata, toPeers: self.appDelegate.MCPHandler.session.connectedPeers, with: .reliable)
                                } catch {
                                }
                                self.lc(positio:pos, size: numb)
                                self.inve2.texture = nil
                            })
                        } else if inve2.texture!.name == "tp" {
                            timer = Timer.scheduledTimer(withTimeInterval: 0, repeats: false, block: { (timew) in
                                let pos = touch.location(in: self)
                                do {
                                    let data = work4(px: Int16(self.x), py: Int16(self.y), r: self.ply!.zRotation, num: self.appDelegate.MCPHandler.peerID!.displayName, players: Int8(self.playersAlive), winner: "\(self.winnerString)",posi: pos, which: "tp", size: numb, small: false, v: CGVector(dx: 0, dy: 0), skin: self.ply!.texture!.name)
                                    let Speardata = try JSONEncoder().encode(data)
                                    try self.appDelegate.MCPHandler.session.send(Speardata, toPeers: self.appDelegate.MCPHandler.session.connectedPeers, with: .reliable)
                                } catch {
                                }
                                self.tp(positio:pos, size: numb)
                                self.inve2.texture = nil
                            })
                        } else if inve2.texture!.name == "antiGrass" {
                            timer = Timer.scheduledTimer(withTimeInterval: 0, repeats: false, block: { (timew) in
                                let pos = touch.location(in: self)
                                do {
                                    let data = work4(px: Int16(self.x), py: Int16(self.y), r: self.ply!.zRotation, num: self.appDelegate.MCPHandler.peerID!.displayName, players: Int8(self.playersAlive), winner: "\(self.winnerString)",posi: pos, which: "antiGrass", size: numb, small: false, v: CGVector(dx: 0, dy: 0), skin: self.ply!.texture!.name)
                                    let Speardata = try JSONEncoder().encode(data)
                                    try self.appDelegate.MCPHandler.session.send(Speardata, toPeers: self.appDelegate.MCPHandler.session.connectedPeers, with: .reliable)
                                } catch {
                                }
                                self.antiGrass(positio:pos, size: numb)
                                self.inve2.texture = nil
                            })
                        } else if inve2.texture!.name == "speed" {
                            timer = Timer.scheduledTimer(withTimeInterval: 0, repeats: false, block: { (timew) in
                                let pos = touch.location(in: self)
                                do {
                                    let data = work4(px: Int16(self.x), py: Int16(self.y), r: self.ply!.zRotation, num: self.appDelegate.MCPHandler.peerID!.displayName, players: Int8(self.playersAlive), winner: "\(self.winnerString)",posi: pos, which: "speed", size: numb, small: false, v: CGVector(dx: 0, dy: 0), skin: self.ply!.texture!.name)
                                    let Speardata = try JSONEncoder().encode(data)
                                    try self.appDelegate.MCPHandler.session.send(Speardata, toPeers: self.appDelegate.MCPHandler.session.connectedPeers, with: .reliable)
                                } catch {
                                }
                                self.speed(positio:pos, size: numb)
                                self.inve2.texture = nil
                            })
                        } else if inve2.texture!.name == "clear" {
                            timer = Timer.scheduledTimer(withTimeInterval: 0, repeats: false, block: { (timew) in
                                let pos = touch.location(in: self)
                                do {
                                    let data = work4(px: Int16(self.x), py: Int16(self.y), r: self.ply!.zRotation, num: self.appDelegate.MCPHandler.peerID!.displayName, players: Int8(self.playersAlive), winner: "\(self.winnerString)",posi: pos, which: "clear", size: numb, small: false, v: CGVector(dx: 0, dy: 0), skin: self.ply!.texture!.name)
                                    let Speardata = try JSONEncoder().encode(data)
                                    try self.appDelegate.MCPHandler.session.send(Speardata, toPeers: self.appDelegate.MCPHandler.session.connectedPeers, with: .reliable)
                                } catch {
                                }
                                self.clear(positio:pos, size: numb)
                                self.inve2.texture = nil
                            })
                        } else if inve2.texture!.name == "multi" {
                            timer = Timer.scheduledTimer(withTimeInterval: 0, repeats: false, block: { (timew) in
                                let pos = touch.location(in: self)
                                do {
                                    let data = work4(px: Int16(self.x), py: Int16(self.y), r: self.ply!.zRotation, num: self.appDelegate.MCPHandler.peerID!.displayName, players: Int8(self.playersAlive), winner: "\(self.winnerString)",posi: pos, which: "multi", size: numb, small: false, v: CGVector(dx: 0, dy: 0), skin: self.ply!.texture!.name)
                                    let Speardata = try JSONEncoder().encode(data)
                                    try self.appDelegate.MCPHandler.session.send(Speardata, toPeers: self.appDelegate.MCPHandler.session.connectedPeers, with: .reliable)
                                } catch {
                                }
                                self.multi(positio:pos, size: numb)
                                self.inve2.texture = nil
                            })
                        } else if inve2.texture!.name == "ptp" {
                            timer = Timer.scheduledTimer(withTimeInterval: 0, repeats: false, block: { (timew) in
                                let pos = touch.location(in: self)
                                do {
                                    let data = work4(px: Int16(self.x), py: Int16(self.y), r: self.ply!.zRotation, num: self.appDelegate.MCPHandler.peerID!.displayName, players: Int8(self.playersAlive), winner: "\(self.winnerString)",posi: pos, which: "ptp", size: numb, small: false, v: CGVector(dx: 0, dy: 0), skin: self.ply!.texture!.name)
                                    let Speardata = try JSONEncoder().encode(data)
                                    try self.appDelegate.MCPHandler.session.send(Speardata, toPeers: self.appDelegate.MCPHandler.session.connectedPeers, with: .reliable)
                                } catch {
                                }
                                self.ptp(positio:pos)
                                self.inve2.texture = nil
                            })
                        } else if inve2.texture!.name == "small" {
                            timer = Timer.scheduledTimer(withTimeInterval: 0, repeats: false, block: { (timew) in
                                let pos = touch.location(in: self)
                                do {
                                    let data = work4(px: Int16(self.x), py: Int16(self.y), r: self.ply!.zRotation, num: self.appDelegate.MCPHandler.peerID!.displayName, players: Int8(self.playersAlive), winner: "\(self.winnerString)",posi: pos, which: "small", size: numb, small: false, v: CGVector(dx: 0, dy: 0), skin: self.ply!.texture!.name)
                                    let Speardata = try JSONEncoder().encode(data)
                                    try self.appDelegate.MCPHandler.session.send(Speardata, toPeers: self.appDelegate.MCPHandler.session.connectedPeers, with: .reliable)
                                } catch {
                                }
                                self.small(positio:pos,size:numb)
                                self.inve2.texture = nil
                            })
                        }
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if end {
            for touch in touches {
                if allowed {
                    let loc = touch.location(in: self)
                    if loc.x <= ply!.position.x-500 {
                        if UserDefaults.standard.bool(forKey: "im") {
                            move = false
                        } else {
                            move = true
                        }
                        locd = loc
                        self.base.alpha = 0.4
                        self.joy.alpha = 0.4
                        let v = CGVector(dx: loc.x-base.position.x, dy: loc.y-base.position.y)
                        let angle = atan2(v.dy, v.dx)
                        let xDist: CGFloat = sin(angle-4.7123889804) * 125
                        let yDist: CGFloat = cos(angle-4.7123889804) * 125
                        ply!.run(SKAction.rotate(toAngle: (angle-1.5707963268), duration: TimeInterval(runturn)))
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
    
    @objc func revicedMode(notification:NSNotification) {
        if end {
            do {
                let message = try JSONDecoder().decode(work4.self, from: notification.object as! Data)
                playersAlive = Int(message.players)
                let x = CGFloat(message.px)
                let y = CGFloat(message.py)
                others[message.num]!.position = CGPoint(x: x, y: y)
                others[message.num]!.zRotation = message.r
                if message.winner == "with" {
                    home(winner:message.num)
                }
                
                if message.posi != CGPoint(x:0,y:0) && message.which != "" {
                    if message.which == "blackout" {
                        blackout(positio: message.posi, size: message.size)
                    } else if message.which == "lc" {
                        lc(positio: message.posi, size: message.size)
                    } else if message.which == "tp" {
                        tp(positio: message.posi, size: message.size)
                    } else if message.which == "antiGrass" {
                        antiGrass(positio: message.posi, size: message.size)
                    } else if message.which == "speed" {
                        speed(positio: message.posi, size: message.size)
                    } else if message.which == "clear" {
                        clear(positio: message.posi, size: message.size)
                    } else if message.which == "multi" {
                        multi(positio: message.posi, size: message.size)
                    } else if message.which == "ptp" {
                        ptp(positio: message.posi)
                    } else if message.which == "small" {
                        small(positio: message.posi,size:message.size)
                    }
                }
                vs = CGVector(dx: message.v.dy*3, dy: message.v.dy*3)
                others[message.num]!.texture = SKTexture(imageNamed: message.skin)
                if message.small {
                    others[message.num]?.run(SKAction.scale(by: 0.5, duration: 1))
                    others[message.num]?.physicsBody = SKPhysicsBody(rectangleOf: others[message.num]!.size)
                    run(SKAction.wait(forDuration: 6)) {
                        self.others[message.num]?.run(SKAction.scale(by: 2, duration: 1))
                        self.others[message.num]?.physicsBody = SKPhysicsBody(rectangleOf: self.others[message.num]!.size)
                    }
                }
            } catch {
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if end {
            // Called before each frame is rendered
            cam.position = ply!.position

            inve2.position = CGPoint(x: ply!.position.x, y: ply!.position.y-(UIScreen.main.bounds.height/2)-CGFloat(reallyWantoSayIt*10))
            self.base.position.x = ply!.position.x + CGFloat(x)
            self.base.position.y = ply!.position.y +  CGFloat(y)
            self.joy.position.x = base.position.x - disx
            self.joy.position.y = base.position.y - disy

            counter.position = CGPoint(x: ply!.position.x+900, y: ply!.position.y+UIScreen.main.bounds.height*CGFloat(numb)-325)
            killLabel.position = CGPoint(x: counter.position.x+25, y: counter.position.y-100)
            if move {
                let row = self.landBackground2.tileRowIndex(fromPosition: ply!.position)
                let column = self.landBackground2.tileColumnIndex(fromPosition: ply!.position)
                let name = self.landBackground2.tileDefinition(atColumn: column, row: row)?.name
                var speed = distance/8
                if name != nil && antiGras {
                    speed = distance/45
                }
                speed *= CGFloat(speeded)
                let dx = Double((rotation-speed-10) * cos(ply!.zRotation+1.5707963268))
                let dy = Double((rotation-speed-10) * sin(ply!.zRotation+1.5707963268))
                self.ply!.position = CGPoint(x: (Double(ply!.position.x) - dx), y: (Double(ply!.position.y) - dy))
            }
            do {
                let x = (ply!.position.x*1000000).rounded()/1000000
                let y = (ply!.position.y*1000000).rounded()/1000000
                let data = work4(px: Int16(x), py: Int16(y), r: ply!.zRotation, num: appDelegate.MCPHandler.peerID!.displayName, players: Int8(playersAlive), winner: "\(winnerString)" ,posi: CGPoint(x:0,y:0),which:"", size: CGSize(width: 0, height: 0), small: false, v: CGVector(dx: locd.x-base.position.x, dy: locd.y-base.position.y), skin: ply!.texture!.name)
                let Speardata = try JSONEncoder().encode(data)
                try appDelegate.MCPHandler.session.send(Speardata, toPeers: appDelegate.MCPHandler.session.connectedPeers, with: .reliable)
            } catch {
            }
        }
    }
}

struct work4:Codable {
    let px: Int16
    let py: Int16
    let r: CGFloat
    let num: String
    let players: Int8
    let winner: String
    let posi:CGPoint
    let which:String
    let size:CGSize
    let small:Bool
    let v: CGVector
    let skin:String
}

