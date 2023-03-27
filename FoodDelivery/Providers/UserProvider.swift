//
//  UserProvider.swift
//  FoodDelivery
//
//  Created by Gilang Aditya Rahman on 27/03/23.
//

import Foundation
import RxSwift

//Saving token to user default

class UserProvider {
  fileprivate static let shared: UserProvider = .init()
  private init() {}
  
  let user: FDObservable<User?> = .init(nil)
  
  private let kAccessTokenKey: String = "\(Bundle.main.bundleIdentifier ?? "").kAccessToken"
  
  #if DEBUG
  var accessToken: String? {
    get {
      return UserDefaults.standard.value(forKey: kAccessTokenKey) as? String
    }
    
    set {
      UserDefaults.standard.set(newValue, forKey: kAccessTokenKey)
      UserDefaults.standard.synchronize()
    }
  }
  #else
  var accessToken: String? {
    get {
      return UserDefaults.standard.value(forKey: kAccessTokenKey) as? String
    }
    
    set {
      UserDefaults.standard.set(newValue, forKey: kAccessTokenKey)
      UserDefaults.standard.synchronize()
    }
  }
  #endif
  
  private let dispseBag = DisposeBag()
}

protocol UserProviderProtocol {}
extension UserProviderProtocol {
  var userProvider: UserProvider {
    return UserProvider.shared
  }
}
