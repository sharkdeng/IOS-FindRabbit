//
//  Dialog.swift
//  stRabbit1
//
//  Created by gamekf8 on 26/01/2018.
//  Copyright © 2018 com.sj. All rights reserved.
//

import Foundation
import SpriteKit




class Dialog: SKNode{
    
    let bgMask = SKSpriteNode(color: UIColor.black, size: UIScreen.main.bounds.size)
    var dialogBg = SKSpriteNode(imageNamed: "dialog_tl")
    
    
    init(scene: LevelScene) {
        super.init()
        
        addChild(bgMask)
        bgMask.size = scene.bg!.size
        bgMask.position = scene.bg!.position
        bgMask.alpha = 0.8
        
        addChild(dialogBg)
        
        self.name = "dialogRootNode"
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func comeOutAction(){
        self.dialogBg.position = CGPoint(x: 0, y: -667)
        self.dialogBg.alpha = 0.0
        self.dialogBg.run(SKAction.sequence([SKAction.group([SKAction.fadeIn(withDuration: 0.2),
                                                    SKAction.move(to: CGPoint(x: 0, y: 160), duration: 0.2)]),
                                    SKAction.sequence([SKAction.scaleX(to: 1.2, duration: 0.1),
                                                       SKAction.scaleX(to: 1.0, duration: 0.1),
                                                       SKAction.scaleY(to: 1.1, duration: 0.1),
                                                       SKAction.scaleY(to: 1.0, duration: 0.1)])]))
    }
    
}



class DialogIntro: Dialog {
    

    var timeAndHeart = SKLabelNode(text: "你有    记忆时间，  元气")
    var memoryTimeTextNode = SKLabelNode(text: "0")
    var heartTextNode = SKLabelNode(text: "0")
    
    var score = SKLabelNode(text: "抓到             得分")
    var scoreTextNode = SKLabelNode(text: "0")
    
    var hurt = SKLabelNode(text: "抓到             减少元气")
    var hurtTextNode = SKLabelNode(text: "0")
    
    var eat = SKLabelNode(text: "抓到             挑战失败")
    var eatTextNode = SKLabelNode(text: "0")
    
