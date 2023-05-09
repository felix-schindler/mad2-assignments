//
//  OMDBSearchUITableViewController.swift
//  OMDBApp
//
//  Created by Felix Schindler on 09.05.23.
//

import UIKit

extension String {
	var url: String {
		return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
	}
}

class OMDBSearchUITableViewController: UITableViewController, UISearchBarDelegate {
	
	let API_KEY = "92da8288"
	var items: [String] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Uncomment the following line to preserve selection between presentations
		// self.clearsSelectionOnViewWillAppear = false
		
		// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
		// self.navigationItem.rightBarButtonItem = self.editButtonItem
		
		// Init views
		tableView.dataSource = self
		tableView.delegate = self
		
		self.getSetMovies()
	}
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		self.getSetMovies(searchBar.text)
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
		cell.textLabel?.text = items[indexPath.row]
		return cell
	}
	
	private func getSetMovies(_ search: String? = nil) -> Void {
		let url = "https://www.omdbapi.com?apikey=\(API_KEY)&s=\(search?.url ?? "start")"
		
		if let url = URL(string: url) {
			print("GET \(url.absoluteString)")
			URLSession.shared.dataTask(with: url) { data, response, error in
				if let error = error {
					print("[ERROR] \(error.localizedDescription)")
					return
				}
				
				guard let data = data else {
					print("[ERROR] No data returned")
					return
				}
				
				if let json = try? JSONSerialization.jsonObject(with: data, options: []),
					 let dict = json as? [String: Any],
					 let searchResults = dict["Search"] as? [[String: Any]] {
					
					var titles: [String] = []
					
					for result in searchResults {
						if let title = result["Title"] as? String {
							titles.append(title)
						}
					}
					
					self.items = titles
					
					DispatchQueue.main.async {
						// Reload the table view
						self.tableView.reloadData()
					}
				}
			}.resume()
		}
	}
}
