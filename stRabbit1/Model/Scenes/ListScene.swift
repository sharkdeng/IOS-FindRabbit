//
//  ListScene.swift
//  stRabbit1
//
//  Created by sj on 24/01/2018.
//  Copyright © 2018 com.sj. All rights reserved.
//

import Foundation
import SpriteKit


class ListScene: BaseScene {
    
    var margin: CGFloat!

    var levelBtns: [Button] = []
    
    var initated: Bool = false
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)

        generateLevelBtns(cols: 6, rows: 6)
        hideIndicators()
       

    }
    


    func generateLevelBtns(cols: Int, rows: Int){

        if initated {
            return
        }

        let unplayedImg = SKTexture(imageNamed: "level_unplayed")
        let btnWidth = unplayedImg.size().width
        let btnHeight = unplayedImg.size().height
        margin = btnWidth * 0.3
        
        
        let rootNode = SKNode()
        addChild(rootNode)
        let matrixWidth = CGFloat(cols - 1) * (btnWidth + margin)
        let matrixHeight = CGFloat(rows - 1) * (btnHeight + margin)
        rootNode.position = CGPoint(x: -matrixWidth / 2, y: matrixHeight / 2)

        var n: Int = 0
        for i in 1...cols {
            for j in 1...rows {
                n += 1
                
                let levelBtn = Button(texture: unplayedImg)
                levelBtn.name = "level_\(n)"
                rootNode.addChild(levelBtn)
                levelBtn.isUserInteractionEnabled = true
                levelBtn.position = CGPoint(x: (margin + btnWidth) * CGFloat(j - 1), y: -(margin + btnHeight) * CGFloat(i - 1))
                levelBtns.append(levelBtn)
             
                let levelText = SKLabelNode(fontNamed: "Euphemia UCAS")
                levelText.text = "\(n)"
                levelText.verticalAlignmentMode = .center
                levelBtn.addChild(levelText)
                
        
            }
        }

        initated = true
    
    }
    
    
    func hideIndicators(){
        let heart = childNode(withName: "heart")
        let clock = childNode(withName: "clock")
        heart?.isHidden = true
        clock?.isHidden = true
    }


}
