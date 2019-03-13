//
//  HomeViewController.swift
//  Cinemaphile
//
//  Created by Лев Бондаренко on 10/03/2019.
//  Copyright (c) 2019 Лев Бондаренко. All rights reserved.
//

import UIKit
import RxSwift

protocol HomeViewControllerInput: class {
    var somethingSubject: PublishSubject<Home.Something.ViewModel> { get }
}

protocol HomeViewControllerOutput {
    var somethingSubject: PublishSubject<Home.Something.Request> { get }
}

class HomeViewController: UIViewController, HomeViewControllerOutput {
  var somethingSubject = PublishSubject<Home.Something.Request>()
  var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
  var input: HomeViewControllerInput?

  // MARK: - Object lifecycle
  
  init(configurator: HomeConfigurator = HomeConfigurator.sharedInstance) {
    super.init(nibName: nil, bundle: nil)
    configure()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configure()
  }
  
  // MARK: - Configure
  
  private func configure(configurator: HomeConfigurator = HomeConfigurator.sharedInstance) {
    configurator.configure(viewController: self)
    configureOutputStreams()
    configureInputStream()
  }

  // MARK: - Stream Configuration
    
  private func configureOutputStreams() {}
    
  private func configureInputStream() {
    // here we do subscriptions on our input stream and dinding viewModels
    // for example
    // input?.somethingSubject.subscribe(onNext: { viewModel in ... }, onError: {} and so on
  }
  
  // MARK: - Routing
  
  //@objc func action(sender: UIButton!) {
  //  router.routeToSomewhere()
  //}
  
  // MARK: - View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    // self.somethingSubject.onNext(Home.Something.Request()) instead of doSomething
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    setupConstraints()
  }

  // MARK: - Setup UI
  
  private func setupViews() {
  }
  
  private func setupConstraints() {
  }
}
