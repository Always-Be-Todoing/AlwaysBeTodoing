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
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    todoItemLabel.isHidden = true
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
}
