//
//  MovieViewController.swift
//  OMDBApp
//
//  Created by Felix Schindler on 12.05.23.
//

import UIKit

class MovieViewController: UIViewController {
	
	var movie: Movie? = nil
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var yearLabel: UILabel!
	@IBOutlet weak var imdbLabel: UILabel!

	override func viewDidLoad() {
		super.viewDidLoad()

		self.title = movie?.Title ?? "Movie"
		titleLabel.text = movie?.Title
		titleLabel.text = movie?.Year
		titleLabel.text = movie?.ImdbID

		// Do any additional setup after loading the view.
	}
}
