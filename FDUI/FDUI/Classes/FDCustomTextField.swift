//
//  FDCustomTextField.swift
//  FDUI
//
//  Created by Gilang Aditya Rahman on 24/03/23.
//

import UIKit

@IBDesignable
public class FDCustomTextField: UIView {
  weak var stackView: UIStackView!
  public weak var titleLabel: UILabel!
  public weak var textField: UITextField!
  public enum ContentType: Int {
    case `default` = 0
    case phone = 1
    case email = 2
    case password = 3
  }
  
  public var contentType: ContentType = .default {
    didSet { update() }
  }
  
  @IBInspectable public var cornerRadius: CGFloat = 0 {
    didSet { update() }
  }
  
  @IBInspectable public var title: String = "" {
    didSet { update() }
  }
  
  @IBInspectable public var text: String = "" {
    didSet { update() }
  }
  
  @IBInspectable public var placeholder: String = "" {
    didSet { update() }
  }
  
  @IBInspectable public var _contentType: Int = 0 {
    didSet {
      contentType = ContentType(rawValue: _contentType) ?? .default
      update()
    }
  }
  
  override public func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    setup()
  }
  
  override public func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }
  
  override public init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  override public func layoutSubviews() {
    super.layoutSubviews()
    if cornerRadius == 0 {
      layer.cornerRadius = frame.height / 2
    }
  }
  
  func setup() {
    backgroundColor = UIColor(rgb: 0xF2F2F2)
    if viewWithTag(99) == nil {
      let button = UIButton(type: .system)
      button.tag = 99
      addSubview(button)
      button.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        button.leadingAnchor.constraint(equalTo: leadingAnchor),
        button.trailingAnchor.constraint(equalTo: trailingAnchor),
        button.topAnchor.constraint(equalTo: topAnchor),
        button.bottomAnchor.constraint(equalTo: bottomAnchor),
      ])
      button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    if stackView == nil {
      let stackView = UIStackView(frame: .zero)
      addSubview(stackView)
      self.stackView = stackView
      stackView.axis = .vertical
      stackView.spacing = 4
      stackView.alignment = .fill
      stackView.distribution = .fill
      stackView.isUserInteractionEnabled = false
      stackView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 36),
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -36),
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
      ])
    }
    
    if titleLabel == nil {
      let titleLabel = UILabel(frame: .zero)
      stackView.addArrangedSubview(titleLabel)
      self.titleLabel = titleLabel
      titleLabel.font = UIFont.systemFont(ofSize: 11, weight: .regular)
      titleLabel.textColor = UIColor(rgb: 0xB6B7B7)
    }
    
    if textField == nil {
      let textField = UITextField(frame: .zero)
      stackView.addArrangedSubview(textField)
      self.textField = textField
      textField.font = UIFont.systemFont(ofSize: 14, weight: .medium)
      textField.textColor = UIColor(rgb: 0x4A4B4D)
      textField.translatesAutoresizingMaskIntoConstraints = false
      textField.heightAnchor.constraint(greaterThanOrEqualToConstant: 14).isActive = true
    }
    
    update()
  }
  
  func update() {
    titleLabel.text = title
    textField.placeholder = placeholder
    textField.text = text
    layer.cornerRadius = cornerRadius
    layer.masksToBounds = true
    
    switch contentType {
    case .default:
      textField.keyboardType = .default
      textField.isSecureTextEntry = false
      textField.textContentType = .none
    case .email:
      textField.keyboardType = .emailAddress
      textField.isSecureTextEntry = false
      textField.textContentType = .emailAddress
    case .phone:
      textField.keyboardType = .phonePad
      textField.isSecureTextEntry = false
      textField.textContentType = .telephoneNumber
    case .password:
      textField.keyboardType = .default
      textField.isSecureTextEntry = true
      textField.textContentType = .password
    }
  }
  
  @objc func buttonTapped(_ sender: Any) {
    textField.becomeFirstResponder()
  }
}
