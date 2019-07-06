//
//  CarouselMainCinema.swift
//  Cinemaphile
//
//  Created by Лев Бондаренко on 06/07/2019.
//  Copyright © 2019 Лев Бондаренко. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class ImagePager: ASPagerNode {
  var urls: [String] = []
  var prepareCellNodeBlock: (_ item: String) -> ASCellNodeBlock
  var updateCurrentIndex: ((_ index: Int) -> Void)?
  
  init(layout: UICollectionViewFlowLayout, urls: [String], prepareCellNodeBlock: @escaping (_ item: String) -> ASCellNodeBlock,
       updateCurrentIndex: ((_ index: Int ) -> Void)? = nil) {
    self.urls = urls
    self.prepareCellNodeBlock = prepareCellNodeBlock
    self.updateCurrentIndex = updateCurrentIndex
    
    super.init(frame: .zero, collectionViewLayout: layout, layoutFacilitator: nil)
    
    automaticallyManagesSubnodes = true
    dataSource = self
  }
}

extension ImagePager: ASCollectionDataSource, ASPagerDataSource, UIScrollViewDelegate {
  func pagerNode(_ pagerNode: ASPagerNode, nodeBlockAt index: Int) -> ASCellNodeBlock {
    return self.prepareCellNodeBlock(self.urls[index])
  }
  
  func numberOfPages(in pagerNode: ASPagerNode) -> Int {
    return self.urls.count
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    guard let updateIndex = self.updateCurrentIndex else { return }
    
    updateIndex(self.currentPageIndex)
  }
}
