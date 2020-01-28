//
//  BillItemsViewController.swift
//  BillListing_OleksandrSytnyk
//
//  Created by Oleksandr Sytnyk on 1/24/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//

import UIKit

class BillItemsViewController: UITableViewController {
  var bill: Bill?
  var billItemSelectHandler: ((Int) -> ())?
  var billItemDeleteHandler: (() -> ())?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.register(UINib(nibName: BillItemCell.defaultReuseIdentifier, bundle: nil), forCellReuseIdentifier: BillItemCell.defaultReuseIdentifier)
    tableView.tableFooterView = UIView(frame: CGRect.zero)
  }
  
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return bill?.items.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: BillItemCell.defaultReuseIdentifier, for: indexPath) as? BillItemCell else {
      return UITableViewCell()
    }
    
    if let billItem = bill?.items[indexPath.row] {
      let billItemViewModel = BillItemViewModel(billItem: billItem)
      cell.configure(billItemViewModel: billItemViewModel)
      
      cell.deleteItemHandler = { [weak self] in
        self?.bill?.items.remove(at: indexPath.row)
        self?.tableView.reloadData()
        self?.billItemDeleteHandler?()
      }
      cell.tappedCellHandler = { [weak self] in
        self?.billItemSelectHandler?(indexPath.row)
      }
    }
    return cell
  }
}
