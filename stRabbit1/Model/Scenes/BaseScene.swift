//
//  BaseScene.swift
//  stRabbit1
//
//  Created by sj on 24/01/2018.
//  Copyright © 2018 com.sj. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit
import GameplayKit


class BaseScene: SKScene {
    var bg: SKSpriteNode? {
        return childNode(withName: "bg") as! SKSpriteNode
    }
    
    var contentSize = CGSize.zero
    
    var cameraNode: SKCameraNode!
    
    var buttons: [Button] = []

    var stateMachine: GKStateMachine?
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        createCamera()
        updateCameraScale()
        setAllBtns()
    }
    
    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        
        updateCameraScale()
    }
    
    func createCamera(){
        if let bg = bg {
            contentSize = bg.size
        } else {
            contentSize = size
        }
        
        cameraNode = SKCameraNode()
        addChild(cameraNode)
        self.camera = cameraNode
        updateCameraScale()
    }
    
    func centerCamera(point: CGPoint){
        if let camera = cameraNode {
            cameraNode.position = point
        }
    }
    
    func updateCameraScale(){
        if let cameraNode = cameraNode {
            cameraNode.setScale(contentSize.height / self.size.height)
        }
    }
    
    func getBgMusicFromScene(name: String) -> String {
        if name == "HomeScene" {
            return GameConfiguration.Music.homeBgMusic
        } else if name == "ListScene" {
            return GameConfiguration.Music.listBgMusic
        } else if name == "LevelScene" {
            return GameConfiguration.Music.levelBgMusic
        } else {
            return GameConfiguration.Music.homeBgMusic
        }
    }
    
 
    func setAllBtns(){
        buttons = findAllButtons()
        for btn in buttons {
            btn.isUserInteractionEnabled = true
        }
    }
    
    func setAllFonts(){
        enumerateChildNodes(withName: "SKLabelNode") { (node, stop) in
            let n = node as! SKLabelNode
            n.fontName = "Euphemia UCAS"
            
        }
    }
    
}
