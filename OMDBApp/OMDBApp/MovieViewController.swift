//
//  MovieViewController.swift
//  OMDBApp
//
//  Created by Felix Schindler on 12.05.23.
//

import UIKit

class MovieViewController: UIViewController {
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var yearLabel: UILabel!
	@IBOutlet weak var imdbLabel: UILabel!

	@IBOutlet weak var poster: UIImageView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if let title = self.title {
			// TODO: Load movie using the title
			if let movie = MovieModel.singleFromDb(title) {
				print("[DEBUG] Found single movie")
				titleLabel.text = movie.title
				yearLabel.text = movie.year
				imdbLabel.text = movie.imdbID
				
				if let posterUrl = movie.poster {
					poster.downloadImage(from: posterUrl)
				}
			} else {
				print("[ERROR] Didn't find movie")
			}
		}
		
		// Do any additional setup after loading the view.
	}
}

extension UIImageView {
	func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
		URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
	}
	func downloadImage(from url: URL) {
		getData(from: url) {
			data, response, error in
			guard let data = data, error == nil else {
				return
			}
			DispatchQueue.main.async() {
				self.image = UIImage(data: data)
			}
		}
	}
}
