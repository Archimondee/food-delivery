//
//  RestaurantCategory.swift
//  FoodDelivery
//
//  Created by Gilang Aditya Rahman on 23/03/23.
//

import Foundation

struct RestaurantCategory: Decodable {
  let id: Int
  let name: String
  let image: Image?

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case image
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
    self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
    self.image = try container.decodeIfPresent(Image.self, forKey: .image)
  }
}
