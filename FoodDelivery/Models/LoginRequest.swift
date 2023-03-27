//
//  LoginRequest.swift
//  FoodDelivery
//
//  Created by Gilang Aditya Rahman on 27/03/23.
//

import Foundation

struct LoginRequest: Encodable {
  let email: String
  let password: String

  enum CodingKeys: String, CodingKey {
    case email
    case password
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(email, forKey: .email)
    try container.encode(password, forKey: .password)
  }
}
