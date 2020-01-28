//
//  Bill.swift
//  BillListing_OleksandrSytnyk
//
//  Created by Oleksandr Sytnyk on 1/25/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//

import Foundation

class Bill {
  var id = UUID().uuidString
  var billNumber = ""
  var customer: Person
  var date = Date()
  var items = [BillItem]()
  
  var totalPrice: Double {
    items.reduce(into: 0){ accumulator, nextValue in
      accumulator += nextValue.totalPrice
    }
  }
  
  init() {
    self.billNumber = ""
    self.customer = Person(name: "", gender: .male)
  }
  
  init(billNumber: String, customer: Person) {
    self.billNumber = billNumber
    self.customer = customer
  }
}
