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
    tableView.delegate = self
  }

  // MARK: - Actions

  @objc func restaurantsButtonTapped(_ sender: Any) {
    print("View all restaurant")
  }

  @objc func popularRestaurantsButtonTapped(_ sender: Any) {
    print("View all restaurant")
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
    return 3
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 1
    case 1:
      return 3
    case 2:
      return 0
    default:
      return 0
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      let cell = tableView.dequeueReusableCell(withIdentifier: "Categories", for: indexPath) as! CategoriesViewCell

      cell.collectionView.dataSource = self
      cell.collectionView.delegate = self
      cell.collectionView.reloadData()

      return cell
    case 1:
      let cell = tableView.dequeueReusableCell(withIdentifier: "Restaurant", for: indexPath) as! RestaurantViewCell

      cell.restaurantImageView.image = UIImage(named: "img_pizza")
      cell.nameLabel.text = "Pizza Yummy!"

      let ratingAttText: NSMutableAttributedString = .init(string: "4.9",
                                                           attributes: [
                                                             .font: UIFont.systemFont(ofSize: 12, weight: .regular),
                                                             .foregroundColor: UIColor.primary
                                                           ])
      ratingAttText.append(NSAttributedString(string: " (124 ratings)",
                                              attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .regular),
                                                           .foregroundColor: UIColor.placeholder]))

      cell.ratingLabel.attributedText = ratingAttText
      let categories: [String] = ["Cafė", "Western Food"]
      let categoriesAttText: NSMutableAttributedString = .init()

      for i in 0 ..< categories.count {
        categoriesAttText.append(NSAttributedString(string: categories[i],
                                                    attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .regular),
                                                                 .foregroundColor: UIColor.placeholder]))

        if i != categories.count - 1 {
          categoriesAttText.append(NSAttributedString(string: " - ", attributes: [
            .font: UIFont.systemFont(ofSize: 12, weight: .regular),
            .foregroundColor: UIColor.primary
          ]))
        }
      }
      cell.categoriesLabel.attributedText = categoriesAttText
      return cell

    default:
      return UITableViewCell()
    }
  }
}

extension HomeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    switch section {
    case 0:
      return nil
    case 1, 2:
      let view = UIView(frame: .zero)
      view.backgroundColor = .white
      let label = UILabel(frame: .zero)
      label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
      label.textColor = UIColor.primaryText
      label.text = "Popular Restaurants"
      view.addSubview(label)
      label.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32)
      ])

      let button = UIButton(type: UIButton.ButtonType.system)
      button.setTitleColor(.primary, for: .normal)
      button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .medium)
      button.setTitle("View all", for: .normal)
      view.addSubview(button)

      button.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        button.centerYAnchor.constraint(equalTo: label.centerYAnchor)
      ])
      switch section {
      case 1:
        label.text = "Popular Restaurants"
        button.addTarget(self, action: #selector(restaurantsButtonTapped(_:)), for: .touchUpInside)
      case 2:
        label.text = "Most Popular"
        button.addTarget(self, action: #selector(popularRestaurantsButtonTapped(_:)), for: .touchUpInside)
      default:
        break
      }

      return view
    default:
      return UIView()
    }
  }

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    switch section {
    case 0:
      return 0
    case 1, 2:
      return 72
    default:
      return 0
    }
  }

  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return nil
  }

  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0.001
  }
}

extension HomeViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    presentAlert(title: "Hello", message: "Message!!")
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
