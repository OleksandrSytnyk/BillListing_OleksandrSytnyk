//
//  Product.swift
//  BillListing_OleksandrSytnyk
//
//  Created by Oleksandr Sytnyk on 1/24/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//

import Foundation

struct Product {
  var id = ""
  var name: String
  var price: Double
  
  init(name: String, price: Double) {
    self.name = name
    self.price = price
    self.id = UUID().uuidString
  }
}
