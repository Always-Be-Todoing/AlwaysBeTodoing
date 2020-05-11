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

    navigationController?.navigationBar.prefersLargeTitles = false

    NotificationCenter.default.addObserver(self,
                                           selector: #selector(todoItemDescriptionFinishedEditing),
                                           name: UITextField.textDidEndEditingNotification,
                                           object: nil)
  }

  // MARK: Selectors
  @objc func todoItemDescriptionFinishedEditing() {
    self.isEditing = false
  }
}

extension TodoListViewController: UITableViewDelegate {
//  func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
//    return false
//  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
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
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath) as? TodoListTableViewCell
    else {
      fatalError()
    }

    cell.delegate = self

    let todoItemDescription = todoItems[indexPath.row].description
    cell.todoItemTextField.text = todoItemDescription
    cell.todoItemLabel.text = todoItemDescription

    // TODO: Refactor this to use a ternary operator or some such
    if todoItemDescription.isEmpty {
      cell.todoItemTextField.isHidden = false
      cell.todoItemLabel.isHidden = true
    } else {
      cell.todoItemTextField.isHidden = true
      cell.todoItemLabel.isHidden = false
    }

    return cell
  }
}

// MARK: TodoItemTableViewCellDelegate
extension TodoListViewController: TodoItemTableViewCellDelegate {
  func descriptionSetForTodoItem(sender: TodoListTableViewCell,
                                 description: String) {
    guard let todoItemDescription = sender.todoItemLabel.text else { return }
    guard let index = tableView.indexPath(for: sender)?.row else { return }

    todoItems[index].description = todoItemDescription
  }
}

protocol TodoListViewControllerDelegate: AnyObject {
  func didUpdateTodoItems(sender: TodoListViewController, items: [TodoItem])
}


// MARK: Potential TableView Delegate Methods to add
/*
 // Override to support conditional editing of the table view.
 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the specified item to be editable.
 return true
 }
 */

/*
 // Override to support editing the table view.
 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
 if editingStyle == .delete {
 // Delete the row from the data source
 tableView.deleteRows(at: [indexPath], with: .fade)
 } else if editingStyle == .insert {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

 }
 */

/*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */
