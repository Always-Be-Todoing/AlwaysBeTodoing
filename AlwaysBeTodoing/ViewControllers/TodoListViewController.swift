//
//  TodoListViewController.swift
//  AlwaysBeTodoing
//
//  Created by Jeremy Fleshman on 5/3/20.
//  Copyright © 2020 Jeremy Fleshman. All rights reserved.
//

import UIKit

class TodoListViewController: UIViewController {
  // MARK: Outlets
  @IBOutlet weak var tableView: UITableView!

  // MARK: DataSource (Temporary)
  var items: [String] = ["Study for Physics final", "Refresh FC Buffs", "Do yoga", "Eat yogurt"]

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.dataSource = self
    tableView.delegate = self
  }
}

extension TodoListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
    return false
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 44.0
  }
}

extension TodoListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell",
                                             for: indexPath) as! TodoItemTableViewCell

    // TODO: Replace this with a custom Checklist item cell
      // how should this look?
//    cell.todoItemTextField.text = items[indexPath.row].description
    cell.todoItemLabel.text = items[indexPath.row].description

    return cell
  }
  
}
