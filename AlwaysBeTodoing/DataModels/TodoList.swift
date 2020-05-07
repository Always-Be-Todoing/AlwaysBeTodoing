//
//  TodoList.swift
//  AlwaysBeTodoing
//
//  Created by Jeremy Fleshman on 5/6/20.
//  Copyright © 2020 Jeremy Fleshman. All rights reserved.
//

import Foundation

struct TodoList {
  // MARK: Properties
  var title: String
  var items: [TodoItem]

  // MARK: Initializers
  init(_ title: String = "", items: [TodoItem] = []) {
    self.title = title
    self.items = items
  }

  // MARK: Methods
}
