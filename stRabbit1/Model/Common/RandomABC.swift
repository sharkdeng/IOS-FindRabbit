//
//  RandomABC.swift
//  stRabbit1
//
//  Created by sj on 27/01/2018.
//  Copyright © 2018 com.sj. All rights reserved.
//

import Foundation

//rules:
//a + b + c = arrayLength
//a > b > c

class RandomABC {
    //score
    var score: Int = 0
    //hurt
    var hurt: Int = 0
    //eat
    var eat: Int = 0
    
    var oldArrayLength: Int = 0
    
    func generate(arrayLength: Int){
        if arrayLength == 4 {
            score = 3
            hurt = 1
            eat = 0
            return
        } else {
            
            
            //new matrix
            if arrayLength != oldArrayLength {
                oldArrayLength = arrayLength
                
                score = 1
                eat = 2
                hurt = arrayLength - score - eat
                
            } else if hurt > 2 {
  
                score += 1
                eat = 2
                hurt = arrayLength - self.score - self.eat
                
            } else if hurt < 3 {
                    //[0. arrayLength-1]
                    let a = Int(arc4random_uniform(UInt32(arrayLength)))
                    
                    let b = Int(arc4random_uniform(UInt32(arrayLength - a)))
                    
                    let c = arrayLength - a - b
                    
                    
                    if a == b || b == c || a == c || c == 0 || b == 0 || a == 0 {
                        generate(arrayLength: arrayLength)
                    } else {
                        score = max(a, max(b, c))
                        eat = min(a, min(b, c))
                        hurt = arrayLength - score - eat
                    }
            }
  
        }
    
    }
    
}
