//
//  HomePresenter.swift
//  Cinemaphile
//
//  Created by Лев Бондаренко on 10/03/2019.
//  Copyright (c) 2019 Лев Бондаренко. All rights reserved.
//

import UIKit
import RxSwift

protocol HomePresenterInput: class {
  var somethingSubject: PublishSubject<Home.Something.Response> { get }
}

protocol HomePresenterOutput {
  var somethingSubject: PublishSubject<Home.Something.ViewModel> { get }
}

class HomePresenter: HomePresenterOutput {
  weak var input: HomePresenterInput! {
    didSet {
      input.somethingSubject.map(handle).bind(to: somethingSubject).disposed(by: disposeBag)
    }
  }
  var somethingSubject = PublishSubject<Home.Something.ViewModel>()
  var disposeBag = DisposeBag()
  // MARK: Do something
  
  func handle(response: Home.Something.Response) -> Home.Something.ViewModel {
    let viewModel = Home.Something.ViewModel()

    return viewModel
  }
}
