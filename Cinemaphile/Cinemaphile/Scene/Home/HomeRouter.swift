//
//  HomeRouter.swift
//  Cinemaphile
//
//  Created by Лев Бондаренко on 10/03/2019.
//  Copyright (c) 2019 Лев Бондаренко. All rights reserved.
//

import UIKit

@objc protocol HomeRoutingLogic {
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol HomeDataPassing {
  var dataStore: HomeDataStore? { get }
}

class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing {
  weak var viewController: HomeViewController?
  var dataStore: HomeDataStore?
  
  // MARK: Routing
  
  //func routeToSomewhere() {
  //  let destinationVC = SomewhereViewController()
  //  var destinationDS = destinationVC.router!.dataStore!
  //  passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  navigateToSomewhere(source: viewController!, destination: destinationVC)
  //}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: HomeViewController, destination: SomewhereViewController) {
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: HomeDataStore, destination: inout SomewhereDataStore) {
  //  destination.name = source.name
  //}
}
