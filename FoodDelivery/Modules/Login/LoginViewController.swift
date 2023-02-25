//
//  LoginViewController.swift
//  FoodDelivery
//
//  Created by Gilang Aditya Rahman on 21/02/23.
//

import UIKit
import FDUI

class LoginViewController: UIViewController {
  @IBOutlet weak var LoginButton: FDPrimaryButton!
  @IBOutlet weak var nameTextField: FDTextField!
  @IBOutlet weak var passwordTextField: FDTextField!
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    // Do any additional setup after loading the view.
  }

  func setup() {
    nameTextField.layer.cornerRadius = 28
  }
  @IBAction func signupButtonTap(_ sender: Any) {
    showRegisterViewController()
    removeFromParent()
  }
}

// MARK: - UIViewController

extension UIViewController {
  // Navigation Replace
  func showLoginViewController() {
    let storyboard = UIStoryboard(name: "Login", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: "Login")
      as! LoginViewController
    
    self.navigationController?.pushViewController(viewController, animated: true)
  }
}
