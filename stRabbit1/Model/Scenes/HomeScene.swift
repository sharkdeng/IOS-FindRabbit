//
//  HomeScene.swift
//  stRabbit1
//
//  Created by sj on 24/01/2018.
//  Copyright © 2018 com.sj. All rights reserved.
//

import Foundation
import SpriteKit


class HomeScene: BaseScene {

    
    override func didMove(to view: SKView) {
        super.didMove(to: view)

        addAnim()
        
    }
    
    func addAnim(){
        let carrot = childNode(withName: "carrot")
        let rabbit = childNode(withName: "rabbit")
        let logo = childNode(withName: "logo")
        
        let carrotMove = SKAction(named: "carrot_move")
        carrot?.run(SKAction.repeatForever(carrotMove!))
        
        logo?.run(SKAction.repeatForever(SKAction.sequence([SKAction.scaleX(to: 1.05, duration: 0.2),
                                                            SKAction.scaleX(to: 1.0, duration: 0.1),
                                                            SKAction.scaleY(to: 1.2, duration: 0.2),
                                                            SKAction.scaleY(to: 1.0, duration: 0.2)])))

        
        let snow = SKEmitterNode(fileNamed: "snow.sks")
        //or particle will block buttons' events
        bg?.addChild(snow!)
        snow?.position = CGPoint(x: 0, y: bg!.size.height / 2)
        snow?.isUserInteractionEnabled = false
        
        
     
      
    }
    
    

    
    
}
