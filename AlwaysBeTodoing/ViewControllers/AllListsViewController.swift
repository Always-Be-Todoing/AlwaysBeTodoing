//
//  AllListsViewController.swift
//  AlwaysBeTodoing
//
//  Created by Jeremy Fleshman on 5/4/20.
//  Copyright © 2020 Jeremy Fleshman. All rights reserved.
//

import UIKit

struct Keys {
  static let todoLists: String = "todoLists"
}

class AllListsViewController: UIViewController {
  // MARK: - Properties
  @IBOutlet weak var addChecklist: UIBarButtonItem!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var editBarButtonItem: UIBarButtonItem!

  // MARK: - DataSource
  var todoLists: [TodoList] = []

  // MARK: - Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()

    todoLists = loadTodoLists()!

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
      let todoListVC = segue.destination as! TodoListViewController
      todoListVC.todoItems = todoLists[selectedRow].items
      todoListVC.delegate = self
      segue.destination.title = todoLists[selectedRow].title
    }
  }
}

// MARK: - Save/Load NSUserDefaults (Temporary)
extension AllListsViewController {
  func saveTodoLists() {
    // TODO: Replace use of NSDefaults for temp persistent storage
    // TODO: Refactor to use a Storage Protocol to extract the storage implementation
    let defaults = UserDefaults.standard

    defaults.set(try? PropertyListEncoder().encode(todoLists),
                 forKey: Keys.todoLists)
  }

  func loadTodoLists() -> [TodoList]? {
    let defaults = UserDefaults.standard
    guard let todoListsData = defaults.data(forKey: Keys.todoLists) else { return [TodoList]() }
    guard let todoListArray = try? PropertyListDecoder().decode([TodoList].self, from: todoListsData) else { return [TodoList]() }
    return todoListArray
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

  // Override to support editing the table view.
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      // Delete the row from the data source
      todoLists.remove(at: indexPath.row)
      saveTodoLists()
      tableView.deleteRows(at: [indexPath], with: .fade)
    } else if editingStyle == .insert {
      // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
  }
}

// MARK: - TodoListTableViewCellDelegate
extension AllListsViewController: TodoListTableViewCellDelegate {
  func titleSetForTodoList(sender: AllListsTableViewCell, title: String) {
    guard let todoListTitle = sender.todoListLabel.text else { return }
    guard let index = tableView.indexPath(for: sender)?.row else { return }

    todoLists[index].title = todoListTitle
    saveTodoLists()
  }
}

// MARK: TodoListViewControllerDelegate
extension AllListsViewController: TodoListViewControllerDelegate {
  func didUpdateTodoItems(sender: TodoListViewController, items: [TodoItem]) {
    // FIXME: Is there a better way to get the cell?
    guard let row = tableView.indexPathForSelectedRow?.row else { return }
    todoLists[row].items = items
    saveTodoLists()
  }
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
