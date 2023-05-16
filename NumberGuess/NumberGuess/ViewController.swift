//
//  ViewController.swift
//  NumberGuess
//
//  Created by Felix Schindler on 16.05.23.
//

import UIKit

class ViewController: UIViewController {
	var min = 0
	var max = 1000
	var currentValue = 500 {
		didSet {
			curValLbl.text = String(currentValue)
		}
	}
	
	var tries = 0
	
	@IBOutlet weak var curValLbl: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		curValLbl.text = String(currentValue)
	}
	
	@IBAction func smaller(_ sender: Any) {
		tries += 1
		max = currentValue
		currentValue = min + (max - min) / 2
	}
	
	@IBAction func greater(_ sender: Any) {
		tries += 1
		min = currentValue
		currentValue = min + (max - min) / 2
	}
	
	@IBAction func correct(_ sender: Any) {
		let alert = UIAlertController(title: "Congratulations!", message: "You got it right in \(tries) tries.", preferredStyle: .alert)
		
		let restartAction = UIAlertAction(title: "Restart", style: .default) { [weak self] _ in
			self?.reset()
		}
		alert.addAction(restartAction)
		
		present(alert, animated: true, completion: nil)
	}
	
	func reset() {
		min = 0
		max = 1000
		currentValue = 500
		tries = 0
	}
}
