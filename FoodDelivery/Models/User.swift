//
//  User.swift
//  FoodDelivery
//
//  Created by Gilang Aditya Rahman on 27/03/23.
//

import Foundation

struct User: Codable {
  let id: Int
  var name: String
  let email: String
  var phone: String
  var address: String
  var location: Location?
  let profileImage: Image?

  enum CodingKeys: String, CodingKey {
    case id
    case name
    case email
    case phone
    case address
    case location
    case profileImage = "profile_image"
  }

  init(from decoder: Decoder) throws {
    let contaner = try decoder.container(keyedBy: CodingKeys.self)
    id = try contaner.decodeIfPresent(Int.self, forKey: .id) ?? 0
    name = try contaner.decodeIfPresent(String.self, forKey: .name) ?? ""
    email = try contaner.decodeIfPresent(String.self, forKey: .email) ?? ""
    phone = try contaner.decodeIfPresent(String.self, forKey: .phone) ?? ""
    address = try contaner.decodeIfPresent(String.self, forKey: .address) ?? ""
    location = try contaner.decodeIfPresent(Location.self, forKey: .location)
    profileImage = try contaner.decodeIfPresent(Image.self, forKey: .profileImage)
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(name, forKey: .name)
    try container.encode(phone, forKey: .phone)
    try container.encode(address, forKey: .address)
    try container.encode(location, forKey: .location)
  }
}
