//
//  LoginViewModel.swift
//  FoodDelivery
//
//  Created by Gilang Aditya Rahman on 26/02/23.
//

import Foundation

class LoginViewModel {
  let email: FDObservable<String?> = .init(nil)
  let password: FDObservable<String?> = .init(nil)

  let isLoading: FDObservable<Bool> = .init(false)
  var loadingMessage: String?

  let error: FDObservable<Error?> = .init(nil)
  let isLoginSuccess: FDObservable<Bool> = .init(false)

  func login() {
    loadingMessage = "Please wait..."
    isLoading.value = true
  }
}
