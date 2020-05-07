//
//  TodoListTableViewCell.swift
//  AlwaysBeTodoing
//
//  Created by Jeremy Fleshman on 5/6/20.
//  Copyright © 2020 Jeremy Fleshman. All rights reserved.
//

import UIKit

class TodoListTableViewCell: UITableViewCell {
  // MARK: Properties
  @IBOutlet weak var todoListTextField: UITextField!
  @IBOutlet weak var todoListLabel: UILabel!

  weak var delegate: TodoListTableViewCellDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()

    todoListTextField.delegate = self
    
    todoListLabel.isHidden = true
    todoListTextField.becomeFirstResponder()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
}

// MARK: UITextFieldDelegate
extension TodoListTableViewCell: UITextFieldDelegate {
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
  func titleSetForTodoList(sender: TodoListTableViewCell, title: String)
}
