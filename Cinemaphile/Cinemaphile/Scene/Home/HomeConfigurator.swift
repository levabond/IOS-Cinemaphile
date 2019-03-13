//
//  HomeConfigurator.swift
//  Cinemaphile
//
//  Created by Лев Бондаренко on 10/03/2019.
//  Copyright (c) 2019 Лев Бондаренко. All rights reserved.
//

import UIKit

final class HomeConfigurator {
  
  static let sharedInstance = HomeConfigurator()
  
  func configure(viewController: HomeViewController) {
    let interactor = HomeInteractor()
    interactor.input = viewController

    let presenter = HomePresenter()
    presenter.input = interactor

    let router = HomeRouter()
    router.viewController = viewController
    router.dataStore = interactor
    
    viewController.input = presenter
    viewController.router = router
  }
}

extension HomeViewController: HomeInteractorInput {}
extension HomeInteractor: HomePresenterInput {}
extension HomePresenter: HomeViewControllerInput {}
