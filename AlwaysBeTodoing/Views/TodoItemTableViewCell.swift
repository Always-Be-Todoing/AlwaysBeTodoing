//
//  TodoItemTableViewCell.swift
//  AlwaysBeTodoing
//
//  Created by Jeremy Fleshman on 5/4/20.
//  Copyright © 2020 Jeremy Fleshman. All rights reserved.
//

import UIKit

class TodoItemTableViewCell: UITableViewCell {
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
extension TodoItemTableViewCell: UITextFieldDelegate {
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    // TODO: Decide if/how edits should be conditionally blocked
    return true
  }

  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    // FIXME: can the nil-coalescing operator be refactored out?
    if textField.text?.isEmpty ?? false {
      return false
    }
    return true
  }

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
  func descriptionSetForTodoItem(sender: TodoItemTableViewCell, description: String)
}
