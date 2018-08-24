//
//  IntroState.swift
//  stRabbit1
//
//  Created by gamekf8 on 26/01/2018.
//  Copyright © 2018 com.sj. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class IntroState: GKState{
    var scene: LevelScene
    
    
    init(scene: LevelScene) {
        self.scene = scene
        super.init()
    }
    
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if stateClass == PlayState.self {
            return true
        }
        return false
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        getLevelType(levelNum: self.scene.levelNum)
        generateCardTexturesArray()
        showRule()
        

    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        
        let c = self.scene.childNode(withName: "dialogRootNode")
        c?.removeFromParent()
    }
    
    
    func showRule()  {
        
        let intro = DialogIntro(scene: self.scene)
        self.scene.addChild(intro)

        intro.memoryTimeTextNode.text = "\(self.scene.cols.description)秒"
        intro.heartTextNode.text = "\(self.scene.cols - 2)个"
        intro.scoreTextNode.text = self.scene.scoreText
        intro.hurtTextNode.text = self.scene.hurtText
        intro.eatTextNode.text = self.scene.eatText
        
        
        intro.comeOutAction()
   
    }
    
    func generateCardTexturesArray(){
        // 1
        //
        let fruitAtlas = SKTextureAtlas(named: LevelType.getAtlasName(levelType: self.scene.levelType))
        var fruitTex = [SKTexture]()
        let names = fruitAtlas.textureNames
        for name  in names {
            fruitTex.append(SKTexture(imageNamed: name))
        }
        
        
        // 2
        let shuffledCards = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: fruitTex) as! [SKTexture]
        let selectedPics = shuffledCards[0..<3]
        
        //2 - 1
        let scorePic = selectedPics[0]
        let hurtPic = selectedPics[1]
        let eatPic = selectedPics[2]
        
        
        //2 -2
        self.scene.scoreText = getTextureName(texture: scorePic.description)
        self.scene.hurtText = getTextureName(texture: hurtPic.description)
        self.scene.eatText = getTextureName(texture: eatPic.description)
        
        //2 -3
        clean(texture: scorePic)
        
        
        
        // 3
        var newCards = [SKTexture]()

        self.scene.randABC.generate(arrayLength: self.scene.cols.square())
        for _ in 0..<self.scene.randABC.score {
            newCards.append(scorePic)
        }
        for _ in 0..<self.scene.randABC.hurt {
            newCards.append(hurtPic)
        }
        for _ in 0..<self.scene.randABC.eat {
            newCards.append(eatPic)
        }
        
        //3 - 2
        self.scene.scoreNum = self.scene.randABC.score
        
        // 4
        self.scene.finalCardTextures = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: newCards) as! [SKTexture]
    }
    
    
    
    func clean(texture: SKTexture){
        self.scene.scorePic.texture = texture
        self.scene.scorePic.isHidden = true
        
        guard  let cardRoot = self.scene.childNode(withName: "cardRootNode") else { return }
        cardRoot.removeFromParent()
        
        self.scene.clockTextNode.text = self.scene.cols.description
        self.scene.hearts = self.scene.cols - 2
        
    }
    
    
    func getLevelType(levelNum: Int){
        let typeIndex = (levelNum - 1) / 6
        self.scene.levelType = LevelType(rawValue: typeIndex)
        self.scene.cols = levelNum % 6 + 2
        self.scene.hearts = self.scene.cols - 2
        
        self.scene.clockTextNode.text = "\(self.scene.cols.description)"
    }
 
    
    
    
  
}
