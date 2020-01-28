//
//  BillCell.swift
//  BillListing_OleksandrSytnyk
//
//  Created by Oleksandr Sytnyk on 1/26/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//

import UIKit

class BillCell: UITableViewCell {
  @IBOutlet weak var customerNameLabel: UILabel!
  @IBOutlet weak var billNumberLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var dateTimeLabel: UILabel!
  
  func configure(billViewModel: BillPresentable) {
    customerNameLabel.text = billViewModel.customerName
    billNumberLabel.text = billViewModel.billNumber
    priceLabel.text = billViewModel.price
    dateTimeLabel.text = billViewModel.date
  }
}
