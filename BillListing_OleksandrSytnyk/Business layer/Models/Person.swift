//
//  Person.swift
//  BillListing_OleksandrSytnyk
//
//  Created by Oleksandr Sytnyk on 1/24/20.
//  Copyright © 2020 Oleksandr Sytnyk. All rights reserved.
//

import Foundation

class Person {
  enum Gender {
    case male
    case female
  }
  
  var id = ""
  var name = ""
  var gender: Gender
  var address = ""
  
  init(name: String, gender: Gender) {
    self.name = name
    self.gender = gender
    self.id = UUID().uuidString
  }
}
