//
//  SuccessState.swift
//  stRabbit1
//
//  Created by gamekf8 on 26/01/2018.
//  Copyright © 2018 com.sj. All rights reserved.
//

import Foundation
import GameplayKit


class SuccessState: GKState {
    var scene: LevelScene
    
    init(scene: LevelScene){
        self.scene = scene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        showSuccess()
        Rate.popRateAlert()
        
        self.scene.cards = []
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        
        let c = self.scene.childNode(withName: "dialogRootNode")
        c?.removeFromParent()
    
    }
    
    
    func showSuccess(){
        let success = DialogSuccess(scene: self.scene)
        self.scene.addChild(success)
        
        success.comeOutAction()
        success.glow.run(SKAction.repeatForever(SKAction.rotate(byAngle: 0.1, duration: 1.0)))
    }
    

    
    

}
