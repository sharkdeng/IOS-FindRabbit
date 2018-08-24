//
//  LevelScene.swift
//  stRabbit1
//
//  Created by sj on 25/01/2018.
//  Copyright © 2018 com.sj. All rights reserved.
//

import Foundation
import SpriteKit
import PromiseKit
import GameplayKit


enum LevelType: Int {
    case fruit
    case vegetable
    case shape
    case animal
    case alphabet
    case number
    
    static func getAtlasName(levelType: LevelType) -> String {
        switch levelType {
        case .number:
            return "number"
        case .alphabet :
            return "alphabet"
        case .shape:
            return "shape"
        case .animal:
            return "animal"
        case .vegetable:
            return "vegetable"
        case .fruit:
            return "fruit"
        default :
            return "fruit"
        }
    }
}


extension NSNotification.Name {
    static let LevelScenePlay = NSNotification.Name("levelScenePlay")
    static let LevelSceneSuccess = NSNotification.Name("levelSceneSuccess")
    static let LevelSceneFail = NSNotification.Name("levelSceneFail")
}

class LevelScene: BaseScene {
    
    var levelNum: Int = 0
    var levelType: LevelType!
    var cols: Int!
    var hearts: Int = -1 {
        didSet{
            if hearts != oldValue {
                let heartTextNode = childNode(withName: "//heartText") as! SKLabelNode
                heartTextNode.text = String(hearts.description)
            }
        }
    }
    
    
    var clockTextNode: SKLabelNode {
        return childNode(withName: "//clockText") as! SKLabelNode
    }

    var scoreText: String!
    var hurtText: String!
    var eatText: String!
    
    var finalCardTextures: [SKTexture] = []

    var scorePic = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 100, height: 100))
    var remainHeart: Int!
    var scoreNum: Int = 0
    var getScore: Int = 0
    
    let randABC = RandomABC()
    var usedTime: CGFloat = 0.22
    var cards: [Card] = []
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        initiateIndicators()
        
       
        stateMachine = GKStateMachine(states: [IntroState(scene: self),
                                               PlayState(scene: self),
                                               FailState(scene: self),
                                               SuccessState(scene: self)])
        stateMachine?.enter(IntroState.self )

      
    }

   

    
    func initiateIndicators(){
        let chooseLevelText = childNode(withName: "//demoText")
        chooseLevelText?.isHidden = true
        
        let listBtn = childNode(withName: "//home")
        listBtn?.name = "list"

        let demo = childNode(withName: "//demo")
        demo?.addChild(scorePic)
    }
    

 
   
    


    

 
}
