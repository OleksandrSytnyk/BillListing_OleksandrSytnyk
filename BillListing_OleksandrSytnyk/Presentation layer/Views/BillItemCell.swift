//
//  BillItemCell.swift
//  BillListing_OleksandrSytnyk
//
//  Created by Oleksandr Sytnyk on 1/24/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//

import UIKit

class BillItemCell: UITableViewCell {
  @IBOutlet weak var productNameLabel: UILabel!
  @IBOutlet weak var quantityLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var totalPriceLabel: UILabel!
  
  var tappedCellHandler: (() -> Void)?
  var deleteItemHandler: (() -> Void)?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    setGestureRecognizer()
  }
  
  @IBAction func deleteButtonTapped(_ sender: Any) {
    deleteItemHandler?()
  }
  
  func setGestureRecognizer() {
    let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
    singleTap.delegate = self
    contentView.isUserInteractionEnabled = true
    contentView.addGestureRecognizer(singleTap)
  }
  
  @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer?) {
    tappedCellHandler?()
  }
  
  func configure(billItemViewModel: BillItemPresentable) {
    productNameLabel.text = billItemViewModel.productName
    priceLabel.text = billItemViewModel.price
    quantityLabel.text = billItemViewModel.quantity
    totalPriceLabel.text = billItemViewModel.totalPrice
  }
}
