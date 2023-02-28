//
//  ResetPasswordViewModel.swift
//  FoodDelivery
//
//  Created by Gilang Aditya Rahman on 01/03/23.
//

import FirebaseAuth
import Foundation

class ResetPasswordViewModel {
  let email: FDObservable<String?> = .init(nil)

  let isLoading: FDObservable<Bool> = .init(false)
  var loadingMessage: String?

  let error: FDObservable<Error?> = .init(nil)
  let isEmailSuccess: FDObservable<Bool> = .init(false)

  func resetPassword() {
    loadingMessage = "Please wait..."
    isLoading.value = true

    guard let email = email.value, email.isValidEmail else {
      let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Email is not valid"])
      isLoading.value = false
      self.error.value = error
      return
    }

    Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
      guard let `self` = self else { return }
      if let error = error {
        self.isLoading.value = false
        self.error.value = error
      } else {
        self.loadingMessage = "Sending an email"
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
          self.isLoading.value = false
          self.isEmailSuccess.value = true
        }
      }
    }
  }
}
