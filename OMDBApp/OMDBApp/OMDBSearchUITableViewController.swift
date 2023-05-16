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
	
	var titles: [String] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Uncomment the following line to preserve selection between presentations
		// self.clearsSelectionOnViewWillAppear = false
		
		// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
		// self.navigationItem.rightBarButtonItem = self.editButtonItem
		
		// Init views
		tableView.dataSource = self
		tableView.delegate = self
		
		Task {
			await self.fetchSetMovies()
		}
	}
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.titles.count
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		Task {
			await self.fetchSetMovies(searchBar.text)
		}
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
		cell.textLabel?.text = self.titles[indexPath.row]
		return cell
	}
	
	func fetchSetMovies(_ search: String? = nil) async -> Void {
		var movies: [Movie]
		
		// Load from DB
		movies = MovieModel.listFromDB(search)
		
		// If no movies are found
		if (movies.isEmpty) {
			print("[DEBUG] No movies in DB match the search, attempting to load from Web")
			// Load from Web
			movies = await MovieModel.listFromWeb(search)
		}
		
		self.titles = []
		if (movies.isEmpty) {
			self.titles.append("No movies found")
		} else {
			movies.forEach { movie in
				self.titles.append(movie.title!)
			}
		}
		
		// Reload the table view
		self.tableView.reloadData()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if (segue.identifier == "segueToMovie") {
			if let destination = segue.destination as? MovieViewController {
				if let indexPath = tableView.indexPathForSelectedRow {
					let selected = titles[indexPath.row]
					destination.title = selected
				}
			}
		}
	}
}
