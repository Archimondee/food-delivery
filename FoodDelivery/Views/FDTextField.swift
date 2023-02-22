//
//  FDTextField.swift
//  FoodDelivery
//
//  Created by Gilang Aditya Rahman on 21/02/23.
//

import UIKit

@IBDesignable
class FDTextField: UITextField {
  @IBInspectable var cornerRadius: CGFloat = 0 {
    didSet {
      update()
    }
  }
  
  let padding = UIEdgeInsets(top: 0, left: 36, bottom: 0, right: 36)
  
  override open func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
  
  override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
  
  override open func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: padding)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }
  
  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    setup()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  func setup() {
    backgroundColor = UIColor(rgb: 0xF2F2F2)
    font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
    layer.masksToBounds = true
    
    update()
  }
  
  func update() {
    layer.cornerRadius = cornerRadius
  }
}
