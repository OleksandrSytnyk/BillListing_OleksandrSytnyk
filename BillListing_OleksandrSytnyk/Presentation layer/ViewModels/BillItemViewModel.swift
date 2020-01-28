//
//  BillItemViewModel.swift
//  BillListing_OleksandrSytnyk
//
//  Created by Oleksandr Sytnyk on 1/25/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//

protocol BillItemPresentable {
  var productName: String { get }
  var price: String { get }
  var quantity: String { get }
  var totalPrice: String { get }
}

struct BillItemViewModel {
  var billItem: BillItem
  
  init(billItem: BillItem) {
    self.billItem = billItem
  }
}

extension BillItemViewModel: BillItemPresentable {
  var productName: String {
    return billItem.product.name
  }
  
  var price: String {
    return String(billItem.product.price)
  }
  
  var quantity: String {
    return String(billItem.quantity)
  }
  
  var totalPrice: String {
    return String(billItem.product.price * billItem.quantity)
  }
}
