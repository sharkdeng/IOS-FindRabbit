//
//  GameViewController.swift
//  stRabbit1
//
//  Created by sj on 23/01/2018.
//  Copyright © 2018 com.sj. All rights reserved.
//

import UIKit
import SpriteKit
import GoogleMobileAds

class GameViewController: UIViewController {

    var gameView: SKView {
        return self.view as! SKView
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let mainScene = HomeScene(fileNamed: "HomeScene")
        gameView.presentScene(mainScene)
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gameToLogin" {
            let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginVC")
            UIApplication.shared.keyWindow?.rootViewController = loginVC
        }
    }

}


extension GameViewController: GADBannerViewDelegate {
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        //adView.isHidden = false
        print("adViewDidReceiveAd")
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("faile", error.localizedDescription)
    }
    
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("will present")
    }
    
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("will dismiss")
    }
    
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("didDismiss")
    }
}
