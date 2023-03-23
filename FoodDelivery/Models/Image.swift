//
//  Image.swift
//  FoodDelivery
//
//  Created by Gilang Aditya Rahman on 24/03/23.
//

import Foundation

struct Image: Decodable {
  let url: String

  enum CodingKeys: String, CodingKey {
    case image = "url"
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    url = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
  }
}
