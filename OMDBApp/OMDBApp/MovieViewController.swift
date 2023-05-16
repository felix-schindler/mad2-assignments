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

		self.title = movie?.title ?? "Movie"
		titleLabel.text = movie?.title
		titleLabel.text = movie?.year
		titleLabel.text = movie?.imdbID

		// Do any additional setup after loading the view.
	}
}
