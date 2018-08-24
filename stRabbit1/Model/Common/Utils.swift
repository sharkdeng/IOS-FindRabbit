//
//  Utils.swift
//  stRabbit1
//
//  Created by sj on 24/01/2018.
//  Copyright © 2018 com.sj. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit



func getVCfromView(uiView: UIView) -> UIViewController? {
    for v in sequence(first: uiView, next: { $0?.superview}){
        if let responder = v?.next {
            if responder.isKind(of: UIViewController.self ){
            return responder as! UIViewController
            }
        }
    }
    return nil
}


func getTextureName(texture: String) -> String {

    var picName = texture.components(separatedBy: "'")[1]
    picName = picName.components(separatedBy: "_")[1]
    picName = picName.components(separatedBy: ".")[0]
    
    return picName
}


