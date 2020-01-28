//
//  BillsViewController.swift
//  BillListing_OleksandrSytnyk
//
//  Created by Oleksandr Sytnyk on 1/24/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//

import UIKit

class BillsViewController: UITableViewController {
  
  var bills = [Bill]()
  var isNewBill: Bool?
  let showBill = "showBill"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationItem.title = "Bill Listing".localized
    configureNavigationBar(title: "+", font: UIFont.systemFont(ofSize: 30), selector: #selector(addBill))
    
    tableView.register(UINib(nibName: BillCell.defaultReuseIdentifier, bundle: nil), forCellReuseIdentifier: BillCell.defaultReuseIdentifier)
    tableView.tableFooterView = UIView(frame: CGRect.zero)
  }
  
  @objc func addBill() {
    isNewBill = true
    performSegue(withIdentifier: showBill, sender: nil)
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier == showBill) {
      guard let billViewController =  segue.destination as? BillViewController, let isNewBill = isNewBill else { return }
      var index = defaultBillItemIndex
      
      if isNewBill {
        let bill = Bill()
        bills.append(bill)
        index = bills.count - 1
        billViewController.bill = bill
      } else {
        guard let selectedBillIndex = sender as? Int else { return }
        index = selectedBillIndex
        billViewController.bill = bills[index]
      }
      
      billViewController.saveBillHandler = { [weak self] bill in
        guard let strongSelf = self else { return }
        strongSelf.isNewBill = nil
        strongSelf.tableView.reloadData()
      }
    }
  }
}

// MARK: - Table view data source

extension BillsViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return bills.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: BillCell.defaultReuseIdentifier, for: indexPath) as? BillCell else {
      return UITableViewCell()
    }
    
    let billViewModel = BillViewModel(bill: bills[indexPath.row])
    cell.configure(billViewModel: billViewModel)
    return cell
  }
}

// MARK: - Table view delegate

extension BillsViewController {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    isNewBill = false
    performSegue(withIdentifier: showBill, sender: indexPath.row)
  }
}
