//
//  RegisterViewController.swift
//  FoodDelivery
//
//  Created by Gilang Aditya Rahman on 22/02/23.
//

import UIKit

class RegisterViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
  }
  @IBAction func loginButtonTap(_ sender: Any) {
    showLoginViewController()
  }
}

// MARK: - UIViewController

extension UIViewController {
  // Navigation Replace
  func showRegisterViewController() {
    let storyboard = UIStoryboard(name: "Login", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: "Register")
      as! RegisterViewController

    navigationController?.pushViewController(viewController, animated: true)
  }
}
