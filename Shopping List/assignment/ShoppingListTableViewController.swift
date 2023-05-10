//
//  ShoppingListTableViewController.swift
//  assignment
//
//  Created by Felix Schindler on 26.04.23.
//

import UIKit

class ShoppingListTableViewController: UITableViewController, UISearchBarDelegate {
	
	// Needs to be set when navigating here
	var shop: String = ""
	
	// All items
	var allItems: [String] = []
	// Items that match the current search
	var items: [String] = []
	
	@IBOutlet weak var search: UISearchBar!
	
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
		
		search.delegate = self
	}
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		print("[DEBUG] Searching for '\(searchText)'")
		
		if (searchText.isEmpty) {
			// Search is empty -> reset to all items
			items = allItems.sorted()
		} else {
			// Filter for items containing the searchText
			items = allItems.filter({ (name: String) -> Bool in
				return name.localizedStandardContains(searchText.lowercased())
			}).sorted()
		}

		// Reload view data
		tableView.reloadData()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		// Load everything from persistens
		ShoppingList.shared.load()
		
		// Get items of the shopping list
		allItems = ShoppingList.shared.lists[shop] ?? []
		items = allItems
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
	
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if (editingStyle == .delete) {
			let item = items[indexPath.row]
			print("[DEBUG] Deleting '\(item)' in '\(shop)'")
			ShoppingList.shared.delete(shop: shop, item: item)
			items = ShoppingList.shared.lists[shop]!
		}
		self.tableView.reloadData()
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
