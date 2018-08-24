//
//  LaunchViewController.swift
//  1MemorySprite
//
//  Created by sj on 15/01/2018.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Alamofire
import AVFoundation


class LaunchViewController: UIViewController {

    var launchBgMusic: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        animateLaunch()
        playLaunchBg()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func animateLaunch(){
        let logo = self.view.viewWithTag(1)
        
        //initial state
        //if you don't set this, UIView.animate will not occur
        logo?.alpha = 0.0
        UIView.animate(withDuration: 5.0, animations: {
            logo?.alpha = 1.0

        }) { (true) in
            self.guideNewApp()
        }

    }

    //compare app version
    func guideNewApp(){
        //get current app version
        let infoDic = Bundle.main.infoDictionary
        let currentAppVersion = infoDic!["CFBundleShortVersionString"] as! String
        
        //get previous app version
        
        let appVersion = UserDefaults.standard.string(forKey: User.AccountInfo.appVersion)
        
        //nil: app is fist used, !=: app needs refresh
        if appVersion == nil || appVersion != currentAppVersion {
            //fresh app version
            UserDefaults.standard.setValue(currentAppVersion, forKey: User.AccountInfo.appVersion)
        }
        
        performSegue(withIdentifier: "launchToLogin", sender: self)
        
    }
    

    
    func playLaunchBg(){
        let musicSource = GameConfiguration.Music.launchBgMusic.components(separatedBy: ".")
        
        let music = Bundle.main.url(forResource: musicSource[0], withExtension: musicSource[1])
        do {
            launchBgMusic = try AVAudioPlayer(contentsOf: music!)
        } catch {
            print(error)
        }
        launchBgMusic.volume = 5.0
        launchBgMusic.play()
        launchBgMusic.numberOfLoops = -1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "launchToLogin" {
            
            //not understand why, but if you miss this, animation will not work
            let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
            UIApplication.shared.keyWindow?.rootViewController = loginVC
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
