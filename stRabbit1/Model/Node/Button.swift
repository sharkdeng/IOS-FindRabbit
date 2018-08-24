//
//  Button.swift
//  stRabbit1
//
//  Created by sj on 24/01/2018.
//  Copyright © 2018 com.sj. All rights reserved.
//

import Foundation
import SpriteKit



protocol ButtonResponderDelegate: class {
    func btnTriggered(_ button: Button)
}

enum ButtonType: String {
    case home = "home"
    case list = "list"
    case about = "about"
    case shop = "shop"
    case login = "login"
    
    case level = "level"
    

    case replay = "replay"
    case next = "next"
    case dismissNode = "dismissNode"
    
    
    static func getTypeByName(nodeName: String) -> ButtonType {
        if nodeName == "home" {
            return ButtonType.home
        } else if nodeName == "list" {
            return ButtonType.list
        } else if nodeName == "replay" {
            return ButtonType.replay
        } else if nodeName == "about" {
            return ButtonType.about
        } else if nodeName == "shop" {
            return ButtonType.shop
        } else if nodeName == "login" {
            return ButtonType.login
        } else if nodeName.hasPrefix("level") {
            return ButtonType.level
        } else if nodeName == "next" {
            return ButtonType.next
        } else if nodeName == "dismissNode" {
            return ButtonType.dismissNode
        } else {
            return ButtonType.home
        }
    }
    
    static let allButtonTypes: [ButtonType] = [.home, .list, .shop, .about, .login, .level, .replay, .next, .dismissNode]
}

enum LevelState {
    case unplayed
    case playing
    case played
}

class Button: SKSpriteNode {
    
    
    weak var responder: ButtonResponderDelegate? {
        guard let res = self.scene as? ButtonResponderDelegate else {
            fatalError("Scene is reponder of node")
        }
        return res 
    }
    
    var btnType: ButtonType {
        return ButtonType.getTypeByName(nodeName: self.name!)
    }
   
    
    //when hand is on button
    var isHighlighted: Bool = false {
        didSet {
            
            guard oldValue != isHighlighted else {
                return
            }
            
            removeAllActions()
        
            
            let clickSound = SKAction.playSoundFileNamed(GameConfiguration.Music.btnClickedSound, waitForCompletion: false)
            
            let newScale: CGFloat = isHighlighted ? 0.8 : 1.0
            let scaleAction = SKAction.scale(to: newScale, duration: 0.15)
            
            let newColorBlendFactor: CGFloat = isHighlighted ? 0.6 : 0.0
            let colorBlendAction = SKAction.colorize(withColorBlendFactor: newColorBlendFactor, duration: 0.15)
            

            if isHighlighted {
                run(SKAction.group([clickSound,
                                    scaleAction,
                                    colorBlendAction]))
            } else {
                run(SKAction.group([scaleAction,
                                    colorBlendAction]))
            }
        }
    }
    
    var levelState: LevelState?
    
    func triggerBtn(){
        if isUserInteractionEnabled {
            responder?.btnTriggered(self)
        }
    }

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        isHighlighted = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        isHighlighted = false

        triggerBtn()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        isHighlighted = false
    
    }
}
