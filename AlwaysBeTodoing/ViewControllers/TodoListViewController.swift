//
//  TodoListViewController.swift
//  AlwaysBeTodoing
//
//  Created by Jeremy Fleshman on 5/3/20.
//  Copyright © 2020 Jeremy Fleshman. All rights reserved.
//

import UIKit

struct UIImageKeys {
  static let square = "square"
  static let checkmarkSquare = "checkmark.square"
}

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
      let lastIndexPath = IndexPath(row: todoItems.count - 1, section: 0)
      tableView.insertRows(at: [lastIndexPath], with: .automatic)
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
    let currentIndexPath = IndexPath(row: todoItems.count - 1, section: 0)
    let currentCell = tableView.cellForRow(at: currentIndexPath) as? TodoListTableViewCell
    if currentCell?.todoItemTextField.text?.isEmpty == false {
      self.isEditing = false
    }
  }
}

// MARK: UITableViewDelegate
extension TodoListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    toggleTodoItemCheckedState(tableView, indexPath)

    tableView.deselectRow(at: indexPath, animated: true)
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 44.0
  }
}

// MARK: UITableViewDataSource
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

    configureCell(indexPath, cell)

    return cell
  }

  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      deleteItem(indexPath, tableView)
    } else if editingStyle == .insert {
      // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
  }
}

// MARK: File-private Extractions
extension TodoListViewController {
  fileprivate func configureCell(_ indexPath: IndexPath, _ cell: TodoListTableViewCell) {
    let todoItem = todoItems[indexPath.row]
    setInitialCellValuesPerModel(todoItem, cell)
    setCheckmarkState(todoItem, cell)
    setCellUIVisibility(todoItem, cell)
    setFirstResponderConditionally(indexPath, cell)
  }

  fileprivate func setInitialCellValuesPerModel(_ todoItem: TodoItem, _ cell: TodoListTableViewCell) {
    let todoItemDescription = todoItem.description
    cell.todoItemTextField.text = todoItemDescription
    cell.todoItemLabel.text = todoItemDescription
  }

  fileprivate func setCheckmarkState(_ todoItem: TodoItem, _ cell: TodoListTableViewCell) {
    let isTodoItemChecked = todoItem.checked
    let todoItemCheckedImage = isTodoItemChecked ? "checkmark.square" : "square"
    cell.todoItemCheckbox.image = UIImage(systemName: todoItemCheckedImage)
  }

  fileprivate func setCellUIVisibility(_ todoItem: TodoItem, _ cell: TodoListTableViewCell) {
    let todoItemDescription = todoItem.description
    // TODO: Refactor this to use a ternary operator or similar
    if todoItemDescription.isEmpty {
      cell.todoItemTextField.isHidden = false
      cell.todoItemLabel.isHidden = true
    } else {
      cell.todoItemTextField.isHidden = true
      cell.todoItemLabel.isHidden = false
    }
  }

  fileprivate func setFirstResponderConditionally(_ indexPath: IndexPath, _ cell: TodoListTableViewCell) {
    if todoItems[indexPath.row].description.isEmpty {
      cell.todoItemTextField.becomeFirstResponder()
    }
  }

  fileprivate func toggleTodoItemCheckedState(_ tableView: UITableView, _ indexPath: IndexPath) {
    // TODO: Implement checking the item in UI,
    // TODO: update the model,
    // TODO: and fading the cell label

    let todoItem = todoItems[indexPath.row]

    // TODO: Refactor this
    self.todoItems[indexPath.row].checked = !(todoItem.checked)

    if let cell = tableView.cellForRow(at: indexPath) as? TodoListTableViewCell {
      if self.todoItems[indexPath.row].checked {
        cell.todoItemCheckbox.image = UIImage(systemName: UIImageKeys.checkmarkSquare)
      } else {
        cell.todoItemCheckbox.image = UIImage(systemName: UIImageKeys.square)
      }
    }

    self.delegate?.didUpdateTodoItems(sender: self, items: todoItems)
  }

  fileprivate func deleteItem(_ indexPath: IndexPath, _ tableView: UITableView) {
    print("Item deleted")
    todoItems.remove(at: indexPath.row)
    self.delegate?.didUpdateTodoItems(sender: self, items: todoItems)
    tableView.deleteRows(at: [indexPath], with: .fade)
    self.isEditing = false
  }
}


// MARK: TodoItemTableViewCellDelegate
extension TodoListViewController: TodoItemTableViewCellDelegate {
  func descriptionSetForTodoItem(sender: TodoListTableViewCell,
                                 description: String) {
    guard let todoItemDescription = sender.todoItemLabel.text else { return }
    guard let index = tableView.indexPath(for: sender)?.row else { return }

    todoItems[index].description = todoItemDescription
    self.delegate?.didUpdateTodoItems(sender: self, items: todoItems)
    addTodoItem(self)
  }

  func didTapRemoveButton(sender: TodoListTableViewCell) {
    guard let indexPath = tableView.indexPath(for: sender) else { return }
    deleteItem(indexPath, self.tableView)
  }
}

// MARK: TodoListViewControllerDelegate
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
