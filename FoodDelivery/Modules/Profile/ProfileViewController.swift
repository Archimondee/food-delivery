//
//  ProfileViewController.swift
//  FoodDelivery
//
//  Created by Gilang Aditya Rahman on 02/03/23.
//

import FDUI
import UIKit

class ProfileViewController: UIViewController {
  @IBOutlet var profileImageView: UIImageView!
  @IBOutlet var signOutButton: UIButton!
  @IBOutlet var greetingLabel: UILabel!
  @IBOutlet var editButton: UIButton!
  @IBOutlet var nameTextField: FDCustomTextField!
  @IBOutlet var emailTextField: FDCustomTextField!
  @IBOutlet var phoneTextField: FDCustomTextField!
  @IBOutlet var addressTextField: FDCustomTextField!
  @IBOutlet var passwordTextField: FDCustomTextField!
  @IBOutlet var saveButton: FDPrimaryButton!
  @IBOutlet var stackView: UIStackView!
  @IBOutlet var locationButton: FDSecondaryButton!
  override func viewDidLoad() {
    super.viewDidLoad()

    // Cannot edit password field
    // passwordTextField.textField.isUserInteractionEnabled = false

    let socialTextField = FDCustomTextField(frame: .zero)
    socialTextField.title = "Instagram"
    socialTextField.text = "@gembul.svg"
    socialTextField.textField.isUserInteractionEnabled = false
    socialTextField.contentType = .phone

    stackView.insertArrangedSubview(socialTextField, at: 4)
  }

  @IBAction func locationButtonTapped(_ sender: Any) {
    presentLocationPickerViewController(completion: { location, address in
      self.addressTextField.text = address ?? ""
      self.locationButton.setTitle("\(String(format: "%.6f", location.latitude)), \(String(format: "%.6f", location.longitude))", for: .normal)
    })
  }
}
