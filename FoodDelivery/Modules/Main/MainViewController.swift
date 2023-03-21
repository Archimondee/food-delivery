//
//  MainViewController.swift
//  FoodDelivery
//
//  Created by Gilang Aditya Rahman on 01/03/23.
//

import FDUI
import FirebaseAuth
import UIKit

class MainViewController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
  }

  // MARK: - Utils

  func setup() {
    tabBar.tintColor = UIColor(rgb: 0xFC6011)
    tabBar.unselectedItemTintColor = UIColor(rgb: 0xB6B7B7)

    delegate = self
    // Set selected index
    // selectedIndex = 2
  }
}

extension MainViewController: UITabBarControllerDelegate {
  func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
    if Auth.auth().currentUser == nil {
      //presentAlert(title: "Oops!", message: "Please login")
      showLoginViewController()
      return false
    }

    return true
  }
}

// MARK: - UIViewController

extension UIViewController {
  // Navigation Replace
  func showMainViewController() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: "Main")

    // let viewController = FDTabBarController()

    let scenes = UIApplication.shared.connectedScenes
    let windowScene = scenes.first as! UIWindowScene
    let window = windowScene.windows.first!

    window.rootViewController = viewController
  }
}
