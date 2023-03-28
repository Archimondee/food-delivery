//
//  ProfileViewController.swift
//  FoodDelivery
//
//  Created by Gilang Aditya Rahman on 02/03/23.
//

import FDUI
import Kingfisher
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

  var user: User?

  var newProfileImage: UIImage? {
    // Update profile picture
    didSet {
      self.profileImageView.image = newProfileImage
    }
  }

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

    observeUser()
    if user == nil {
      loadUserData()
    }
  }

  func observeUser() {
    userProvider.user.bind { user in
      self.user = user
      self.setUserData()
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
  }

  func loadUserData() {
    presentLoadingView()
    userProvider.loadMe { [weak self] _ in
      self?.dismissLoadingView()
      self?.setUserData()
    }
  }

  func setUserData() {
    greetingLabel.text = "Hi there \(user?.name ?? "")"
    nameTextField.textField.text = user?.name
    emailTextField.textField.text = user?.email
    phoneTextField.textField.text = user?.phone
    addressTextField.textField.text = user?.address
    locationButton.setTitle("\(String(format: "%.6f", user?.location?.data.latitude ?? 0)), \(String(format: "%.6f", user?.location?.data.longitude ?? 0))", for: .normal)
    passwordTextField.textField.text = "Dummy"

    profileImageView.kf.setImage(with: URL(string: user?.profileImage?.url ?? ""))
  }

  @IBAction func locationButtonTapped(_ sender: Any) {
    presentLocationPickerViewController(completion: { location, address in
      self.addressTextField.text = address ?? ""
      self.locationButton.setTitle("\(String(format: "%.6f", location.latitude)), \(String(format: "%.6f", location.longitude))", for: .normal)
    })
  }

  func takePicture() {
    let alert = UIAlertController(title: "Profile Picture", message: "Select picture source",
                                  preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "Library", style: .default, handler: { _ in
      self.takePictureFromLibrary()
    }))

    alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
      self.takePictureFromCamera()
    }))

    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    present(alert, animated: true)
  }

  func takePictureFromCamera() {
    guard UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) else { return }

    let viewController = UIImagePickerController()
    viewController.delegate = self
    viewController.sourceType = .camera
    viewController.allowsEditing = true

    present(viewController, animated: true)
  }

  func takePictureFromLibrary() {
    guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }

    let viewController = UIImagePickerController()
    viewController.delegate = self
    viewController.sourceType = .photoLibrary
    viewController.allowsEditing = true

    present(viewController, animated: true)
  }

  // MARK: - Action

  @IBAction func cameraButtonTapped(_ sender: Any) {
    takePicture()
  }

  func uploadProfileImage() {
    if let image = newProfileImage {
      userProvider.uploadProfileImage(image) { [weak self] _ in
        self?.dismissLoadingView()
      }
    }
  }
}

extension ProfileViewController: UserProviderProtocol {}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.presentingViewController?.dismiss(animated: true)
  }

  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    if let image = info[.editedImage] as? UIImage {
      newProfileImage = image
      uploadProfileImage()
    }

    dismiss(animated: true)
  }
}
