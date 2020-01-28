//
//  AddBillViewController.swift
//  BillListing_OleksandrSytnyk
//
//  Created by Oleksandr Sytnyk on 1/24/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//

import UIKit
import DropDown

class AddBillViewController: UIViewController {
  
  @IBOutlet weak var billNumberTextField: UITextField!
  @IBOutlet weak var customerTextField: UITextField!
  @IBOutlet weak var addressTextField: UITextField!
  @IBOutlet weak var maleButton: UIButton!
  @IBOutlet weak var femaleButton: UIButton!
  @IBOutlet weak var dropdownButton: UIButton!
  @IBOutlet weak var productPriceLabel: UILabel!
  @IBOutlet weak var productQuantityTextField: UITextField!
  @IBOutlet weak var totalProductPriceLabel: UILabel!
  
  let dropDown = DropDown()
  var bill: Bill?
  
  // TODO - "Add a screen for adding Products. Hardcoding for now"
  var products: [Product] = [Product(name: "Medicine001", price: 15),
                             Product(name: "Medicine002", price: 100),
                             Product(name: "Medicine003", price: 25),
                             Product(name: "Medicine004", price: 40),
                             Product(name: "Medicine005", price: 60.5)]
  var billItemIndex = defaultBillItemIndex
  var addButtonTapHandler: (() -> ())?
  var afterAdding = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setSubviews()
  }
  
  func setButton(_ button: UIButton) {
    button.getRoundBorder()
    button.tintColor = .gray
    button.isSelected = true
  }
  
  func setSubviews() {
    setDropdown()
    setButton(maleButton)
    setButton(femaleButton)
    
    guard let bill = bill else { return }
    billNumberTextField.text = bill.billNumber
    customerTextField.text = bill.customer.name
    addressTextField.text = bill.customer.address
    maleButton.isSelected = bill.customer.gender == .male
    femaleButton.isSelected = bill.customer.gender == .female
  }
  
  func setDropdown() {
    dropDown.anchorView = dropdownButton
    dropDown.hide()
    dropDown.dataSource = products.map {
      $0.name
    }
    dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
      self.dropDown.hide()
      self.dropdownButton.setTitle(item,for: .normal)
      let chosenProduct = self.products.filter {
        $0.name == item
      }.first
      if let product = chosenProduct {
        self.productPriceLabel.text = String(product.price)
      }
    }
  }
  
  func showBillItem(index: Int) {
    guard let bill = bill else { return }
    if index >= 0 {
      dropdownButton.titleLabel?.text = bill.items[index].product.name
      productQuantityTextField.text = String(bill.items[index].quantity)
      totalProductPriceLabel.text = ""
      productPriceLabel.text = String(bill.items[index].product.price)
    } else {
      dropdownButton.titleLabel?.text = "Select Product".localized
      productQuantityTextField.text = ""
      totalProductPriceLabel.text = ""
      productPriceLabel.text = ""
    }
  }
  
  func getBill() {
    guard let billNumber = billNumberTextField.text, !billNumber.isEmpty,
      let customerName = customerTextField.text, !customerName.isEmpty,
      let address = addressTextField.text,
      !address.isEmpty else {
        showAlertMessage(title: "Type in iput".localized, message: "Fill fields for bill number, customer, address.".localized)
        return
    }
    let gender: Person.Gender = maleButton.isSelected ? .male : .female
    
    guard let bill = bill else { return }
    let customer = bill.customer
    customer.name = customerName
    customer.address = address
    customer.gender = gender
    bill.billNumber = billNumber
  }
  
  @IBAction func addButtonTapped(_ sender: Any) {
    guard let bill = bill else {
      showAlertMessage(title: "You haven't created the bill yet!".localized, message: "Create the bill first.".localized)
      return
    }
    guard let productName = dropdownButton.titleLabel?.text, !productName.isEmpty,
      let optQuantity = productQuantityTextField.text,
      let quantity = Double(optQuantity),
      quantity > 0 else {
        showAlertMessage(title: "Type in iput".localized, message: "You should select a product and enter a valid quantity".localized)
        return
    }
    
    let chosenProduct = products.filter {
      $0.name == productName
    }.first
    guard let product = chosenProduct else {
      return
    }
    let item = BillItem(product: product, quantity: quantity)
    if billItemIndex == defaultBillItemIndex {
      bill.items.append(item)
    } else {
      bill.items[billItemIndex] = item
      billItemIndex = defaultBillItemIndex
    }
    addButtonTapHandler?()
  }
  
  @IBAction func dropdownButtonTapped(_ sender: Any) {
    dropDown.show()
  }
  
  @IBAction func maleButtonTapped(_ sender: Any) {
    maleButton.isSelected = true
    femaleButton.isSelected = false
  }
  
  @IBAction func femaleButtonTapped(_ sender: Any) {
    femaleButton.isSelected = true
    maleButton.isSelected = false
  }
  
  @IBAction func setTotalProductPriceLabel() {
    if let priceText = productPriceLabel.text,
      let price = Double(priceText),
      let quantityText = productQuantityTextField.text,
      let quantity = Double(quantityText) {
      totalProductPriceLabel.text = String(price * quantity)
    }
  }
}

extension AddBillViewController: UITextFieldDelegate {
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool  {
    if textField == productQuantityTextField {
      if let priceText = productPriceLabel.text, let _ = Double(priceText) {
        return true
      } else {
        return false
      }
    }
    return true
  }
}
