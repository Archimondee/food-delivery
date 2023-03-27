//
//  FDCustomTextField.swift
//  FDUI
//
//  Created by Gilang Aditya Rahman on 24/03/23.
//

import UIKit

@IBDesignable
public class FDCustomTextField: UIControl {
  weak var hStackView: UIStackView!
  weak var vStackView: UIStackView!
  public weak var titleLabel: UILabel!
  public weak var textField: UITextField!
  weak var accessoryButton: UIButton!
  
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
    if hStackView == nil {
      let hStackView = UIStackView(frame: .zero)
      addSubview(hStackView)
      self.hStackView = hStackView
      hStackView.axis = .horizontal
      hStackView.spacing = 8
      hStackView.alignment = .fill
      hStackView.distribution = .fill
      hStackView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        hStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 36),
        hStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -36),
        hStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
        hStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
      ])
    }
    if vStackView == nil {
      let vStackView = UIStackView(frame: .zero)
      hStackView.addArrangedSubview(vStackView)
      self.vStackView = vStackView
      vStackView.axis = .vertical
      vStackView.spacing = 4
      vStackView.alignment = .fill
      vStackView.distribution = .fill
    }
    
    if titleLabel == nil {
      let titleLabel = UILabel(frame: .zero)
      vStackView.addArrangedSubview(titleLabel)
      self.titleLabel = titleLabel
      titleLabel.font = UIFont.systemFont(ofSize: 11, weight: .regular)
      titleLabel.textColor = UIColor(rgb: 0xB6B7B7)
    }
    
    if textField == nil {
      let textField = UITextField(frame: .zero)
      vStackView.addArrangedSubview(textField)
      self.textField = textField
      textField.font = UIFont.systemFont(ofSize: 14, weight: .medium)
      textField.textColor = UIColor(rgb: 0x4A4B4D)
      textField.translatesAutoresizingMaskIntoConstraints = false
      textField.heightAnchor.constraint(greaterThanOrEqualToConstant: 14).isActive = true
    }
    
    if accessoryButton == nil {
      switch contentType {
      case .password:
        let accessoryButton = UIButton(type: .system)
        hStackView.addArrangedSubview(accessoryButton)
        self.accessoryButton = accessoryButton
        accessoryButton.setImage(UIImage(systemName: "eye"), for: .normal)
        accessoryButton.tintColor = UIColor(rgb: 0xB6B7B7)
        accessoryButton.setContentHuggingPriority(.required, for: .horizontal)
        accessoryButton.addTarget(self, action: #selector(accessoryButtonTapped(_:)), for: .touchUpInside)
      
      default:
        break
      }
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
  
  @objc func accessoryButtonTapped(_ sender: Any) {
    textField.isSecureTextEntry = !textField.isSecureTextEntry
    accessoryButton.setImage(textField.isSecureTextEntry ? UIImage(systemName: "eye") : UIImage(systemName: "eye.slash"), for: .normal)
  }
  
  override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    if let point = touches.first?.location(in: self), bounds.contains(point) {
      textField.becomeFirstResponder()
    }
  }
}
