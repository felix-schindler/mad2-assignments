//
//  ShopListViewController.swift
//  assignment
//
//  Created by Felix Schindler on 26.04.23.
//

import UIKit

class ShopListViewController: UITableViewController {
	
	var items: [String] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Uncomment the following line to preserve selection between presentations
		// self.clearsSelectionOnViewWillAppear = false
		
		// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
		// self.navigationItem.rightBarButtonItem = self.editButtonItem
		
		tableView.dataSource = self
		tableView.reloadData()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		// Load shops from persistence
		ShoppingList.shared.load()
		
		// Set items to the keys (list names)
		items = ShoppingList.shared.lists.keys.sorted()
		print("[DEBUG] Loaded list names - \(items)")
		
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
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
		cell.textLabel?.text = items[indexPath.row]
		return cell
	}
	
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if (editingStyle == .delete) {
			let shop = items[indexPath.row]
			print("[DEBUG] Deleting '\(shop)'")
			ShoppingList.shared.deleteShop(shop)
			items = ShoppingList.shared.lists.keys.sorted()
		}
		self.tableView.reloadData()
	}
	
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		// Get the new view controller using segue.destination.
		// Pass the selected object to the new view controller.
		
		if let destination = segue.destination as? ShoppingListTableViewController {
			if segue.identifier == "segueToShoppingList" {
				if let indexPath = tableView.indexPathForSelectedRow {
					let selectedItem = items[indexPath.row]
					destination.shop = selectedItem
				}
			}
		}
	}
	
}
