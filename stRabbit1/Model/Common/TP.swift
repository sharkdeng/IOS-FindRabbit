//
//  TP.swift
//  1MemorySprite
//
//  Created by gamekf8 on 17/01/2018.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import SpriteKit



//TP means Texture Packer, some common funcs
class TP {
    static func addAnimatedFemal(initialTexture: SKTexture, atlas: [SKTexture], time: TimeInterval, scene: SKScene){
        let female = SKSpriteNode(texture: initialTexture)
        female.run(SKAction.repeatForever(SKAction.animate(with: atlas, timePerFrame: time)))
        scene.addChild(female)
    }
}
