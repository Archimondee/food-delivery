//
//  RegisterViewModel.swift
//  FoodDelivery
//
//  Created by Gilang Aditya Rahman on 25/02/23.
//

import FirebaseAuth
import Foundation

class RegisterViewModel {
  let name: FDObservable<String?> = .init(nil)
  let email: FDObservable<String?> = .init(nil)
  let phone: FDObservable<String?> = .init(nil)
  let address: FDObservable<String?> = .init(nil)
  let password: FDObservable<String?> = .init(nil)
  let confirmPassword: FDObservable<String?> = .init(nil)
    
  let isLoading: FDObservable<Bool> = .init(false)
  var loadingMessage: String?
    
  let error: FDObservable<Error?> = .init(nil)
  let isSignUpSuccess: FDObservable<Bool> = .init(false)

  func signUp() {
    guard let name = name.value, name.count >= 3 else {
      let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Name is required and must be longer than 3 characters"])
      self.error.value = error
      return
    }
    
    guard let email = email.value, email.isValidEmail else {
      let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Email is not valid"])
      self.error.value = error
      return
    }
    
    guard let password = password.value, password.isValidPassword else {
      let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Password is not valid. Minimum eight characters, at least one letter and one number."])
      self.error.value = error
      return
    }
    
    guard confirmPassword.value == password else {
      let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Confirm password does not match"])
      self.error.value = error
      return
    }
    
    loadingMessage = "Please wait..."
    isLoading.value = true
    
    Auth.auth().createUser(withEmail: email, password: password) { [weak self] _, error in
      guard let `self` = self else { return }
      if let error = error {
        self.isLoading.value = false
        self.error.value = error
      } else {
        self.isSignUpSuccess.value = true
      }
    }
    
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
      self.isLoading.value = false
      self.isSignUpSuccess.value = true
    }
  }
}
