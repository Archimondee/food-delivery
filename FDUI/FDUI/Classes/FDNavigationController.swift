//
//  FDNavigationController.swift
//  FDUI
//
//  Created by Gilang Aditya Rahman on 22/02/23.
//

import UIKit

public class FDNavigationController: UINavigationController {
  override public func viewDidLoad() {
    super.viewDidLoad()

    interactivePopGestureRecognizer?.delegate = self
  }
}

extension FDNavigationController: UIGestureRecognizerDelegate {
  public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                                shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool
  {
    return true
  }

  public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}
