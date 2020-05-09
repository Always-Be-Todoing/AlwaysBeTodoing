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

  weak var delegate: TodoItemTableViewCellDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()

    todoItemTextField.delegate = self
    
    todoItemLabel.isHidden = true
    todoItemTextField.becomeFirstResponder()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
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
