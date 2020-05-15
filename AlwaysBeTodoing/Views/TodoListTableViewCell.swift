//
//  TodoListTableViewCell.swift
//  AlwaysBeTodoing
//
//  Created by Jeremy Fleshman on 5/4/20.
//  Copyright © 2020 Jeremy Fleshman. All rights reserved.
//

import UIKit

class TodoListTableViewCell: UITableViewCell {
  // MARK: Properties
  @IBOutlet weak var todoItemTextField: UITextField!
  @IBOutlet weak var todoItemLabel: UILabel!
  @IBOutlet weak var todoItemCheckbox: UIImageView!

  weak var delegate: TodoItemTableViewCellDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()

    configureCell()
  }

  func configureCell() {
    todoItemTextField.delegate = self
    todoItemCheckbox.isUserInteractionEnabled = true
  }
}

// MARK: UITextFieldDelegate
extension TodoListTableViewCell: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()

    textField.isHidden = true
    todoItemLabel.text = textField.text
    todoItemLabel.isHidden = false

    if let todoListTitle = textField.text {
      self.delegate?.descriptionSetForTodoItem(sender: self, description: todoListTitle)
    }

    return true
  }
}

// MARK: Delegate Methods
protocol TodoItemTableViewCellDelegate: AnyObject {
  func descriptionSetForTodoItem(sender: TodoListTableViewCell, description: String)
}
