//
//  FDImage.swift
//  FDUI
//
//  Created by Gilang Aditya Rahman on 24/03/23.
//

import UIKit

@IBDesignable
public class FDImage: UIImageView {
  @IBInspectable public var cornerRadius: CGFloat = 0 {
    didSet {
      update()
    }
  }
  
  override public func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    
    update()
  }
  
  override public func awakeFromNib() {
    super.awakeFromNib()
    update()
  }
  
  override public init(frame: CGRect) {
    super.init(frame: frame)
    update()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    update()
  }
  
  func update() {
    layer.cornerRadius = cornerRadius
    layer.masksToBounds = true
  }
}
