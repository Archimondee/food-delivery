//
//  API.swift
//  FoodDelivery
//
//  Created by Gilang Aditya Rahman on 23/03/23.
//

import Foundation
import Moya

let apiProvider: MoyaProvider<API> = .init(
  plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))]
)

enum API {
  case popular
  case mostPopular
  case category
}

// Target type is moya protocol
extension API: TargetType {
  var baseURL: URL {
    return URL(string: "https://x8ki-letl-twmt.n7.xano.io/api:KJs76dnG")!
  }

  var path: String {
    switch self {
    case .category:
      return "/restaurant/category"
    case .popular:
      return "/restaurant/popular"
    case .mostPopular:
      return "/restaurant/most"
    }
  }

  var method: Moya.Method {
    switch self {
    case .category, .popular, .mostPopular:
      return .get
    }
  }

  var task: Moya.Task {
    switch self {
    case .category:
      return .requestPlain
    case .popular:
      return .requestPlain
    case .mostPopular:
      return .requestPlain
    }
  }

  var headers: [String: String]? {
    return nil
  }
}
