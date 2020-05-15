//
//  AllListsTableViewCell.swift
//  AlwaysBeTodoing
//
//  Created by Jeremy Fleshman on 5/6/20.
//  Copyright © 2020 Jeremy Fleshman. All rights reserved.
//

import UIKit

class AllListsTableViewCell: UITableViewCell {
  // MARK: Properties
  @IBOutlet weak var todoListTextField: UITextField!
  @IBOutlet weak var todoListLabel: UILabel!

  weak var delegate: TodoListTableViewCellDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()

    configureCell()
  }

  func configureCell() {
    todoListTextField.delegate = self
  }
}

// MARK: UITextFieldDelegate
extension AllListsTableViewCell: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    guard let _ = textField.text?.isEmpty else { return false }

    textField.resignFirstResponder()

    textField.isHidden = true
    todoListLabel.text = textField.text
    todoListLabel.isHidden = false

    if let todoListTitle = textField.text {
      self.delegate?.titleSetForTodoList(sender: self, title: todoListTitle)
    }

    return true
  }
}

// MARK: Delegate Methods
protocol TodoListTableViewCellDelegate: AnyObject {
  func titleSetForTodoList(sender: AllListsTableViewCell, title: String)
}
