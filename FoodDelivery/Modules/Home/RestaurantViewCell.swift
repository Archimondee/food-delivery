//
//  RestaurantViewCell.swift
//  FoodDelivery
//
//  Created by Gilang Aditya Rahman on 22/03/23.
//

import UIKit

class RestaurantViewCell: UITableViewCell {
  @IBOutlet var restaurantImageView: UIImageView!
  @IBOutlet var ratingLabel: UILabel!
  @IBOutlet var categoriesLabel: UILabel!
  @IBOutlet var ratingImageView: UIImageView!
  @IBOutlet var nameLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }
}
