//
//  CocktailDetails.swift
//  Shopping List
//
//  Created by Felix Schindler on 03.05.23.
//

import UIKit

class CocktailDetails: UITableViewController {
	
	var cocktail: MyDrink = MyDrink(name: "None selected", ingredients: [])
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationController?.title = cocktail.name
		
		// Uncomment the following line to preserve selection between presentations
		// self.clearsSelectionOnViewWillAppear = false
		
		// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
		// self.navigationItem.rightBarButtonItem = self.editButtonItem
	}
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return cocktail.ingredients.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
		cell.textLabel?.text = cocktail.ingredients[indexPath.row]
		return cell
	}
	
	@IBAction func addIngredients(_ sender: Any) {
		ShoppingList.shared.add(shop: "Cocktails", items: cocktail.ingredients)
	}
	
}
