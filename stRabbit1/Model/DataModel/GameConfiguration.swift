//
//  GameConfiguration.swift
//  1MemorySprite
//
//  Created by sj on 21/11/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import UIKit


struct GameConfiguration{
    struct SceneManager{
        static let transitionDuration: TimeInterval = 0.5
        static let progressSceneTransitionDuration: TimeInterval = 0.5
    }
    struct Music{
        static let btnClickedSound = "btnClickedSound.wav"
        static let launchBgMusic = "launch_storm.wav"
        static let loginBgMusic = "login_bgMusic.mp3"
        static let homeBgMusic = "login_bgMusic.mp3"
        static let listBgMusic = ""
        static let levelBgMusic = ""
        
        
    }
    
    struct zPosition {
        static let playBg: CGFloat = 1.0
        static let card: CGFloat = 2.0
        static let character: CGFloat = 3.0
    }
}
