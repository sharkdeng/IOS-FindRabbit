//
//  PlayState.swift
//  stRabbit1
//
//  Created by gamekf8 on 26/01/2018.
//  Copyright © 2018 com.sj. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class PlayState: GKState {
    var scene: LevelScene
    let maxMatrixSize: CGFloat = 660
    let marginFactor: CGFloat = 0.2
    

    

    
    init(scene: LevelScene){
        self.scene = scene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        self.scene.scorePic.isHidden = false
        generateCards(cols: self.scene.cols)
        animateCards()

    }

    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return true
    }

    
    //1
    func generateCards(cols: Int){
     
        let rootNode = SKNode()
        rootNode.name = "cardRootNode"
        self.scene.addChild(rootNode)
        
        let cardSize: CGFloat = maxMatrixSize / (CGFloat(cols) + marginFactor * CGFloat(cols - 1))
        let margin = cardSize * marginFactor
        
        
        var id: Int = 0
        for i in 1...cols {
            for j in 1...cols {
                id += 1

                let card = Card(color: UIColor.white, size: CGSize(width: cardSize, height: cardSize))
                card.position = CGPoint(x: CGFloat(j - 1) * (margin + cardSize), y: CGFloat(i - 1) * (margin + cardSize))
                rootNode.addChild(card)
                self.scene.cards.append(card)
                card.id = id
                card.name = "card"
                card.alpha = 0.0
                
            }
            
         
        }
        
        
        rootNode.position = CGPoint(x: -(maxMatrixSize - cardSize) / 2, y: -(maxMatrixSize - cardSize) / 2)
      
        
        //texture
        for card in self.scene.cards {
            card.texture = self.scene.finalCardTextures[card.id - 1]
            card.restoredTexture = self.scene.finalCardTextures[card.id - 1]
        }
        
    }
    
    
    

    
    //2
    func animateCards()  {
        
        for bg in self.scene.cards {
            let random = GKRandomSource().nextUniform()
            
            let scaleS = SKAction.sequence([SKAction.scaleX(to: 1.2, duration: 0.2),
                                            SKAction.scaleX(to: 1.0, duration: 0.1),
                                            SKAction.scaleY(to: 1.2, duration: 0.1),
                                            SKAction.scaleY(to: 1.0, duration: 0.1)])
            
            bg.run(SKAction.sequence([SKAction.wait(forDuration: TimeInterval(random)),
                                      SKAction.group([SKAction.fadeIn(withDuration: 0.5), scaleS])
                                      ]))
            
        }
        
        self.scene.run(SKAction.sequence([SKAction.wait(forDuration: 1.5),
                                          SKAction.run({
                                            self.startCountDown(memoryTime: self.scene.cols)
                                          })]))

    }
    
    
    
    
    //3
    var memoryTimer: Timer!
    func startCountDown(memoryTime: Int){
  
        
        leftTime = memoryTime
        memoryTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.tickDown), userInfo: nil, repeats: true)
   
    }
    
    var leftTime: Int = 0
    @objc func tickDown(){
        
        leftTime -= 1
        
        if leftTime <= 0 {
            guard let timer = memoryTimer else {
                return
            }
            timer.invalidate()
            
            self.scene.run(SKAction.wait(forDuration: 1.0), completion: {
                self.enterFormalPlay()
            })
           
        }
    
        
        self.scene.clockTextNode.text = String(leftTime)
        
    }
    
    
    
    //4
    var playTimer: Timer!
    func enterFormalPlay(){

        for card in self.scene.cards {
            card.flip()
            card.isUserInteractionEnabled = true
        }

        playTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.timeMemory), userInfo: nil, repeats: true)

    }
    
    var usedTime: CGFloat = 0
    @objc func timeMemory(){
        usedTime += 0.01
     
        self.scene.clockTextNode.text = String(format: "%.2f", usedTime)
        
        if self.scene.stateMachine?.currentState is SuccessState || self.scene.stateMachine?.currentState is FailState {
            guard let timer = playTimer else { return }
            timer.invalidate()
            self.scene.usedTime = usedTime

            saveData()
        }
    }
    

    func saveData(){
        let achieve: Achieve = UserAchieveManager.shared.createEntity() as! Achieve
        
        achieve.levelNum = Int16(self.scene.levelNum)
        achieve.scoreNum = Int16(self.scene.scoreNum)
        achieve.usedTime = Float(self.scene.usedTime)
    
        UserAchieveManager.shared.save()
    }
    
    
}










