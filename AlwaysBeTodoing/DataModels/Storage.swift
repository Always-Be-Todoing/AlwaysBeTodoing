//
//  Storage.swift
//  AlwaysBeTodoing
//
//  Created by Jeremy Fleshman on 5/12/20.
//  Copyright © 2020 Jeremy Fleshman. All rights reserved.
//

import Foundation

/**
 - This will end up being  an abstract interface to the database
 - Will enable a trade-out once the other implementation is ready

 # Todo
 - Define protocol for CRUD operations
   - Need to support saving both a Todo List and Todo Items
      - Should this model be flattened or nested?
        - CAN it even be flattened?
 */

protocol storageDelegate {
  // Save item
  func saveItemInStorage()
  // Remove item
  func removeItemFromStorage()
  // Reorder item -- (have to have ordered storage to keep tableView ordering in sync)
  func reorderItemInStorage()
  // Update Item
  func updateItemInStorage()
}

struct Storage {
  // TODO Implement CRUD Operations
    // should this have a single method to support both TodoLists and TodoItems?
      // depends what the storage model ends up looking like
      // It may just end up saving the TodoList object as a whole
        // Need a way to handle a nested data model in storage
}
