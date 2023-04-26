//
//  ShoppingListTableViewController.swift
//  assignment
//
//  Created by Felix Schindler on 26.04.23.
//

import UIKit

class ShoppingListTableViewController: UITableViewController {
	
	var shop: String = ""
	var items: [String] = []
	
	init(style: UITableView.Style, shop: String) {
		self.shop = shop
		super.init(style: style)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Uncomment the following line to preserve selection between presentations
		// self.clearsSelectionOnViewWillAppear = false
		
		// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
		// self.navigationItem.rightBarButtonItem = self.editButtonItem
		
		
		// Set the data source of the table view to be this view controller
		tableView.dataSource = self
		tableView.reloadData()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		// Load everything from persistens
		ShoppingList.shared.load()

		// Get items of the shopping list
		items = ShoppingList.shared.lists[shop] ?? []
		print("[DEBUG] Loaded items of list '\(shop)' - \(items)")
		
		// Reload table
		tableView.reloadData()
		print("[DEBUG] Reloaded data")
	}
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}
	
	/// Configure the cell
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
		cell.textLabel?.text = items[indexPath.row]
		return cell
	}
	
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		// Get the new view controller using segue.destination.
		// Pass the selected object to the new view controller.
		
		if let destination = segue.destination as? ViewController {
			if segue.identifier == "segueToNewItem" {
				destination.shop = shop
			}
		}
	}
	
}
