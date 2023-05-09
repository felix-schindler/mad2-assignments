//
//  ViewController.swift
//  1st_assignment
//
//  Created by Felix Schindler on 22.03.23.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var button: UIButton!
	@IBOutlet weak var label: UILabel!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	@IBAction func onButtonPressed(_ sender: Any) {
		label.text = "SwiftUI is just better."
	}
}
