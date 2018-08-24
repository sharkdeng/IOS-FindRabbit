//
//  Extension.swift
//  1MemorySprite
//
//  Created by sj on 19/11/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

extension UIView{
    public var width: CGFloat{
        get{
            return self.frame.size.width
        }set{
            var w = self.frame
            w.size.width = newValue
            self.frame = w
        }
    }
}

extension CALayer {
    //borderColor cannot be set directly in storyboard for its type of CGColor doesn't campatible to UIColor in storyboard
    func borderColorFromUIColor(color: UIColor){
        self.borderColor = color.cgColor
    }
}

extension Int {
    func square() -> Int {
        return self * self
    }
}





