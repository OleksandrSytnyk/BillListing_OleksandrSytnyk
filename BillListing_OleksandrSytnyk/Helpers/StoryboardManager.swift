//
//  StoryboardManager.swift
//  BillListing_OleksandrSytnyk
//
//  Created by Oleksandr Sytnyk on 1/24/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//

import Foundation
import UIKit

class StoryboardManager {
  enum ViewControllerIdentifier: String {
    case bill = "BillViewController"
  }
  
  static func instantiateBillViewController() -> BillViewController? {
    return instatiateViewController(controllerIdentifier: ViewControllerIdentifier.bill.rawValue, controllerType: BillViewController.self)
  }
  
  static func instatiateViewController<T>(controllerIdentifier: String,
                                          controllerType: T.Type) -> T? {
    return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: controllerIdentifier) as? T
  }
}
