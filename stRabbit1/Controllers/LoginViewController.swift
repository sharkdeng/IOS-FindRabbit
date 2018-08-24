//
//  LoginViewController.swift
//  1MemorySprite
//
//  Created by sj on 15/01/2018.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Alamofire
import AVFoundation
import SVProgressHUD



class LoginViewController: UIViewController {

    var username: String!
    var password: String!
    var loginBgMusic: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addCurveAnimatioin()
        playLoginBg()
        initUserPsw()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setLoginStyle(){
        for subView in self.view.subviews {
            //user center logo
            if subView.tag == 1 {
                
            }
        
            //textField bg
            if subView.tag == 2 {
                //or ctx color will cover the effect of layer
                subView.backgroundColor = UIColor.white
                subView.layer.masksToBounds = true
                subView.layer.cornerRadius = 10.0
                //subView.layer.backgroundColor = UIColor.white.cgColor
                
                for tf in subView.subviews {
                    //username
                    if tf.tag == 1 {
                        tf.backgroundColor = UIColor.clear
                        tf.layer.borderColor = UIColor.clear.cgColor
                    }
                    //password
                    if tf.tag == 2 {
                        tf.backgroundColor = UIColor.clear
                        tf.layer.borderColor = UIColor.clear.cgColor
                    }
                }
                
            }

        }
    }
    
    
    
