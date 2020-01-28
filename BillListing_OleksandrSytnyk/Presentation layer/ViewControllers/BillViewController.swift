//
//  BillViewController.swift
//  BillListing_OleksandrSytnyk
//
//  Created by Oleksandr Sytnyk on 1/25/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//

import UIKit

class BillViewController: UIViewController {
  var bill: Bill?
  var addBillViewController: AddBillViewController?
  var billItemsViewController: BillItemsViewController?
  var saveBillHandler: ((Bill) -> ())?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    self.navigationItem.title = "Bill Entry".localized
    self.navigationItem.setHidesBackButton(true, animated: true)
    configureNavigationBar(title: "Save".localized, font: UIFont.systemFont(ofSize: 20), selector: #selector(saveBill))
  }
  
  @objc func saveBill() {
    addBillViewController?.getBill()
    if let bill = bill {
      saveBillHandler?(bill)
    }
    navigationController?.popToRootViewController(animated: true)
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier == "showBillItems") {
      guard let billItemsViewController =  segue.destination as? BillItemsViewController else { return }
      self.billItemsViewController = billItemsViewController
      billItemsViewController.bill = bill
      billItemsViewController.billItemSelectHandler = { [weak self] billItemIndex in
        guard let addBillViewController = self?.addBillViewController else { return }
        addBillViewController.billItemIndex = billItemIndex
        addBillViewController.showBillItem(index: billItemIndex)
        addBillViewController.billItemIndex = billItemIndex
      }
      billItemsViewController.billItemDeleteHandler = { [weak self]  in
        guard let strongSelf = self, let addBillViewController = strongSelf.addBillViewController else {
          return
        }
        addBillViewController.showBillItem(index: defaultBillItemIndex)
        addBillViewController.billItemIndex = defaultBillItemIndex
      }
    } else if (segue.identifier == "showAddBill") {
      guard let addBillViewController =  segue.destination as? AddBillViewController else { return }
      self.addBillViewController = addBillViewController
      addBillViewController.bill = bill
    }
    
    addBillViewController?.addButtonTapHandler = {[weak self] in
      self?.billItemsViewController?.tableView.reloadData()
    }
  }
}
