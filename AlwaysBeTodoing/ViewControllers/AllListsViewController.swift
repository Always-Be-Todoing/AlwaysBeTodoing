//
//  AllListsViewController.swift
//  AlwaysBeTodoing
//
//  Created by Jeremy Fleshman on 5/4/20.
//  Copyright © 2020 Jeremy Fleshman. All rights reserved.
//

import UIKit

class AllListsViewController: UIViewController {
  // MARK: - Properties
  @IBOutlet weak var addChecklist: UIBarButtonItem!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var editBarButtonItem: UIBarButtonItem!

  // MARK: - DataSource
//  var todoLists: [TodoList] = []
  var todoLists: [TodoList] = [
    TodoList("Shopping",
             items: [
               TodoItem("Ice cream", isChecked: false),
               TodoItem("Yogurt", isChecked: true),
               TodoItem("Apples", isChecked: true)
             ]
            ),
    TodoList("Exercising",
             items: []),
    TodoList("Coding",
             items: []),
  ]

  // MARK: - Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.dataSource = self
    tableView.delegate = self
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    navigationController?.navigationBar.prefersLargeTitles = true

    // FIXME: Should this respond to only a TodoListTableViewCell notification?
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(listTitleFinishedEditing),
                                           name: UITextField.textDidEndEditingNotification,
                                           object: nil)


    // TODO: Should this be moved to viewWillDisappear?
    //       Need to compare behavior with UITableViewController's cell highlight deselection
    // Manually deselects the list cell when returning to this view
    if let selectedIndexPath = tableView.indexPathForSelectedRow {
      tableView.deselectRow(at: selectedIndexPath, animated: animated)
    }
  }

  // MARK: - Actions
  @IBAction func addTodoList(_ sender: Any) {
    if self.isEditing == false {
      let list = TodoList()
      todoLists.append(list)
      tableView.reloadData()
      self.isEditing = true
    }
  }

  @objc func listTitleFinishedEditing() {
    self.isEditing = false
  }

  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let selectedRow = tableView.indexPathForSelectedRow?.row else { return }
    if (segue.identifier == "AllListsVCToTodoListVC") {
      // TODO: Does a delegate need to be set here to update the data model?
      let todoListVC = segue.destination as! TodoListViewController
      todoListVC.todoItems = todoLists[selectedRow].items
      segue.destination.title = todoLists[selectedRow].title
    }
  }
}

// MARK: - UITableViewDelegate
extension AllListsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // TODO: Implement
    // may not be needed as there is a segue in the SB prototype cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 44
  }
}

// MARK: - UITableViewDataSource
extension AllListsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return todoLists.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "todoListCell", for: indexPath) as? AllListsTableViewCell else {
        fatalError("The dequeued cell is not an instance of TodoListTableViewCell")
    }

    cell.delegate = self

    let todoListTitle = todoLists[indexPath.row].title
    cell.todoListTextField.text = todoListTitle
    cell.todoListLabel.text = todoListTitle

    // TODO: Refactor this using a compound ternary operator or some such
    if todoListTitle.isEmpty {
      cell.todoListTextField.isHidden = false
      cell.todoListLabel.isHidden = true
    } else {
      cell.todoListTextField.isHidden = true
      cell.todoListLabel.isHidden = false
    }
    return cell
  }
}

// MARK: - TodoListTableViewCellDelegate
extension AllListsViewController: TodoListTableViewCellDelegate {
  func titleSetForTodoList(sender: AllListsTableViewCell, title: String) {
    guard let todoListTitle = sender.todoListLabel.text else { return }
    guard let index = tableView.indexPath(for: sender)?.row else { return }

    todoLists[index].title = todoListTitle
  }
}

// MARK: TodoListViewControllerDelegate
extension AllListsViewController: TodoListViewControllerDelegate {
  func didUpdateTodoItems(sender: TodoListViewController, items: [TodoItem]) {
    // TODO: Implement
  }
}