    //after constraints are calculated
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setLoginStyle()
    }
    
    
    @IBAction func hideKeyboard(_ sender: Any) {
        let tf = sender as! UITextField
        tf.resignFirstResponder()
    }
 
    func initUserPsw(){
        if UserDefaults.standard.string(forKey: User.AccountInfo.userName) != nil && UserDefaults.standard.string(forKey: User.AccountInfo.password) != nil {
            let userTf = self.view.viewWithTag(2)?.viewWithTag(1) as! UITextField
            userTf.text = UserDefaults.standard.string(forKey: User.AccountInfo.userName)
            
            let passTf = self.view.viewWithTag(2)?.viewWithTag(3) as! UITextField
            passTf.text = UserDefaults.standard.string(forKey: User.AccountInfo.password)
        }
    }
    
    func getAndCheckInfos() -> Bool {
        //get
        let userTf = self.view.viewWithTag(2)?.viewWithTag(1) as! UITextField
        username = userTf.text
        
        let passTf = self.view.viewWithTag(2)?.viewWithTag(3) as! UITextField
        //method 2
        //let passTf= self.view.viewWithTag(2)?.subviews[1] as! UITextField
        //this method will occur error, for xcode will be confused by 2 tags(2)
        //let passTf = self.view.viewWithTag(2)?.viewWithTag(2) as! UITextField
        password = passTf.text
        
        
        //check if it's nil
        if username == "" || password == "" {
            let remindFill = UIAlertController(title: "小提示", message: "请输入用户名或密码", preferredStyle: .alert)
            remindFill.addAction(UIAlertAction(title: "朕知道啦", style: .default, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            }))
            present(remindFill, animated: true, completion: nil)
            
            return false
            
            //check phone length
        } else if username.count != 11 {
            let warnInvalidPhone = UIAlertController(title: "小提示", message: "输入有效的手机号", preferredStyle: .alert)
            warnInvalidPhone.addAction(UIAlertAction(title: "朕知道啦", style: .default, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            }))
            present(warnInvalidPhone, animated: true, completion: nil)
            
            return false
            
             //requirement for password
        } else if password.count < 6 {
            let warnInvalidPhone = UIAlertController(title: "小提示", message: "密码至少为6位", preferredStyle: .alert)
            warnInvalidPhone.addAction(UIAlertAction(title: "朕知道啦", style: .default, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            }))
            present(warnInvalidPhone, animated: true, completion: nil)
            
            return false
        } else {
            //good! pass checks
            return true
        }
     
        
    }
    
    /*something occur error when mysql insert this value
    func getCurrentTime() -> String{
        let now = Date()
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd HH:mm:ss"

        return formater.string(from: now)
    }
 */
    
    @IBAction func loginAction(_ sender: Any) {
        
        if getAndCheckInfos() {
            
            SVProgressHUD.show(withStatus: "正在登录中")
            
        
            let params = ["login":true,
                          User.AccountInfo.userName: username,
                          User.AccountInfo.password: password,
                          User.AccountInfo.deviceToken: UserDefaults.standard.value(forKey: User.AccountInfo.deviceToken)]
            
            let url = URL(string: ConnectServer.memoryPHP)
            Alamofire.request(url!, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate().response(completionHandler: { (response) in
                if response.error == nil {
                    SVProgressHUD.dismiss()
                    
                    let result = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) as! String
                    print(result)
                    if result.contains("login successful") {
                        
                        UserDefaults.standard.setValue(self.username, forKey: User.AccountInfo.userName)
                        UserDefaults.standard.setValue(self.password, forKey: User.AccountInfo.password)
                        
                        self.performSegue(withIdentifier: "loginToGame", sender: self)
                    }
                    if result.contains("login failure") {
                        if result.contains("unrecognized user") {
                            let alert = UIAlertController(title: "小提示", message: "用户不存在", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "知道啦", style: .default, handler: { (action) in
                                alert.dismiss(animated: true, completion: nil)
                            }))
                            let currentVC = getVCfromView(uiView: self.view)
                            currentVC?.present(alert, animated: true, completion: nil)
                        }
                        
                        if result.contains("wrong password") {
                            let alert = UIAlertController(title: "小提示", message: "密码错误", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "知道啦", style: .default, handler: { (action) in
                                alert.dismiss(animated: true, completion: nil)
                            }))
                            let currentVC = getVCfromView(uiView: self.view)
                            currentVC?.present(alert, animated: true, completion: nil)
                        }
                    }
                    
                } else {
                    debugPrint(response.error)
                }
            })
        }
        
    }
    
    @IBAction func registerAction(_ sender: Any) {
        
        //only check successful, we connect to server
        if getAndCheckInfos() {
            //get user indicator
            SVProgressHUD.show(withStatus: "正在注册中")
            
            
            //pass the infos to server
            let params = ["register":true,
                          User.AccountInfo.userName: username,
                          User.AccountInfo.password: password,
                          User.AccountInfo.deviceName: UIDevice.current.name,
                          User.AccountInfo.deviceModel: UIDevice.current.model,
                          User.AccountInfo.deviceUDID: UIDevice.current.identifierForVendor,
                          User.AccountInfo.sysName: UIDevice.current.systemName,
                          User.AccountInfo.sysVersion: UIDevice.current.systemVersion,
                          User.AccountInfo.deviceToken: UserDefaults.standard.value(forKey: User.AccountInfo.deviceToken)]
            
            let url = URL(string: ConnectServer.memoryPHP)
            Alamofire.request(url!, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate().response(completionHandler: { (response) in
                if response.error == nil{
                    SVProgressHUD.dismiss()
                    
                    let result = NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) as! String
                    print("reply", result)
                    
                    //check register results
                    if result.contains("existed user") {
                        let existedUser = UIAlertController(title: "小提示", message: "该手机号已被注册", preferredStyle: .alert)
                        existedUser.addAction(UIAlertAction(title: "换个手机号", style: .default, handler: { (action) in
                            self.dismiss(animated: true, completion: nil)
                        }))
                        self.present(existedUser, animated: true, completion: nil)
                    }
                    
                    //register successful, get your suger
                    if result.contains("register successful") {
                        
                        UserDefaults.standard.setValue(self.username, forKey: User.AccountInfo.userName)
                        UserDefaults.standard.setValue(self.password, forKey: User.AccountInfo.password)
                        
                        self.performSegue(withIdentifier: "loginToGame", sender: self)
                    }
                   
                } else {
                    debugPrint(response.error)
                }
            })
        }
        
    }
    


    @IBAction func guestLoginAction(_ sender: Any) {
        performSegue(withIdentifier: "loginToGame", sender: self)
    }
    

    func addCurveAnimatioin(){
        let img = UIImage(named: "login_universe")
        
        let lowerHeight = CGFloat(100)
        let deltaHeight = CGFloat(30)
        let lowerTop = lowerHeight + deltaHeight
        
        let lowerView = UIView(frame: CGRect(x: 0, y: view.frame.height - lowerTop, width: view.frame.width, height: lowerTop))
        lowerView.backgroundColor = UIColor.red
        self.view.addSubview(lowerView)
        
        
        //content layer
        let imgLayer = CAShapeLayer()
        imgLayer.contents = UIImage(named: "login_universe")?.cgImage
        //initial imgLayer size
        
        imgLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.height)
        //put imgLayer position to the center rotation
        imgLayer.position = CGPoint(x: lowerView.frame.midX, y: img!.size.height / 2 - 50)
        lowerView.layer.addSublayer(imgLayer)
        
        //mask layer
        let maskLayer = CAShapeLayer()
        let curve = UIBezierPath()
        curve.move(to: CGPoint(x: 0, y: deltaHeight))
        curve.addQuadCurve(to: CGPoint(x: lowerView.frame.width, y: deltaHeight), controlPoint: CGPoint(x: lowerView.frame.midX, y: 0))
        curve.addLine(to: CGPoint(x: lowerView.frame.width, y: lowerView.frame.height))
        curve.addLine(to: CGPoint(x: 0, y: lowerView.frame.height))
        curve.close()
        maskLayer.path = curve.cgPath
        lowerView.layer.mask = maskLayer
        
        
        //rotate the content layer
        let ani = CABasicAnimation()
        ani.keyPath = "transform.rotation.z"
        ani.fromValue = CGFloat(0.0)
        ani.toValue = CGFloat(10.0)
        ani.duration = 20.0
        ani.autoreverses = false
        ani.repeatCount = Float.infinity
        imgLayer.add(ani, forKey: "rotateStar")
    }

    //it's same as in LaunchViewController
    func playLoginBg(){
        let musicSource = GameConfiguration.Music.loginBgMusic.components(separatedBy: ".")
        
        let music = Bundle.main.url(forResource: musicSource[0], withExtension: musicSource[1])
        do {
            loginBgMusic = try AVAudioPlayer(contentsOf: music!)
        } catch {
            print(error)
        }
        loginBgMusic.volume = 2.0
        loginBgMusic.play()
        loginBgMusic.numberOfLoops = -1
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginToGame" {
            let gameVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "gameVC") as! GameViewController
            UIApplication.shared.keyWindow?.rootViewController = gameVC
        }
        
        loginBgMusic.pause()
        
    }
}


