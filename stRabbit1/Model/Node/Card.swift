//
//  Card.swift
//  stRabbit1
//
//  Created by gamekf8 on 26/01/2018.
//  Copyright © 2018 com.sj. All rights reserved.
//

import Foundation
import SpriteKit

class Card: SKSpriteNode {
    var id: Int!
    
    var restoredTexture: SKTexture!
    var backTexture: SKTexture {
        return SKTexture(imageNamed: "back_card.png")
    }
    
    var isFront: Bool = false
    
    var levelScene: LevelScene {
        return self.scene as! LevelScene
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //add some particle
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if isUserInteractionEnabled {
                isFront = !isFront
                flip()
                judgeOutcome()
            }
        }
        
    }
    
    func flip(){
        if isFront {
            self.texture = restoredTexture
        } else {
            self.texture = backTexture
        }
    }
    
    func judgeOutcome(){
        let textureName = getTextureName(texture: self.texture!.description)
        if textureName == levelScene.scoreText {
            win()
        } else if textureName == levelScene.hurtText {
            hurt()
        } else if textureName == levelScene.eatText {
            lose()
        }
    }
    

    func win(){
  
        levelScene.getScore += 1
        
        //every
        run(SKAction.wait(forDuration: 1.0)) {
            
            self.run(SKAction.removeFromParent())
            
            if self.levelScene.getScore == self.levelScene.scoreNum {
                self.levelScene.getScore = 0
                self.levelScene.stateMachine?.enter(SuccessState.self )
            }
            
            self.removeFromParent()
        }

    }
    
    func hurt(){

        levelScene.hearts -= 1
        
        run(SKAction.wait(forDuration: 1.0)) {
            self.isFront = false
            self.flip()
        }
        
        if self.levelScene.hearts < 0 {
            self.lose()
        }
        

    }
    
    func lose(){
        //in case of multi touch fail state
        let cardRootNode = self.scene?.childNode(withName: "cardRootNode")
        cardRootNode?.enumerateChildNodes(withName: "SKSpriteNode", using: { (node, stop) in
            node.isUserInteractionEnabled = false
        })
        
        
        run(SKAction.wait(forDuration: 1.0)) {
            self.levelScene.stateMachine?.enter(FailState.self )
        }
        
    }
    
}
