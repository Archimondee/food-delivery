//
//  FDSecondaryButton.swift
//  FoodDelivery
//
//  Created by Bayu Yasaputro on 18/06/22.
//

import UIKit

public class FDSecondaryButton: UIButton {
  @IBInspectable public var cornerRadius: CGFloat = 0 {
    didSet {
      update()
    }
  }
    
  @IBInspectable public var color: UIColor = .init(rgb: 0xFC6011) {
    didSet {
      update()
    }
  }
    
  override public func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }
    
  override public func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
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
    
  func setup() {
    layer.masksToBounds = true
    backgroundColor = UIColor.clear
    titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
        
    update()
  }
    
  func update() {
    layer.cornerRadius = cornerRadius
    layer.borderWidth = 1
    layer.borderColor = color.cgColor
    setTitleColor(color, for: UIControl.State.normal)
  }
}
