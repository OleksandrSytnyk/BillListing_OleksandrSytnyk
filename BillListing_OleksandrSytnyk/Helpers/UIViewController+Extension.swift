//
//  UIViewController+Extension.swift
//  BillListing_OleksandrSytnyk
//
//  Created by Oleksandr Sytnyk on 1/24/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

extension UIViewController {
  func configureNavigationBar(title: String, font: UIFont, selector: Selector) {
    let barButton = UIButton(type: .custom)
    barButton.frame = CGRect(x: 0, y: 0, width: 70, height: 44)
    barButton.addTarget(self, action: selector, for: .touchUpInside)
    barButton.setTitle(title, for: .normal)
    barButton.titleLabel?.font = font
    barButton.setTitleColor(.black, for: .normal)
    barButton.backgroundColor = .green
    barButton.transform = CGAffineTransform(translationX: 15, y: 0)
    
    let barButtonContainer = UIView(frame: barButton.frame)
    barButtonContainer.addSubview(barButton)
    
    let item = UIBarButtonItem(customView: barButtonContainer)
    self.navigationItem.setRightBarButtonItems([item], animated: false)
  }
}

// MARK: - Alerts
extension UIViewController {
  func showAlertMessage(title: String?, message: String?, actions: [UIAlertAction]? = nil) {
    let alert = UIAlertController(title: title?.localized, message: message?.localized, preferredStyle: .alert)
    if let actions = actions {
      for action in actions {
        alert.addAction(action)
      }
    } else {
      alert.addAction(UIAlertAction(title: "Okay".localized, style: .cancel, handler: nil))
    }
    present(alert, animated: true)
  }
}
