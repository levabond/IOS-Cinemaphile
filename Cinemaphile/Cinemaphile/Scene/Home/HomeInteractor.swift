//
//  HomeInteractor.swift
//  Cinemaphile
//
//  Created by Лев Бондаренко on 10/03/2019.
//  Copyright (c) 2019 Лев Бондаренко. All rights reserved.
//

import UIKit
import RxSwift

protocol HomeInteractorInput: class {
  var somethingSubject: PublishSubject<Home.Something.Request> { get }
}

protocol HomeInteractorOutput {
  var somethingSubject: PublishSubject<Home.Something.Response> { get }
}

protocol HomeDataStore {
  //var name: String { get set }
}

class HomeInteractor: HomeInteractorOutput, HomeDataStore {
  weak var input: HomeInteractorInput! {
    didSet {
      input.somethingSubject.map(handleUseCase).bind(to: somethingSubject).disposed(by: disposeBag)
    }
  }
  var somethingSubject = PublishSubject<Home.Something.Request>()
  var worker: HomeWorker?
  var disposeBag = DisposeBag()
  //var name: String = ""
  
  // MARK: Do something
  
  func handleUseCase(request: Home.Something.Request) -> Home.Something.Response {
    worker = HomeWorker()
    worker?.doSomeWork()
    
    let response = Home.Something.Response()
    
    return response
  }
}
