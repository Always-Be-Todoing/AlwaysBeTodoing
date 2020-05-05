//
//  ListCollectionViewController.swift
//  AlwaysBeTodoing
//
//  Created by Jeremy Fleshman on 5/4/20.
//  Copyright © 2020 Jeremy Fleshman. All rights reserved.
//

import UIKit

class ListCollectionViewController: UITableViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    // tableView delegates are auto-set since this subclasses UITableViewController
  }

  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // TODO: Implement prepare(for:sender:)
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
  }

  // MARK: UITableViewDataSource
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "todoListCell", for: indexPath)

    // TODO: Replace this with a custom list cell
    cell.textLabel?.text = "Checklist goes here"

    return cell
  }

}
