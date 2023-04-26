//
//  ViewController.swift
//  assignment
//
//  Created by Felix Schindler on 26.04.23.
//

import UIKit

class ViewController: UIViewController {
	@IBOutlet weak var textField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		ShoppingList.shared.load()
	}
	
	
	@IBAction func add(_ sender: Any) {
		if let item = textField.text {
			
			// Hide keyboard
			if (textField.canResignFirstResponder) {
				textField.resignFirstResponder()
			}

			// Add item and persist
			ShoppingList.shared.add(item)
			
			// Reset text field value
			textField.text = ""
			
			print("[DEBUG] Added \(item) to the list")
		}
	}
}

