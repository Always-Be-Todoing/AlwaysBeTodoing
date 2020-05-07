//
//  TodoItem.swift
//  AlwaysBeTodoing
//
//  Created by Jeremy Fleshman on 5/6/20.
//  Copyright © 2020 Jeremy Fleshman. All rights reserved.
//

import Foundation

struct TodoItem {
  // MARK: Properties
  var description: String
  var checked: Bool

  // MARK: Initializers
  init(_ description: String, isChecked: Bool = false) {
    self.description = description
    self.checked = isChecked
  }

  // MARK: Methods
  // TODO: add a toggle checkmark option
}
