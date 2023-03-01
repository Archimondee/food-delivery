//
//  ViewController.swift
//  FoodDelivery
//
//  Created by Gilang Aditya Rahman on 02/03/23.
//

import FDUI
import UIKit

class FDTabBarController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
  }

  func setup() {
    let vc1 = FDNavigationController(rootViewController: UIViewController())
    vc1.title = "Menu"
    vc1.tabBarItem = UITabBarItem(title: "Menu", image: UIImage(named: "tab_menu"), selectedImage: nil)

    let vc2 = FDNavigationController(rootViewController: UIViewController())
    vc2.title = "Profile"
    vc2.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "tab_profile"), selectedImage: nil)

    viewControllers = [vc1, vc2]

    tabBar.tintColor = UIColor(rgb: 0xFC6011)
    tabBar.unselectedItemTintColor = UIColor(rgb: 0xB6B7B7)
  }
}
