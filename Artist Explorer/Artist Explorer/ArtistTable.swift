//
//  ArtistTable.swift
//  Artist Explorer
//
//  Created by Felix Schindler on 16.05.23.
//

import UIKit

class ArtistTable: UITableViewController {
	
	var artists: [String] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()

		// Setup table view
		tableView.delegate = self
		tableView.dataSource = self

		// "Load" artists
		self.artists = ["BlackPink", "Stray Kids", "(G)I-DLE", "grandson (Musiker)", "NF (Rapper)"]
		
		// Reload tableView
		tableView.reloadData()
		print("[DEBUG] Artists loaded and displayed")
	}
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return artists.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
		cell.textLabel?.text = artists[indexPath.row]
		return cell
	}
	
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		// Get the new view controller using segue.destination.
		// Pass the selected object to the new view controller.
		
		if segue.identifier == "segueToArtist" {
			if let destination = segue.destination as? ArtistWiki {
				if let indexRow = tableView.indexPathForSelectedRow?.row {
					let selected = artists[indexRow]
					print("[DEBUG] Navigating to '\(selected)'")
					destination.artistName = selected
				}
			}
		}
	}
}
