//
//  AuthAPI.swift
//  FoodDelivery
//
//  Created by Gilang Aditya Rahman on 27/03/23.
//

import Foundation
import Moya

let authAPIProvider: MoyaProvider<AuthAPI> = .init(
  plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))]
)

enum AuthAPI {
  case signup(SignupRequest)
  case login(LoginRequest)
  case me
  case profileImage(UIImage, Int)
}

extension AuthAPI: TargetType, UserProviderProtocol {
  var baseURL: URL {
    return URL(string: "https://x8ki-letl-twmt.n7.xano.io/api:8mC4M4TB")!
  }

  var path: String {
    switch self {
    case .signup:
      return "/auth/signup"
    case .login:
      return "/auth/login"
    case .me:
      return "/auth/me"
    case .profileImage(_, let userId):
      return "/user/\(userId)/profile_image"
    }
  }

  var method: Moya.Method {
    switch self {
    case .signup, .login, .profileImage:
      return .post
    case .me:
      return .get
    }
  }

  var task: Task {
    switch self {
    case .signup(let signupRequest):
      return .requestJSONEncodable(signupRequest)
    case .login(let loginRequest):
      return .requestJSONEncodable(loginRequest)
    case .me:
      return .requestPlain

    case .profileImage(let image, _):
      let imageData = image.pngData() ?? Data()
      let formData = MultipartFormData(provider: .data(imageData),
                                       name: "content",
                                       fileName: "profile.png",
                                       mimeType: "image/png")
      return .uploadMultipart([formData])
    }
  }

  var headers: [String: String]? {
    switch self {
    case .me, .profileImage:
      if let accessToken = userProvider.accessToken {
        return [
          "Authorization": "Bearer \(accessToken)"
        ]
      }
      else {
        fallthrough
      }
    case .signup, .login:
      return nil
    }
  }
}
