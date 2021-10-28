//
//  Run.swift
//  HelloFreshCoding
//
//  Created by Waqas Naseem on 10/28/21.
//

import Foundation

final class Run {
    
    public class func onMainThread(after delay:Double = 0, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
}
