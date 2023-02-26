//
//  LoginViewController.swift
//  FoodDelivery
//
//  Created by Gilang Aditya Rahman on 21/02/23.
//

import AuthenticationServices
import FDUI
import UIKit

class LoginViewController: UIViewController {
  @IBOutlet var LoginButton: FDPrimaryButton!
  @IBOutlet var nameTextField: FDTextField!
  @IBOutlet var passwordTextField: FDTextField!

  var viewModel: LoginViewModel!

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    bindIsLoading()
    bindError()
    // Do any additional setup after loading the view.
  }

  deinit {}

  // MARK: - Helpers

  func setup() {
    nameTextField.delegate = self
    passwordTextField.delegate = self
  }

  func bindIsLoading() {
    viewModel.isLoading.bind { [weak self] value in
      guard let `self` = self else { return }
      if value {
        self.presentLoadingView(message: self.viewModel.loadingMessage)
      }
      else {
        self.dismissLoadingView()
      }
    }
  }

//  func bindIsLoginSuccess() {
//      viewModel.isLoginSuccess.bind { [weak self] (value) in
//          guard let `self` = self else { return }
//          if value {
//              self.showMainViewController()
//          }
//      }
//  }

  func bindError() {
    viewModel.error.bind { [weak self] value in
      guard let `self` = self else { return }
      if let error = value {
        let persentAlert: () -> Void = {
          self.presentAlert(title: "Oops!", message: error.localizedDescription)
        }
        if self.presentedViewController != nil {
          self.dismiss(animated: true) {
            persentAlert()
          }
        }
      }
    }
  }

  // MARK: - Actions

  @IBAction func loginButtonTap(_ sender: Any) {
    viewModel.login()
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
    viewController.viewModel = LoginViewModel()
    navigationController?.pushViewController(viewController, animated: true)
  }
}

extension LoginViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool
  {
    let text = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)

    switch textField {
    case nameTextField:
      viewModel.email.value = text
    case passwordTextField:
      viewModel.password.value = text
    default:
      break
    }

    return true
  }
}
