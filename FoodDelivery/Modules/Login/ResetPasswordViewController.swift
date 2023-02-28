//
//  ResetPasswordViewController.swift
//  FoodDelivery
//
//  Created by Gilang Aditya Rahman on 28/02/23.
//

import FDUI
import UIKit

class ResetPasswordViewController: UIViewController {
  @IBOutlet var emailTextField: FDTextField!
  @IBOutlet var signupButton: FDPrimaryButton!

  var viewModel: ResetPasswordViewModel!

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    bindIsLoading()
    bindError()
    bindIsSignUpSuccess()
  }

  deinit {}

  // MARK: - Helpers

  func setup() {
    emailTextField.delegate = self
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

  func bindIsSignUpSuccess() {
    viewModel.isEmailSuccess.bind { [weak self] value in
      guard let `self` = self else { return }
      if value {
        self.presentAlert(title: "Yay!", message: "Reset password send success! Please login now.") {
          self.showLoginViewController()
          self.removeFromParent()
        }
      }
    }
  }

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

  @IBAction func signupTapped(_ sender: Any) {
    viewModel.resetPassword()
  }
}

// MARK: - UITextFieldDelegate

extension ResetPasswordViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let text = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)

    switch textField {
    case emailTextField:
      viewModel.email.value = text

    default:
      break
    }

    return true
  }
}

// MARK: - UIViewController

extension UIViewController {
  // Navigation Replace
  func showResetPasswordController() {
    let storyboard = UIStoryboard(name: "Login", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: "ResetPassword")
      as! ResetPasswordViewController
    viewController.viewModel = ResetPasswordViewModel()
    navigationController?.pushViewController(viewController, animated: true)
  }
}
