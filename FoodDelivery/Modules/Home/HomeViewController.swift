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
  @IBOutlet var locationTitleLabel: UILabel!
  @IBOutlet var searchBar: UISearchBar!
  @IBOutlet var locationButton: UIButton!
  @IBOutlet var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  func setup() {
    // Make title in left
    navigationController?.navigationBar.prefersLargeTitles = true
    searchBar.backgroundImage = UIImage()

    tableView.dataSource = self
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

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Categories", for: indexPath) as! CategoriesViewCell

    cell.collectionView.dataSource = self
    cell.collectionView.delegate = self
    cell.collectionView.reloadData()

    return cell
  }
}

extension HomeViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Category", for: indexPath) as! CategoriesCollectionViewCell

    cell.imageView.image = UIImage(named: "img_dummy_category")
    cell.titleLabel.text = "Cat. \(indexPath.item + 1)"

    return cell
  }
}
