//
//  BillItem.swift
//  BillListing_OleksandrSytnyk
//
//  Created by Oleksandr Sytnyk on 1/25/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//

import Foundation

struct BillItem {
  var id = ""
  var product: Product
  var quantity: Double = 0
  
  var totalPrice: Double {
    return Double(quantity) * product.price
  }
  
  init(product: Product, quantity: Double) {
    self.product = product
    self.quantity = quantity
    self.id = UUID().uuidString
  }
}
