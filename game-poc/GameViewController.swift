//
//  GameViewController.swift
//  game-poc
//
//  Created by Gabriel Santiago on 23/03/23.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = TitleScene(size: view.bounds.size)
//        scene.gameDelegate = self
        let skView = self.view as! SKView
        skView.contentMode = .scaleAspectFill
        skView.presentScene(scene)
        // Information in screen corner
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = false

    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
