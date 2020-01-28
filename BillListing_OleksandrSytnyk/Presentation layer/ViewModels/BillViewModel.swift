//
//  BillViewModel.swift
//  BillListing_OleksandrSytnyk
//
//  Created by Oleksandr Sytnyk on 1/25/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//

import Foundation

protocol BillPresentable {
  var customerName: String { get }
  var billNumber: String { get }
  var price: String { get }
  var date: String { get }
}

struct BillViewModel {
  var bill: Bill
  
  init(bill: Bill) {
    self.bill = bill
  }
}

extension BillViewModel: BillPresentable {
  var customerName: String {
    return bill.customer.name
  }
  
  var billNumber: String {
    return bill.billNumber
  }
  
  var price: String {
    let totalPrice = bill.items.reduce(into: 0) {
      $0 += $1.totalPrice
    }
    return String(totalPrice)
  }
  
  var date: String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter.string(from: bill.date)
  }
}
