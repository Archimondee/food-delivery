//
//  SignupRequest.swift
//  FoodDelivery
//
//  Created by Gilang Aditya Rahman on 27/03/23.
//

import Foundation

struct SignupRequest: Encodable {
  let name: String?
  let email: String
  let password: String
  let phone: String?
  let address: String?
  let location: Location?

  enum CodingKeys: String, CodingKey {
    case name
    case email
    case password
    case phone
    case address
    case location
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(name, forKey: .name)
    try container.encode(email, forKey: .email)
    try container.encode(password, forKey: .password)
    try container.encode(phone, forKey: .phone)
    try container.encode(address, forKey: .address)
    try container.encode(location, forKey: .location)
  }
}
