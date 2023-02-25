//
//  UIViewControllerExtensions.swift
//  FDUI
//
//  Created by Gilang Aditya Rahman on 22/02/23.
//

import UIKit

public extension UIViewController {
  @IBAction public func backButtonTapped(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }

  @IBAction public func closeButtonTapped(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}

public extension UIViewController {
  func presentAlert(title: String?, message: String?, actionTitle: String? = nil, handler: (() -> Void)? = nil) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: actionTitle ?? "Ok", style: .cancel, handler: { _ in
      handler?()
    }))
    present(alert, animated: true, completion: nil)
  }
}
