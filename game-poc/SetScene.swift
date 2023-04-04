//
//  SetScene.swift
//  game-poc
//
//  Created by Gabriel Santiago on 28/03/23.
//

import Foundation

protocol SetScene {
    func addChildNodes()
    func configureChildNodes()
}
extension SetScene {
    func buildScene(){
        addChildNodes()
        configureChildNodes()
    }
}
