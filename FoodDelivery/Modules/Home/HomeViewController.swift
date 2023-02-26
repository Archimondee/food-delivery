//
//  HomeViewController.swift
//  FoodDelivery
//
//  Created by Gilang Aditya Rahman on 26/02/23.
//

import FDUI
import FirebaseAuth
import UIKit

class HomeViewController: UIViewController {
  @IBOutlet var logoutButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func logoutButtonTap(_ sender: Any) {
    try! Auth.auth().signOut()
    self.showLoginLandingViewController()
  }
}

// MARK: - UIViewController

extension UIViewController {
  // Navigation Replace
  func showHomeViewController() {
    let storyboard = UIStoryboard(name: "Home", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: "Home")

    let scenes = UIApplication.shared.connectedScenes
    let windowScene = scenes.first as! UIWindowScene
    let window = windowScene.windows.first!

    let navigationController = FDNavigationController(rootViewController:
      viewController)
    navigationController.isNavigationBarHidden = true

    window.rootViewController = navigationController
  }
}
