//
//  UIColorExtension.swift
//  FoodDelivery
//
//  Created by Gilang Aditya Rahman on 21/02/23.
//

import UIKit

extension UIColor {
  static var primary: UIColor = UIColor(named: "Primary")!
  
  public convenience init(red: Int, green: Int, blue: Int) {
    assert(red >= 0 && red <= 255, "Invalid red number")
    assert(green >= 0 && green <= 255, "Invalid green number")
    assert(blue >= 0 && blue <= 255, "Invalid blue number")
    self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 110)
  }

  public convenience init(rgb: Int) {
    self.init(
      red: (rgb >> 16) & 0xFF,
      green: rgb >> 8 & 0xFF,
      blue: rgb & 0xFF
    )
  }
}
