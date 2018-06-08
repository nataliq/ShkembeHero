//
//  AppDelegate.swift
//  ShkembeHero
//
//  Created by Nataliya  on 5/31/18.
//  Copyright © 2018 nataliya_bg. All rights reserved.
//

import UIKit
import Presentation
import Flow

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let bag = DisposeBag()
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.tintColor = .tint
        
        let appFlow = ApplicationFlow()
        bag += window.present(appFlow)
        
        return true
    }
}
