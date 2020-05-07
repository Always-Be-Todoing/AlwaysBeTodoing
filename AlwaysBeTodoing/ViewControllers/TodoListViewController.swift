//
//  TodoListViewController.swift
//  AlwaysBeTodoing
//
//  Created by Jeremy Fleshman on 5/3/20.
//  Copyright © 2020 Jeremy Fleshman. All rights reserved.
//

import UIKit

class TodoListViewController: UIViewController {
  // MARK: Properties
  @IBOutlet weak var tableView: UITableView!

  weak var delegate: TodoListViewControllerDelegate?

  // MARK: DataSource
  var todoItems: [TodoItem] = []
  
  // MARK: - Actions
  @IBAction func addTodoItem(_ sender: Any) {
    if self.isEditing == false {
      let todoItem = TodoItem()
      todoItems.append(todoItem)
      tableView.reloadData()
      self.isEditing = true
    }
  }

  // MARK: Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.dataSource = self
    tableView.delegate = self
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    // FIXME: Should this respond to only a TodoListTableViewCell notification?
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(todoItemDescriptionFinishedEditing),
                                           name: UITextField.textDidEndEditingNotification,
                                           object: nil)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super .viewWillDisappear(animated)

    NotificationCenter.default.removeObserver(self)
  }

  @objc func todoItemDescriptionFinishedEditing() {
    self.isEditing = false
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
    return todoItems.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell",
                                             for: indexPath) as! TodoItemTableViewCell

    // TODO: Replace this with a custom Checklist item cell
      // how should this look?
//    cell.todoItemTextField.text = items[indexPath.row].description
    cell.todoItemLabel.text = todoItems[indexPath.row].description

    return cell
  }
  
}

protocol TodoListViewControllerDelegate: AnyObject {
  func didUpdateTodoItems(sender: TodoListViewController, items: [TodoItem])
}