    override init(scene: LevelScene) {
        super.init(scene: scene)

        
        //cancel button
        let u = Button(imageNamed: "u_cancel")
        dialogBg.addChild(u)
        u.name = "dismissNode"
        u.isUserInteractionEnabled = true
        u.position = CGPoint(x: 200, y: 100)
        
        
        //1st line
        dialogBg.addChild(timeAndHeart)
        timeAndHeart.position = CGPoint(x: -230, y: -30)
        timeAndHeart.fontColor = UIColor.black
        timeAndHeart.horizontalAlignmentMode = .left
        
        dialogBg.addChild(memoryTimeTextNode)
        memoryTimeTextNode.position = CGPoint(x: -150, y: -30)
        memoryTimeTextNode.horizontalAlignmentMode = .left
        memoryTimeTextNode.fontColor = UIColor.blue
        
        dialogBg.addChild(heartTextNode)
        heartTextNode.position = CGPoint(x: 80, y: -30)
        heartTextNode.horizontalAlignmentMode = .left
        heartTextNode.fontColor = UIColor.blue
        
        //2nd line
        dialogBg.addChild(score)
        score.position = CGPoint(x: -230, y: -100)
        score.fontColor = UIColor.black
        score.horizontalAlignmentMode = .left
        
        dialogBg.addChild(scoreTextNode)
        scoreTextNode.position = CGPoint(x: -50, y: -100)
        scoreTextNode.fontColor = UIColor.blue
        
        //3rd line
        dialogBg.addChild(hurt)
        hurt.position = CGPoint(x: -230, y: -180)
        hurt.fontColor = UIColor.black
        hurt.horizontalAlignmentMode = .left
        
        dialogBg.addChild(hurtTextNode)
        hurtTextNode.position = CGPoint(x: -50, y: -180)
        hurtTextNode.fontColor = UIColor.blue
        
        //4the line
        dialogBg.addChild(eat)
        eat.position = CGPoint(x: -230, y: -260)
        eat.fontColor = UIColor.black
        eat.horizontalAlignmentMode = .left
        
        dialogBg.addChild(eatTextNode)
        eatTextNode.position = CGPoint(x: -50, y: -260)
        eatTextNode.fontColor = UIColor.blue
        
        
        //common
        dialogBg.enumerateChildNodes(withName: "SKLabelNode") { (node, stop) in
            let node = node as! SKLabelNode
            node.fontName = "Euphemia UCAS"
            node.fontSize = CGFloat(36)
            node.verticalAlignmentMode = .center
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



class DialogSuccess: Dialog {
    var glow = SKSpriteNode(imageNamed: "glow")
    

    
    
    override init(scene: LevelScene) {
        super.init(scene: scene)
        
        addChild(glow)
        glow.position = CGPoint(x: 0, y: 200)
        dialogBg.zPosition += 1
        
        //change dialog skin
        let skin = UIImage(named: "dialog_l")
        dialogBg.size = skin!.size
        dialogBg.texture = SKTexture(image: skin!)
        
       
        //btns
        let listBtn = Button(imageNamed: "u_list")
        let replayBtn = Button(imageNamed: "u_replay")
        let nextBtn = Button(imageNamed: "u_next")
        listBtn.isUserInteractionEnabled = true
        replayBtn.isUserInteractionEnabled = true
        nextBtn.isUserInteractionEnabled = true
        listBtn.name = "list"
        replayBtn.name = "replay"
        nextBtn.name = "next"
        dialogBg.addChild(listBtn)
        dialogBg.addChild(replayBtn)
        dialogBg.addChild(nextBtn)
        listBtn.position = CGPoint(x: -160, y: -200)
        replayBtn.position = CGPoint(x: 0, y: -200)
        nextBtn.position = CGPoint(x: 160, y: -200)
        
        
        //stars
        let starC = SKSpriteNode(imageNamed: "star_c")
        dialogBg.addChild(starC)
        starC.position = CGPoint(x: 0, y: 200)
        
        let starL = SKSpriteNode(imageNamed: "star_l")
        dialogBg.addChild(starL)
        starL.position = CGPoint(x: -200, y: 135)
        
        let starR = SKSpriteNode(imageNamed: "star_r")
        dialogBg.addChild(starR)
        starR.position = CGPoint(x: 200, y: 135)
        
        
        let title = SKLabelNode(text: "成功！你真棒！")
        dialogBg.addChild(title)
        title.fontName = "Euphemia UCAS"
        title.fontSize = CGFloat(36)
        title.fontColor = UIColor.black
        title.position = CGPoint(x: 0, y: 25)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class DialogFail: Dialog {

    
    override init(scene: LevelScene) {
        super.init(scene: scene)
        
        let skin = UIImage(named: "dialog_l")
        dialogBg.size = skin!.size
        dialogBg.texture = SKTexture(image: skin!)
        
        let darkCloud = SKSpriteNode(imageNamed: "darkCloud")
        dialogBg.addChild(darkCloud)
        darkCloud.position = CGPoint(x: 0, y: 250)
        
        let rain = SKEmitterNode(fileNamed: "rain")
        darkCloud.addChild(rain!)
        rain?.isUserInteractionEnabled = false
        
        //btns
        let listBtn = Button(imageNamed: "u_list")
        let replayBtn = Button(imageNamed: "u_replay")
        let nextBtn = Button(imageNamed: "u_next")
        listBtn.isUserInteractionEnabled = true
        replayBtn.isUserInteractionEnabled = true
        nextBtn.isUserInteractionEnabled = true
        listBtn.name = "list"
        replayBtn.name = "replay"
        nextBtn.name = "next"
        dialogBg.addChild(listBtn)
        dialogBg.addChild(replayBtn)
        dialogBg.addChild(nextBtn)
        listBtn.position = CGPoint(x: -160, y: -200)
        replayBtn.position = CGPoint(x: 0, y: -200)
        nextBtn.position = CGPoint(x: 160, y: -200)
        
        
        
        let title = SKLabelNode(text: "挑战失败")
        dialogBg.addChild(title)
        title.fontName = "Euphemia UCAS"
        title.fontSize = CGFloat(36)
        title.fontColor = UIColor.black
        title.position = CGPoint(x: 0, y: 100)
        
        let info = SKLabelNode(text: "别灰心，再试一次吧")
        dialogBg.addChild(info)
        info.fontName = "Euphemia UCAS"
        info.fontSize = CGFloat(36)
        info.fontColor = UIColor.black
        info.position = CGPoint(x: 0, y: 0)

        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
