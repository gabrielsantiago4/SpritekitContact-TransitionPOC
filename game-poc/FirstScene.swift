//
//  GameScene.swift
//  game-poc
//
//  Created by Gabriel Santiago on 23/03/23.
//

import SpriteKit
import GameplayKit
import AVFoundation

class FirstScene: SKScene {

    weak var gameDelegate: firstSceneDelegate?

    var audioplayer: AVAudioPlayer?

    var isTimeCounting : Bool = true
    var isBGMPlaying: Bool = true

    var timerValue = 0 {
        didSet{
            timer.text = "Time: \(timerValue)"
        }
    }

    var timer: SKLabelNode = {
        let timer = SKLabelNode()
        timer.fontSize = 30
        timer.zPosition = 3
        timer.fontColor = .black
        timer.scene?.anchorPoint = CGPoint(x: 1, y: 1)
        return timer
    }()

    var background: SKSpriteNode = {
        let background = SKSpriteNode(imageNamed: "skytwo")
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x: 0.0, y: 0.0)
        background.zPosition = 1
        return background
    }()

    var character: SKSpriteNode = {
        let character = SKSpriteNode(imageNamed: "pidgeotto")
        character.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        character.position = CGPoint(x: 0, y: 0)
        character.zPosition = 2
        character.scale(to: CGSize(width: 100, height: 130))
        character.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 130))
        character.physicsBody?.contactTestBitMask = 0b0010
        character.physicsBody?.collisionBitMask = 0b0001
        return character
    }()

    var ground: SKSpriteNode = {
        let ground = SKSpriteNode(imageNamed: "ground")
        ground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        ground.zPosition = 2
        ground.position = CGPoint(x: 300, y: -10)
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ground.frame.width, height: 165))
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.affectedByGravity = false
        ground.physicsBody?.categoryBitMask = 0b0001
        return ground
    }()

    var obstacleOne: SKSpriteNode = {
        let obstacleOne = SKSpriteNode(imageNamed: "raticate")
        obstacleOne.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        obstacleOne.zPosition = 2
        obstacleOne.physicsBody = SKPhysicsBody(rectangleOf: CGSize(
            width: obstacleOne.frame.width * 0.5,
            height: obstacleOne.frame.height * 0.72))
        obstacleOne.physicsBody?.isDynamic = true
        obstacleOne.physicsBody?.affectedByGravity = true
        obstacleOne.physicsBody?.isDynamic = true
        obstacleOne.physicsBody?.categoryBitMask = 0b0010
        return obstacleOne
    }()

    override public func update(_ currentTime: TimeInterval) {
        if isTimeCounting == true {
            timerValue += 1
        }
    }

    override func didMove(to view: SKView) {
        buildScene()
        self.physicsWorld.contactDelegate = self
        if isBGMPlaying == true {
            playSound(name: "bgm", extension: "mp3")
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        character.run(SKAction.move(by: CGVector(dx: 70, dy: 0), duration: 0.2))
    }
}

extension FirstScene: SetScene {
    func addChildNodes() {
        addChild(character)
        addChild(background)
        addChild(ground)
        addChild(obstacleOne)
        addChild(timer)
    }

    func configureChildNodes() {
        background.size = (self.view?.frame.size)!
        character.position = CGPoint(
            x: self.view!.frame.midX * 0.1,
            y: self.view!.frame.midY + 100)
        obstacleOne.position = CGPoint(
            x: self.view!.frame.midX * 1.2,
            y: self.view!.frame.midY * 0.48)
        timer.position = CGPoint(x: self.view!.frame.midX * 1.7, y: self.view!.frame.midY * 1.8)
        timer.text = "Time: \(timerValue)"
    }


}
extension FirstScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyB == obstacleOne.physicsBody {

            //parando o contador e a música
            self.isTimeCounting = false
            self.audioplayer?.stop()

            //salvando o recorde
            if timerValue > UserDefaults.standard.integer(forKey: "record") {
                UserDefaults.standard.set(self.timerValue, forKey: "record")
            }
            
            //alterando o finalscore da proxima scene
            let nextScene = SecondScene(size: self.size)

            // empurrando a próxima scene
            nextScene.finalScore.text = "\(self.timerValue)"
            let transition = SKTransition.fade(withDuration: 2)
            self.view?.presentScene(nextScene, transition: transition)
        }
    }
}
extension FirstScene {
    func playSound(name: String, extension: String){
        let url = Bundle.main.url(forResource: name, withExtension: `extension`)
        do{
            audioplayer = try AVAudioPlayer(contentsOf: url!)
            audioplayer?.play()
        } catch {
            print(error)
        }
    }
}
