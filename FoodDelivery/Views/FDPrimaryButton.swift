//
//  FDPrimaryButton.swift
//  FoodDelivery
//
//  Created by Bayu Yasaputro on 18/06/22.
//

import UIKit

@IBDesignable
public class FDPrimaryButton: UIButton {
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
    setTitleColor(UIColor.white, for: UIControl.State.normal)
    titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
    layer.masksToBounds = true
        
    update()
  }
    
  func update() {
    backgroundColor = color
    layer.cornerRadius = cornerRadius
  }
}
