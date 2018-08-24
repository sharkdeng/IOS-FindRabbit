//
//  Rate.swift
//  1MemorySprite
//
//  Created by gamekf8 on 27/11/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import StoreKit

class Rate{

    static let runCountKey = "numberOfRuns"
    static let minimumRunCount = 5
    
    
    //find suitable time to use this func
    class func popRateAlert(){
        let runs = getSavedRunCounts()
        print("runs", runs)
        if runs > minimumRunCount {
            if #available(iOS 10, *){
                SKStoreReviewController.requestReview()
            }
        } else {
            print("run count requirement is not satisfied")
        }
        
    }
    
    //This func is used in AppDelegate / applicationDidFinishLaunching
    class func addAppRuns(){
        var runs = getSavedRunCounts()
        runs += 1
        UserDefaults.standard.set(runs, forKey: User.AccountInfo.runNumbers)
    }
    
    class func getSavedRunCounts() -> Int{
        let savedRuns = UserDefaults.standard.value(forKey: User.AccountInfo.runNumbers)
        
        var runs = 0
        if savedRuns != nil {
            runs = savedRuns as! Int
        }
        print("has run \(runs)")
        return runs
    }
}
