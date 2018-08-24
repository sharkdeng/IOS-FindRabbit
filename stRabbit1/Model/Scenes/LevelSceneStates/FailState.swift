//
//  FailState.swift
//  stRabbit1
//
//  Created by gamekf8 on 26/01/2018.
//  Copyright © 2018 com.sj. All rights reserved.
//

import Foundation
import GameplayKit


class FailState: GKState {
    var scene: LevelScene
    
    init(scene: LevelScene){
        self.scene = scene
        super.init()
    }
    
    override func didEnter(from previousState: GKState?) {

        showFail()
        
        self.scene.cards = []
    }
    
    func showFail(){
        let fail = DialogFail(scene: self.scene) 
        self.scene.addChild(fail)
        fail.comeOutAction()
    }
  
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        
        let c = self.scene.childNode(withName: "dialogRootNode")
        c?.removeFromParent()
    }
}
