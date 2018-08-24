//
//  ShopScene.swift
//  stRabbit1
//
//  Created by sj on 31/01/2018.
//  Copyright © 2018 com.sj. All rights reserved.
//

import Foundation
import SpriteKit
import StoreKit
import SVProgressHUD


class ShopScene: BaseScene {
    
    var goodBtns = [GoodButton]()
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        //close IAP
       // let memorySeed = childNode(withName: "goods_memorySeed") as! GoodButton
        let toy = childNode(withName: "goods_toy") as! GoodButton
        let englishBook = childNode(withName: "goods_englishBook") as! GoodButton
        
       //memorySeed.isUserInteractionEnabled = true
        toy.isUserInteractionEnabled = true
        englishBook.isUserInteractionEnabled =  true
        
        
        
    }
    
    func adjustMemorySeed(){
        let a = childNode(withName: "memorySeedTextNode") as! SKLabelNode
        if UserDefaults.standard.bool(forKey: User.AccountInfo.unlockAllLevels) {
            a.text = "100个"
        } else {
            a.text = "0个，购买可解锁最后一排关卡"
        }
    }
}


class GoodButton:SKSpriteNode {
    

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        removeAllActions()
        run(SKAction.sequence([SKAction.scale(by: CGFloat(0.98), duration: 0.1),
                               SKAction.scale(to: CGFloat(1.0), duration: 0.1)]))
        
 
        if self.name!.hasSuffix("toy") || self.name!.hasSuffix("englishBook") {
            if #available(iOS 10.0, *){
                let url = URL(string: "http://www.9scoretrain.com/?post_type=st_product")
                UIApplication.shared.open(url!, options: [:], completionHandler: { (true) in
                    print("good")
                })
            }
        }
        
        if self.name!.hasSuffix("memorySeed") {
            
            let products = getLocalProducst()
            fetchRequest(productIdentifiers: products)
        }
    }
    
    
    func getLocalProducst() -> [String] {
        let url = Bundle.main.url(forResource: "Product", withExtension: "plist")
        let products: [String] = NSArray(contentsOf: url!) as! [String]
        return products
    }
    
    func fetchRequest(productIdentifiers: [String]){
        
        if UserDefaults.standard.string(forKey: User.AccountInfo.userName) != nil && UserDefaults.standard.string(forKey: User.AccountInfo.password) != nil {
            
            if SKPaymentQueue.canMakePayments() {
                SVProgressHUD.show(withStatus: "与苹果服务器连接中，获取产品")
                
                let identifiers = Set(productIdentifiers)
                let request = SKProductsRequest(productIdentifiers: identifiers)
                request.delegate = self
                request.start()
            } else {
                let alert = UIAlertController(title: "出错了", message: "不知为何，你无权购买", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "检查一下", style: .cancel, handler: { (action) in
                    alert.dismiss(animated: true, completion: nil)
                })
                alert.addAction(cancel)
                let currentVC = getVCfromView(uiView: self.scene!.view!) as! GameViewController
                currentVC.present(alert, animated: true, completion: nil)
            }
            
            //register account
        } else {
            let alert = UIAlertController(title: "小提示", message: "根据苹果协议，你注册后可享受购买服务", preferredStyle: .alert)
            let currentVC = getVCfromView(uiView: self.scene!.view!) as! GameViewController
            let action = UIAlertAction(title: "太棒了，现在注册", style: .default, handler: { (action) in
                currentVC.performSegue(withIdentifier: "gameToLogin", sender: self)
            })
            alert.addAction(action)
            
            currentVC.present(alert, animated: true, completion: nil)
        }
        
    }
}

extension GoodButton: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        //set initial value
        UserDefaults.standard.set(false, forKey: User.AccountInfo.unlockAllLevels)
        
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                
                SVProgressHUD.show(withStatus: "购买成功")
                
                print("buy ", UserDefaults.standard.bool(forKey: User.AccountInfo.unlockAllLevels))
                UserDefaults.standard.set(true, forKey: User.AccountInfo.unlockAllLevels)
                
                SVProgressHUD.dismiss()

            case .purchasing:
                
                SVProgressHUD.show(withStatus: "订单处理中")
 
            case .failed:
                
                SVProgressHUD.showError(withStatus: "购买失败")
                
                SVProgressHUD.dismiss()
            case .deferred:
                
                SVProgressHUD.showError(withStatus: "Deferred")
                
                SVProgressHUD.dismiss()
            case .restored:
                
                SVProgressHUD.showError(withStatus: "恢复")
                SVProgressHUD.dismiss()
            }
        }
    }
    
    
}

extension GoodButton: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if response.products.count > 0 {
            
            SVProgressHUD.show(withStatus: "获取产品信息成功！")
            
            let availableProduct = response.products[0]
            let payment = SKPayment(product: availableProduct)
            SKPaymentQueue.default().add(payment)
            
            SVProgressHUD.dismiss()
        } else {
            print("检查productIdenifier")
        }
    }
    
    
}
