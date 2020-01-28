//
//  UIVIew+Extension.swift
//  BillListing_OleksandrSytnyk
//
//  Created by Oleksandr Sytnyk on 1/24/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//

import UIKit

extension UIView {
  func getRoundBorder() {
    self.layer.cornerRadius = self.frame.size.width/2
    self.layer.borderWidth = 1
    self.layer.borderColor = UIColor.black.cgColor
  }
}
