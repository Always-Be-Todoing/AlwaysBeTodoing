//
//  ListCollectionViewController.swift
//  AlwaysBeTodoing
//
//  Created by Jeremy Fleshman on 5/4/20.
//  Copyright © 2020 Jeremy Fleshman. All rights reserved.
//

import UIKit

class ListCollectionViewController: UIViewController {
  // MARK: - Properties
  @IBOutlet weak var addChecklist: UIBarButtonItem!
  @IBOutlet weak var listCollection: UITableView!
  @IBOutlet weak var editBarButtonItem: UIBarButtonItem!

  // MARK: - Lifecycle Methods
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    // FIXME: Should this respond to only a TodoListTableViewCell notification?
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(listTitleFinishedEditing),
                                           name: UITextField.textDidEndEditingNotification,
                                           object: nil)


    // TODO: Should this be moved to viewWillDisappear?
    //       Need to compare behavior with UITableViewController's cell highlight deselection
    // Manually deselects the list cell when returning to this view
    if let selectedIndexPath = listCollection.indexPathForSelectedRow {
      listCollection.deselectRow(at: selectedIndexPath, animated: animated)
    }
  }

  // MARK: - Actions
  @IBAction func addNewList(_ sender: Any) {
    if self.isEditing == false {
      let list = TodoList()
      todoLists.append(list)
      listCollection.reloadData()
      self.isEditing = true
    }
  }

  @objc func listTitleFinishedEditing() {
    self.isEditing = false
  }

  // MARK: - DataSource
  var todoLists: [TodoList] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    listCollection.dataSource = self
    listCollection.delegate = self
  }

  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // TODO: Implement prepare(for:sender:)
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.

    // Need to prepare the TodoListVC with the proper "Checklist"
  }
}

// MARK: - UITableViewDelegate
extension ListCollectionViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // TODO: Implement
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 44
  }
}

// MARK: - UITableViewDataSource
extension ListCollectionViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return todoLists.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "todoListCell",
                                             for: indexPath) as! TodoListTableViewCell

    cell.todoListTextField.text = todoLists[indexPath.row].title

    return cell
  }

}
