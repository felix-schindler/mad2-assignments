//
//  OMDBSearchUITableViewController.swift
//  OMDBApp
//
//  Created by Felix Schindler on 09.05.23.
//

import UIKit

struct APIAnswer: Decodable {
	let Search: [Movie]
}

struct Movie: Decodable {
	let Poster: URL
	let ImdbID: String
	let Title: String
	let `Type`: String
	let Year: String
}

extension String {
	var url: String {
		return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
	}
}

class OMDBSearchUITableViewController: UITableViewController, UISearchBarDelegate {
	
	let API_KEY = "92da8288"
	var titles: [String] = []
	var allMovies: [Movie] = []
	
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
		return self.titles.count
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		self.getSetMovies(searchBar.text)
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
		cell.textLabel?.text = self.titles[indexPath.row]
		return cell
	}
	
	private func getSetMovies(_ search: String? = nil) -> Void {
		let url = "https://www.omdbapi.com?apikey=\(API_KEY)&s=\(search?.url ?? "star")"
		
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
				
				do {
					let decoder = JSONDecoder()
					let result = try decoder.decode(APIAnswer.self, from: data)
					self.allMovies = result.Search
					
					for movie in self.allMovies {
						self.titles.append(movie.Title)
					}
					
					DispatchQueue.main.async {
						// Reload the table view
						self.tableView.reloadData()
					}
				} catch {
					print("[ERROR] Failed to decode JSON")
				}
			}.resume()
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if (segue.identifier == "segueToMovie") {
			if let destination = segue.destination as? MovieViewController {
				if let indexPath = tableView.indexPathForSelectedRow {
					let selected = allMovies[indexPath.row]
					destination.movie = selected
				}
			}
		}
	}
}
