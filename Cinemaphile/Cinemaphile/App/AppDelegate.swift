//
//  AppDelegate.swift
//  Cinemaphile
//
//  Created by Лев Бондаренко on 10/03/2019.
//  Copyright © 2019 Лев Бондаренко. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.backgroundColor = UIColor.white
    window.rootViewController = UINavigationController(rootViewController: HomeViewController())
    window.makeKeyAndVisible()
    self.window = window

    return true
  }
}

