//
//  LoginViewModel.swift
//  FoodDelivery
//
//  Created by Gilang Aditya Rahman on 26/02/23.
//

import AuthenticationServices
import CryptoKit
import Firebase
import Foundation

class LoginViewModel {
  let email: FDObservable<String?> = .init(nil)
  let password: FDObservable<String?> = .init(nil)

  let isLoading: FDObservable<Bool> = .init(false)
  var loadingMessage: String?

  let error: FDObservable<Error?> = .init(nil)
  let isLoginSuccess: FDObservable<Bool> = .init(false)

  fileprivate var currentNonce: String?
  var nonce: String {
    let nonce = randomNonceString()
    currentNonce = nonce
    return sha256(nonce)
  }

  func loginWithEmail() {
    loadingMessage = "Please wait..."
    isLoading.value = true

    userProvider.login(email: email.value ?? "", password: password.value ?? "") {
      [weak self] result in
      guard let `self` = self else { return }
      switch result {
      case .success:
        self.userProvider.loadMe { [weak self] _ in
          guard let `self` = self else { return }
          self.isLoading.value = false
          self.isLoginSuccess.value = true
        }
      case .failure(let error):
        self.isLoading.value = false
        self.error.value = error
      }
    }
  }

  func login() {
    loadingMessage = "Please wait..."
    isLoading.value = true

    Auth.auth().signIn(withEmail: email.value ?? "", password: password.value ?? "") {
      [weak self] _, error in
      guard let `self` = self else { return }

      self.isLoading.value = false
      if let error = error {
        self.error.value = error
      } else {
        self.isLoginSuccess.value = true
      }
    }
  }

  private func randomNonceString(length: Int = 32) -> String {
    precondition(length > 0)
    let charset: [Character] =
      Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
    var result = ""
    var remainingLength = length

    while remainingLength > 0 {
      let randoms: [UInt8] = (0 ..< 16).map { _ in
        var random: UInt8 = 0
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
        if errorCode != errSecSuccess {
          fatalError(
            "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
          )
        }
        return random
      }

      randoms.forEach { random in
        if remainingLength == 0 {
          return
        }

        if random < charset.count {
          result.append(charset[Int(random)])
          remainingLength -= 1
        }
      }
    }

    return result
  }

  private func sha256(_ input: String) -> String {
    let inputData = Data(input.utf8)
    let hashedData = SHA256.hash(data: inputData)
    let hashString = hashedData.compactMap {
      String(format: "%02x", $0)
    }.joined()

    return hashString
  }

  func loginWithCredential(_ credential: ASAuthorizationAppleIDCredential) {
    guard let nonce = currentNonce else {
      let error = NSError(domain: "", code: 0,
                          userInfo: [NSLocalizedDescriptionKey: "Invalid state: A login callback was received, but no login request was sent."])
      self.error.value = error
      return
    }
    guard let appleIDToken = credential.identityToken else {
      let error = NSError(domain: "", code: 0,
                          userInfo: [NSLocalizedDescriptionKey: "Unable to fetch identity token"])
      self.error.value = error
      return
    }
    guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
      print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
      let error = NSError(domain: "", code: 0,
                          userInfo: [NSLocalizedDescriptionKey: "Unable to serialize token string from data: \(appleIDToken.debugDescription)"])
      self.error.value = error
      return
    }

    let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                              idToken: idTokenString,
                                              rawNonce: nonce)
    loadingMessage = "Please wait"
    isLoading.value = true

    Auth.auth().signIn(with: credential) { _, error in
      if let error = error {
        self.isLoading.value = false
        self.error.value = error
        return
      }
      self.isLoading.value = false
      self.isLoginSuccess.value = true
    }
  }

  func loginWithCredentialGoogle(_ credential: AuthCredential) {
    loadingMessage = "Logged in"
    isLoading.value = true
    Auth.auth().signIn(with: credential) { _, error in
      if let error = error {
        self.isLoading.value = false
        self.error.value = error
      }

      self.isLoading.value = false
      self.isLoginSuccess.value = true
    }
  }
}

// MARK: - UserProviderProtocol

extension LoginViewModel: UserProviderProtocol {}
