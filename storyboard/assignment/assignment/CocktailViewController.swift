//
//  CocktailViewController.swift
//  assignment
//
//  Created by Felix Schindler on 27.04.23.
//

import UIKit

struct DrinkList: Decodable {
	let drinks: [Drink]
}

struct Drink: Decodable {
	let strDrink: String
	let strIngredient1: String?
	let strIngredient2: String?
	let strIngredient3: String?
	let strIngredient4: String?
	let strIngredient5: String?
	let strIngredient6: String?
	let strIngredient7: String?
	let strIngredient8: String?
	let strIngredient9: String?
	let strIngredient10: String?
	let strIngredient11: String?
	let strIngredient12: String?
	let strIngredient13: String?
	let strIngredient14: String?
	let strIngredient15: String?
}


class CocktailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
	
	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	var foundDrinks: Dictionary<String, [String]> = [:]
	var foundDrinkNames: [String] = []
	var filteredDrinkNames: [String] = []
	let apiUrl = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f="
	let shoppingListKey = "shoppingList"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Set up table view
		tableView.dataSource = self
		tableView.delegate = self
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
		
		// Set up search bar
		searchBar.delegate = self
	}
	
	override func viewDidAppear(_ animated: Bool) {
	}
	
	// MARK: - Search
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		guard let firstLetter = searchText.first else { return }
		print("[DEBUG] Searching drinks starting with the letter '\(firstLetter)'")

		let urlString = apiUrl + String(firstLetter)
		guard let url = URL(string: urlString) else { return }
		// Show the activity indicator
		activityIndicator.startAnimating()
		// Fetch the data from the API
		URLSession.shared.dataTask(with: url) { data, response, error in
			guard let data = data else {
				print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
				return
			}
			do {
				let decoder = JSONDecoder()
				let result = try decoder.decode(DrinkList.self, from: data)
				// Parse the data and store it in foundDrinks
				self.foundDrinks.removeAll()
				for drink in result.drinks {
					let name = drink.strDrink
					var ingredientArray: [String] = []
					if (drink.strIngredient1 != nil) {
						ingredientArray.append(drink.strIngredient1!)
					}
					if (drink.strIngredient2 != nil) {
						ingredientArray.append(drink.strIngredient2!)
					}
					if (drink.strIngredient3 != nil) {
						ingredientArray.append(drink.strIngredient3!)
					}
					if (drink.strIngredient4 != nil) {
						ingredientArray.append(drink.strIngredient4!)
					}
					if (drink.strIngredient5 != nil) {
						ingredientArray.append(drink.strIngredient5!)
					}
					if (drink.strIngredient6 != nil) {
						ingredientArray.append(drink.strIngredient6!)
					}
					if (drink.strIngredient7 != nil) {
						ingredientArray.append(drink.strIngredient7!)
					}
					if (drink.strIngredient8 != nil) {
						ingredientArray.append(drink.strIngredient8!)
					}
					if (drink.strIngredient9 != nil) {
						ingredientArray.append(drink.strIngredient9!)
					}
					if (drink.strIngredient10 != nil) {
						ingredientArray.append(drink.strIngredient10!)
					}
					if (drink.strIngredient11 != nil) {
						ingredientArray.append(drink.strIngredient11!)
					}
					if (drink.strIngredient12 != nil) {
						ingredientArray.append(drink.strIngredient12!)
					}
					if (drink.strIngredient13 != nil) {
						ingredientArray.append(drink.strIngredient13!)
					}
					if (drink.strIngredient14 != nil) {
						ingredientArray.append(drink.strIngredient14!)
					}
					if (drink.strIngredient15 != nil) {
						ingredientArray.append(drink.strIngredient15!)
					}

					self.foundDrinks[name] = ingredientArray
				}
				self.foundDrinkNames = Array(self.foundDrinks.keys).sorted()
				self.filteredDrinkNames = self.foundDrinkNames
				DispatchQueue.main.async {
					// Reload the table view
					self.tableView.reloadData()
					// Hide the activity indicator
					self.activityIndicator.stopAnimating()
				}
			} catch {
				print("Error decoding data: \(error.localizedDescription)")
			}
		}.resume()
	}
	
	// MARK: - Table view data source
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return filteredDrinkNames.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
		cell.textLabel?.text = filteredDrinkNames[indexPath.row]
		return cell
	}
	
	// MARK: - Table view delegate
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let selectedDrinkName = filteredDrinkNames[indexPath.row]
		if let selectedDrinkIngredients = foundDrinks[selectedDrinkName] {
			let defaults = UserDefaults.standard
			defaults.set(selectedDrinkName, forKey: shoppingListKey)
			defaults.set(selectedDrinkIngredients, forKey: selectedDrinkName)
		}
		tableView.deselectRow(at: indexPath, animated: true)
		navigationController?.popViewController(animated: true)
	}
}
