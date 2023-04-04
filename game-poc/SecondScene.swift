//
//  SecondScene.swift
//  game-poc
//
//  Created by Gabriel Santiago on 31/03/23.
//

import GameplayKit
import SpriteKit

class SecondScene: SKScene {

    var finalScore: SKLabelNode = {
        let finalScore = SKLabelNode()
        finalScore.text = "PLACEHOLDER"
        finalScore.fontColor = .systemRed
        finalScore.fontSize = 50
        finalScore.scene?.anchorPoint = CGPoint(x: 1, y: 1)
        finalScore.zPosition = 3
        return finalScore
    }()

    var ratoNoEsgoto: SKSpriteNode = {
        let ratoNoEsgoto = SKSpriteNode(imageNamed: "raticate")
        ratoNoEsgoto.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        ratoNoEsgoto.physicsBody?.isDynamic = true
        ratoNoEsgoto.zPosition = 2
        ratoNoEsgoto.physicsBody = SKPhysicsBody(rectangleOf: CGSize(
            width: ratoNoEsgoto.size.width,
            height: ratoNoEsgoto.size.width * 0.6
        ))
        return ratoNoEsgoto
    }()

    var ground: SKSpriteNode = {
        let ground = SKSpriteNode(imageNamed: "ground")
        ground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        ground.zPosition = 2
        ground.position = CGPoint(x: 300, y: -10)
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ground.size.width, height: ground.size.height * 0.4))
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.affectedByGravity = false
        return ground
    }()


    override func didMove(to view: SKView) {
        buildScene()
    }

}
extension SecondScene: SetScene {
    func addChildNodes() {
        addChild(ratoNoEsgoto)
        addChild(ground)
        addChild(finalScore)
    }

    func configureChildNodes() {
        ratoNoEsgoto.position = CGPoint(
            x: self.view!.frame.midX * 0.1,
            y: self.view!.frame.midY + 100)
        finalScore.position = CGPoint(
            x: self.view!.frame.midX,
            y: self.view!.frame.midY)
    }
}
