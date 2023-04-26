//
//  ShoppingListTableViewController.swift
//  assignment
//
//  Created by Felix Schindler on 26.04.23.
//

import UIKit

class ShoppingListTableViewController: UITableViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Uncomment the following line to preserve selection between presentations
		// self.clearsSelectionOnViewWillAppear = false
		
		// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
		// self.navigationItem.rightBarButtonItem = self.editButtonItem
		
		
		// Set the data source of the table view to be this view controller
		tableView.dataSource = self
	}
	
	override func viewDidAppear(_ animated: Bool) {
		// Load shopping list from persistence
		ShoppingList.shared.load()
		
		// Reload table
		tableView.reloadData()
		print("[DEBUG] tableView data reloaded")
	}
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		// return items.count
		return ShoppingList.shared.list.count
	}
	
	/// Configure the cell
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		// Dequeue a cell and set its text label to the appropriate item from the data source
		let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
		// cell.textLabel?.text = items[indexPath.row]
		cell.textLabel?.text = ShoppingList.shared.list[indexPath.row]
		return cell
	}
}
