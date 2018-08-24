//
//  BaseScene+Button.swift
//  stRabbit1
//
//  Created by sj on 24/01/2018.
//  Copyright © 2018 com.sj. All rights reserved.
//

import Foundation
import SpriteKit


extension BaseScene: ButtonResponderDelegate {
    func btnTriggered(_ button: Button) {
        switch button.btnType {
            //Main Scene
        case .list:
            let listScene = ListScene(fileNamed: "ListLevelScene")
            self.view?.presentScene(listScene!, transition: SKTransition.doorsOpenHorizontal(withDuration: 0.5))
            
        case .login :
            let gameVC = getVCfromView(uiView: self.view!) as! GameViewController
            gameVC.performSegue(withIdentifier: "gameToLogin", sender: self)
            
            
        //only valid for mainScene
        case .about:
            let aboutScene = BaseScene(fileNamed: "About")
            self.view?.presentScene(aboutScene!)
            
        case .shop:
            let shop = ShopScene(fileNamed: "Shop")
            self.view?.presentScene(shop!)
            
            
        case .level:
            let levelScene = LevelScene(fileNamed: "ListLevelScene")
            let ln = button.children[0] as! SKLabelNode
            levelScene?.levelNum = Int(ln.text!)!
            self.view?.presentScene(levelScene!, transition: SKTransition.fade(withDuration: 0.5))
            
            
        case .dismissNode:
            self.stateMachine?.enter(PlayState.self )
    
        case .next :
            let levelScene = self as! LevelScene
            if levelScene.levelNum == 36 {
                levelScene.levelNum = 1
            } else {
                levelScene.levelNum += 1
            }
            levelScene.stateMachine?.enter(IntroState.self )
            
            
        case .replay:
            self.stateMachine?.enter(IntroState.self )
            
        case .home :
            let homeScene = HomeScene(fileNamed: "HomeScene")
            self.view?.presentScene(homeScene!)
            
        default:
            let homeScene = HomeScene(fileNamed: "HomeScene")
            self.view?.presentScene(homeScene!)
        }
        
    }
    
    
    func findAllButtons() -> [Button] {

        return ButtonType.allButtonTypes.flatMap({ btnType in
            childNode(withName: "//\(btnType.rawValue)") as? Button
        })
    }
    
}
