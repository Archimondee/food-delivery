//
//  LoginLandingViewController.swift
//  FoodDelivery
//
//  Created by Gilang Aditya Rahman on 21/02/23.
//

import UIKit

class LoginLandingViewController: UIViewController {
  @IBOutlet var loginButton: UIButton!
  @IBOutlet var registerButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  func setup() {
    //loginButton.layer.cornerRadius = 28
    
//    registerButton.layer.borderWidth = 1
//    registerButton.layer.borderColor = UIColor.primary.cgColor
//    registerButton.layer.cornerRadius = 28
  }
  
  @IBAction func loginButtonTapped(_ sender: Any) {
    showLoginViewController()
  }
  @IBAction func registerButtonTapped(_ sender: Any) {
    showRegisterViewController()
  }
}

// MARK: - UIViewController

extension UIViewController {
  // Navigation Replace
  func showLoginLandingViewController() {
    let storyboard = UIStoryboard(name: "Login", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: "LoginLanding")

    let scenes = UIApplication.shared.connectedScenes
    let windowScene = scenes.first as! UIWindowScene
    let window = windowScene.windows.first!
    
    let navigationController = UINavigationController(rootViewController:
                                                        viewController)
    navigationController.isNavigationBarHidden = true

    window.rootViewController = navigationController
  }
}
