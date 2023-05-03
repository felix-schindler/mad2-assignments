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

struct MyDrink {
	let name: String
	let ingredients: [String]
}


class CocktailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
	
	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	var allDrinks: Dictionary<String, MyDrink> = [:]
	var filteredDrinkNames: [String] = []
	
	let apiUrl = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f="
	let shoppingListKey = "shoppingList"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Set up table view
		tableView.dataSource = self
		tableView.delegate = self
		// tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
		
		// Set up search bar
		searchBar.delegate = self
	}
	
	override func viewDidAppear(_ animated: Bool) {
		searchBar(self.searchBar, textDidChange: "A")
	}
	
	// MARK: - Search
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		guard let firstLetter = searchText.first else { return }
		
		let urlString = apiUrl + String(firstLetter)
		guard let url = URL(string: urlString) else { return }
		// Show the activity indicator
		activityIndicator.startAnimating()
		// Fetch the data from the API
		URLSession.shared.dataTask(with: url) { data, response, error in
			print("[DEBUG] Searching for drinks starting with the letter '\(firstLetter)'")

			guard let data = data else {
				print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
				return
			}
			
			do {
				let decoder = JSONDecoder()
				let result = try decoder.decode(DrinkList.self, from: data)
				// Parse the data and store it in foundDrinks
				
				for drink in result.drinks {
					// Set ingredient array for drinks
					self.allDrinks[drink.strDrink] = MyDrink(name: drink.strDrink, ingredients: [
						drink.strIngredient1, drink.strIngredient2, drink.strIngredient3, drink.strIngredient4, drink.strIngredient5, drink.strIngredient6, drink.strIngredient7, drink.strIngredient8, drink.strIngredient9, drink.strIngredient10, drink.strIngredient11, drink.strIngredient12, drink.strIngredient13, drink.strIngredient14, drink.strIngredient15
					].compactMap({ $0 }))
				}
				
				self.filteredDrinkNames = self.allDrinks.keys.filter {
					$0.contains(searchText)
				}

				DispatchQueue.main.async {
					// Reload the table view
					self.tableView.reloadData()
					// Hide the activity indicator
					self.activityIndicator.stopAnimating()
					
					print("[DEBUG] Coctails (re)loaded")
				}
			} catch {
				print("[ERROR] decoding data: \(error.localizedDescription)")
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
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		// Get the new view controller using segue.destination.
		// Pass the selected object to the new view controller.
		
		if let destination = segue.destination as? CocktailDetails {
			if segue.identifier == "segueToCocktail" {
				if let indexPath = tableView.indexPathForSelectedRow {
					let selectedItem = filteredDrinkNames[indexPath.row]
					destination.cocktail = allDrinks[selectedItem]!
				}
			}
		}
	}
	
}
