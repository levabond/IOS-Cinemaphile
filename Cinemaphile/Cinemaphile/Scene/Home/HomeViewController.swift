//
//  HomeViewController.swift
//  Cinemaphile
//
//  Created by Лев Бондаренко on 10/03/2019.
//  Copyright (c) 2019 Лев Бондаренко. All rights reserved.
//

import UIKit
import RxSwift
import AsyncDisplayKit

protocol HomeViewControllerInput: class {
//    var somethingSubject: PublishSubject<Home.Something.ViewModel> { get }
}

protocol HomeViewControllerOutput {
//    var somethingSubject: PublishSubject<Home.Something.Request> { get }
}

class HomeViewController: ASViewController<ASDisplayNode>, ASTableDataSource, ASTableDelegate, HomeViewControllerOutput {
  var somethingSubject = PublishSubject<Home.Something.Request>()
  var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
  var input: HomeViewControllerInput?
  
  struct State {
    var itemCount: Int
    var fetchingMore: Bool
    static let empty = State(itemCount: 20, fetchingMore: false)
  }
  
  enum Action {
    case beginBatchFetch
    case endBatchFetch(resultCount: Int)
  }
  
  fileprivate(set) var state: State = .empty

  // MARK: - Object lifecycle

  var tableNode: ASTableNode {
    return node as! ASTableNode
  }
  
  
  init() {
    super.init(node: ASTableNode())
    tableNode.delegate = self
    tableNode.dataSource = self
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("storyboards are incompatible with truth and beauty")
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
  
  // MARK: ASTableNode data source and delegate.
  func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
    let rowCount = self.tableNode(tableNode, numberOfRowsInSection: 0)
    
    if state.fetchingMore && indexPath.row == rowCount - 1 {
      let node = TailLoadingCellNode()
      node.style.height = ASDimensionMake(44.0)
      return node;
    }
    
    let node = ASTextCellNode()
    node.text = String(format: "[%ld.%ld] says hello!", indexPath.section, indexPath.row)
    
    return node
  }

  func numberOfSections(in tableNode: ASTableNode) -> Int {
    return 1
  }
  
  func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
    var count = state.itemCount
    if state.fetchingMore {
      count += 1
    }
    return count
  }
  
  func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
    /// This call will come in on a background thread. Switch to main
    /// to add our spinner, then fire off our fetch.
    DispatchQueue.main.async {
      let oldState = self.state
      self.state = HomeViewController.handleAction(.beginBatchFetch, fromState: oldState)
      self.renderDiff(oldState)
    }
    
    HomeViewController.fetchDataWithCompletion { resultCount in
      let action = Action.endBatchFetch(resultCount: resultCount)
      let oldState = self.state
      self.state = HomeViewController.handleAction(action, fromState: oldState)
      self.renderDiff(oldState)
      context.completeBatchFetching(true)
    }
  }
  
  fileprivate func renderDiff(_ oldState: State) {
    
    self.tableNode.performBatchUpdates({
      
      // Add or remove items
      let rowCountChange = state.itemCount - oldState.itemCount
      if rowCountChange > 0 {
        let indexPaths = (oldState.itemCount..<state.itemCount).map { index in
          IndexPath(row: index, section: 0)
        }
        tableNode.insertRows(at: indexPaths, with: .none)
      } else if rowCountChange < 0 {
        assertionFailure("Deleting rows is not implemented. YAGNI.")
      }
      
      // Add or remove spinner.
      if state.fetchingMore != oldState.fetchingMore {
        if state.fetchingMore {
          // Add spinner.
          let spinnerIndexPath = IndexPath(row: state.itemCount, section: 0)
          tableNode.insertRows(at: [ spinnerIndexPath ], with: .none)
        } else {
          // Remove spinner.
          let spinnerIndexPath = IndexPath(row: oldState.itemCount, section: 0)
          tableNode.deleteRows(at: [ spinnerIndexPath ], with: .none)
        }
      }
    }, completion:nil)
  }
  
  /// (Pretend) fetches some new items and calls the
  /// completion handler on the main thread.
  fileprivate static func fetchDataWithCompletion(_ completion: @escaping (Int) -> Void) {
    let time = DispatchTime.now() + Double(Int64(TimeInterval(NSEC_PER_SEC) * 1.0)) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: time) {
      let resultCount = Int(arc4random_uniform(20))
      completion(resultCount)
    }
  }
  
  fileprivate static func handleAction(_ action: Action, fromState state: State) -> State {
    var state = state
    switch action {
    case .beginBatchFetch:
      state.fetchingMore = true
    case let .endBatchFetch(resultCount):
      state.itemCount += resultCount
      state.fetchingMore = false
    }
    return state
  }
  // MARK: - Setup UI
  
  private func setupViews() {
  }
  
  private func setupConstraints() {
  }
}
