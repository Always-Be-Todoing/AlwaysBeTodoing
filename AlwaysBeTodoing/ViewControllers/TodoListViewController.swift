//
//  TodoListViewController.swift
//  AlwaysBeTodoing
//
//  Created by Jeremy Fleshman on 5/3/20.
//  Copyright © 2020 Jeremy Fleshman. All rights reserved.
//

import UIKit

// TODO: Add swift doc for this class
/*
 */
class TodoListViewController: UIViewController {
  // MARK: Outlets
  @IBOutlet weak var tableView: UITableView!

  // MARK: DataSource (Move this)
  var items: [String] = ["Study for Physics final", "Refresh FC Buffs", "Do yoga", "Eat yogurt"]

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.dataSource = self
    tableView.delegate = self
  }
}

extension TodoListViewController: UITableViewDelegate {
  // TODO: What delegates need to be added?
  // TODO: Edit RowHeight?
  // TODO: Custom nib cell?
    // Should this be made with a nib or storyboard prototype cell?
      // Should prototype cell be replaced?
        // What are its specific uses?
  // TODO: disable selection highlighting for tableviewcell
}

extension TodoListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

    // TODO: Replace this with a custom Checklist item cell
      // how should this look?
    cell.textLabel?.text = items[indexPath.row].description

    return cell
  }
}
