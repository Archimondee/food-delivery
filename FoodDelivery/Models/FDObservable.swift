//
//  FDObservable.swift
//  FoodDelivery
//
//  Created by Gilang Aditya Rahman on 20/02/23.
//

import Foundation

class FDObservable<T> {
  var value: T {
    didSet {
      listeners.forEach { listen in
        listen(value)
      }
    }
  }

  private var listeners: [(T) -> Void] = []

  init(_ value: T) {
    self.value = value
  }

  func bind(_ listener: @escaping (T) -> Void) {
    listener(value)
    self.listeners.append(listener)
  }
}
