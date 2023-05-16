//
//  MovieModel.swift
//  OMDBApp
//
//  Created by Felix Schindler on 16.05.23.
//

import Foundation
import CoreData

class MovieModel {
	/// OMDB API key
	public static let API_KEY = "92da8288"
	
	public static func singleFromDb(_ title: String) -> Movie? {
		print("[DEBUG] Loading single movie '\(title)'")
		
		// variable to store the found Movie objects
		var foundMovie: Movie? = nil
		
		// we want to retrieve all Movie entities from the database
		let request = NSFetchRequest<NSFetchRequestResult>( entityName: "Movie")
		
		// using predicates we can further define what property values
		// the movies should have. This is similar to SQL select statements
		request.predicate = NSPredicate(format: "title ==[cd] %@", title)
		
		do {
			let results = try PersistenceManager.shared.context.fetch(request)
			foundMovie = results.first as? Movie
		} catch {
			print("[ERROR] Failed to load movies from the DB")
			print(error)
		}
		
		return foundMovie
	}
	
	public static func listFromDB(_ search: String? = nil) -> [Movie] {
		let search = search ?? "star"
		print("[DEBUG] Searching offline for '\(search)'")
		
		// variable to store the found Movie objects
		var foundMovies: [Movie] = []
		
		// we want to retrieve all Movie entities from the database
		let request = NSFetchRequest<NSFetchRequestResult>( entityName: "Movie")
		
		// using predicates we can further define what property values
		// the movies should have. This is similar to SQL select statements
		request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", search)
		
		do {
			let results = try PersistenceManager.shared.context.fetch(request)
			foundMovies += results as! [Movie]
		} catch {
			print("[ERROR] Failed to load movies from the DB")
			print(error)
		}
		
		return foundMovies
	}
	
	public static func listFromWeb(_ search: String? = nil) async -> [Movie] {
		let search: String = (search ?? "star")
		let urlString = "https://www.omdbapi.com/?apikey=\(self.API_KEY)&s=\(search.url)"
		var foundMovies: [Movie] = []
		
		print("[DEBUG] Searching online for '\(search)'")
		
		guard let url = URL(string: urlString) else {
			return foundMovies
		}
		
		do {
			let (data, _) = try await URLSession.shared.data(from: url)
			
			guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
				print("[ERROR] Failed to decode JSON", url.absoluteString)
				return foundMovies
			}
			
			guard let moviesJSON = json["Search"] as? [[String: Any]] else {
				print("[ERROR] There's no 'Search' key in JSON response", url.absoluteString)
				return foundMovies
			}
			
			print("[DEBUG] Creating movie objects")
			foundMovies = moviesJSON.compactMap { movieJSON in
				let movie = Movie(context: PersistenceManager.shared.context)
				movie.title = movieJSON["Title"] as? String ?? ""
				movie.year = movieJSON["Year"] as? String ?? ""
				movie.imdbID = movieJSON["imdbID"] as? String ?? ""
				movie.type = movieJSON["Type"] as? String ?? ""
				movie.poster = URL(string: movieJSON["Poster"] as? String ?? "")
				
				return movie
			}
			
			// Save in DB
			self.saveMovies(foundMovies)
		} catch {
			print("[ERROR] Welp... I dunno tbh... Something went wrong!")
			print(error)
		}
		
		return foundMovies
	}
	
	private static func saveMovies(_ movies: [Movie]) {
		let context = PersistenceManager.shared.context
		
		movies.forEach { movie in
			context.insert(movie)
		}
		
		PersistenceManager.shared.saveContext()
		print("[DEBUG] Movies saved in DB")
	}
}
