//
//  LoginViewController.swift
//  FoodDelivery
//
//  Created by Gilang Aditya Rahman on 21/02/23.
//

import AuthenticationServices
import FDUI
import Firebase
import FirebaseCore
import GoogleSignIn
import UIKit

class LoginViewController: UIViewController {
  @IBOutlet var LoginButton: FDPrimaryButton!
  @IBOutlet var nameTextField: FDTextField!
  @IBOutlet var passwordTextField: FDTextField!
  @IBOutlet var googleButton: GIDSignInButton!
  @IBOutlet var fbButton: FDPrimaryButton!
  @IBOutlet var loginStackView: UIStackView!
  
  var viewModel: LoginViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    bindIsLoading()
    bindError()
    bindIsLoginSuccess()
    // Do any additional setup after loading the view.
  }
  
  deinit {}
  
  // MARK: - Helpers
  
  func setup() {
    nameTextField.delegate = self
    passwordTextField.delegate = self
    
    if #available(iOS 13.0, *) {
      let appleButton = ASAuthorizationAppleIDButton(type: .default, style: .black)
      loginStackView.insertArrangedSubview(appleButton, at: 0)
      appleButton.translatesAutoresizingMaskIntoConstraints = false
      appleButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
      appleButton.cornerRadius = 28
      appleButton.addTarget(self, action: #selector(self.appleButtonTapped(_:)), for: .touchUpInside)
    }
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
  
  func bindIsLoginSuccess() {
    viewModel.isLoginSuccess.bind { [weak self] value in
      guard let `self` = self else { return }
      if value {
        self.showHomeViewController()
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
  
  func loginWithFb() {}
  
  func loginWithGoogle() {
    guard let clientId = FirebaseApp.app()?.options.clientID else { return }
    
    let config = GIDConfiguration(clientID: clientId)
    GIDSignIn.sharedInstance.configuration = config
    
    viewModel.loadingMessage = "Please wait"
    viewModel.isLoading.value = true
    
    GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
      
      guard error == nil else {
        viewModel.isLoading.value = false
        viewModel.error.value = error
        return
      }

      guard let user = result?.user,
            let idToken = user.idToken?.tokenString
            
      else {
        viewModel.isLoading.value = false
        presentAlert(title: "Oops!", message: "Error")
        return
      }
      
      let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                     accessToken: user.accessToken.tokenString)

      viewModel.loginWithCredentialGoogle(credential)
    }
  }
  
  func loginWithAppleId() {
    let appleIdProvider = ASAuthorizationAppleIDProvider()
    let request = appleIdProvider.createRequest()
    request.requestedScopes = [.fullName, .email]
    
    request.nonce = viewModel.nonce
    
    let authorizationController = ASAuthorizationController(authorizationRequests: [request])
    authorizationController.delegate = self
    authorizationController.presentationContextProvider = self
    authorizationController.performRequests()
  }
  
  // MARK: - Actions
  
  @IBAction func loginButtonTap(_ sender: Any) {
    viewModel.login()
  }
  
  @IBAction func fbButtonTapped(_ sender: Any) {
    loginWithFb()
  }
  
  @IBAction func googleButtonTapped(_ sender: Any) {
    loginWithGoogle()
  }
  
  @IBAction func signupButtonTap(_ sender: Any) {
    showRegisterViewController()
    removeFromParent()
  }
  
  @IBAction func resetPasswordTap(_ sender: Any) {
    showResetPasswordController()
    removeFromParent()
  }
  
  @objc func appleButtonTapped(_ sender: Any) {
    loginWithAppleId()
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

// MARK: - AppleID Delegate

@available(iOS 13.0, *)
extension LoginViewController: ASAuthorizationControllerDelegate {
  func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
      viewModel.loginWithCredential(appleIDCredential)
    }
  }
    
  func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    presentAlert(title: "Oops!", message: error.localizedDescription)
  }
}

@available(iOS 13.0, *)
extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
  func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
    return view.window!
  }
}
