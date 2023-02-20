//
//  FtuxViewModel.swift
//  FoodDelivery
//
//  Created by Gilang Aditya Rahman on 20/02/23.
//

import Foundation
import UIKit

class FtuxViewModel {
  var ftuxes: [Ftux] = []
  let error: FDObservable<Error?> = .init(nil)
  var currentIndex: FDObservable<Int> = .init(-1)

  func loadFtuxes() {
    FtuxProvider.shared.loadFtuxes { [weak self] (result) in
      guard let `self` = self else { return }
      switch result {
      case .success(let data):
        self.ftuxes = data
        self.currentIndex.value = data.count > 0 ? 0 : -1
      case .failure(let error):
        self.error.value = error
      }
    }
  }

  var numberOfItems: Int {
    return ftuxes.count
  }
  
  func imageAtIndex(_ index: Int) -> UIImage? {
    let ftux = ftuxes[index]
    let image = UIImage(named: ftux.image)
    
    return image
  }
  
  func titleAtIndex(_ index: Int) -> String {
    let ftux = ftuxes[index]
    return ftux.title
  }
  
  func subtitleAtIndex(_ index: Int) -> String {
    let ftux = ftuxes[index]
    return ftux.subtitle
  }
  
  func buttonTitleAtIndex(_ index: Int) -> String {
    return index == ftuxes.count - 1 ? "Let's Start" : "Next"
  }
}

//    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
//      let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No Data!"])
//      self.error.value = error
//    }
//    return
