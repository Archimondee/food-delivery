//
//  RegisterViewController.swift
//  FoodDelivery
//
//  Created by Gilang Aditya Rahman on 22/02/23.
//

import FDUI
import UIKit

class RegisterViewController: UIViewController {
  @IBOutlet var confirmPasswordTextField: FDTextField!
  @IBOutlet var passwordTextField: FDTextField!
  @IBOutlet var addressTextField: FDTextField!
  @IBOutlet var phoneTextField: FDTextField!
  @IBOutlet var emailTextField: FDTextField!
  @IBOutlet var nameTextField: FDTextField!
  @IBOutlet var loginButton: UIButton!
  @IBOutlet var signUpButton: FDPrimaryButton!

  var viewModel: RegisterViewModel!

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
    nameTextField.delegate = self
    emailTextField.delegate = self
    phoneTextField.delegate = self
    addressTextField.delegate = self
    passwordTextField.delegate = self
    confirmPasswordTextField.delegate = self
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
    viewModel.isSignUpSuccess.bind { [weak self] value in
      guard let `self` = self else { return }
      if value {
        self.presentAlert(title: "Yay!", message: "Sign up success! Please login now.") {
          self.loginButtonTap(self)
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
        }else {
          persentAlert()
        }
      }
    }
  }

  func signUp() {
    viewModel.signUp()
  }

  // MARK: - Actions

  @IBAction func viewTapped(_ sender: Any) {
    view.endEditing(true)
  }

  @IBAction func loginButtonTap(_ sender: Any) {
    showLoginViewController()
    removeFromParent()
  }

  @IBAction func signupButtonTapped(_ sender: Any) {
    // hide keyboard
    view.endEditing(true)
    signUp()
    // Remove keyboard on specific text field
    // nameTextField.resignFirstResponder()

    // Keyboard on focus
    // nameTextField.becomeFirstResponder()
  }
}

// MARK: - UITextFieldDelegate

extension RegisterViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let text = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)

    switch textField {
    case nameTextField:
      viewModel.name.value = text
    case emailTextField:
      viewModel.email.value = text
    case phoneTextField:
      viewModel.phone.value = text
    case addressTextField:
      viewModel.address.value = text
    case passwordTextField:
      viewModel.password.value = text
    case confirmPasswordTextField:
      viewModel.confirmPassword.value = text
    default:
      break
    }

    return true
  }
}

// MARK: - UIViewController

extension UIViewController {
  // Navigation Replace
  func showRegisterViewController() {
    let storyboard = UIStoryboard(name: "Login", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: "Register")
      as! RegisterViewController
    viewController.viewModel = RegisterViewModel()
    navigationController?.pushViewController(viewController, animated: true)
  }
}
