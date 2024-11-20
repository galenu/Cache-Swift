//
//  ViewController.swift
//  Cache-Swift
//
//  Created by galenu on 11/20/2024.
//  Copyright (c) 2024 galenu. All rights reserved.
//

import UIKit
import Cache_Swift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        HMCache.appCache.setObject(true, forKey: .NightListening.isShowdNightListeningGuide)
        
        let isShowdNightListeningGuide = HMCache.appCache.object(forKey: .NightListening.isShowdNightListeningGuide, type: Bool.self)
        
        print("isShowdNightListeningGuide: \(isShowdNightListeningGuide)")
    }

}

