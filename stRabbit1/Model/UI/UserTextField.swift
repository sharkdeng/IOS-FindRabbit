//
//  UserTextField.swift
//  1MemorySprite
//
//  Created by sj on 17/01/2018.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import UIKit


class UserTextField: UIView{
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.setLineWidth(0.2)
        ctx?.beginPath()
        ctx?.move(to: CGPoint(x: 10, y: self.frame.height / 2))
        ctx?.addLine(to: CGPoint(x: self.frame.width - 10, y: self.frame.height / 2))
        ctx?.closePath()
        ctx?.strokePath()
    }
}
