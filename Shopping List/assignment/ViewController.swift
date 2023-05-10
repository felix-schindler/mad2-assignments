//
//  ViewController.swift
//  assignment
//
//  Created by Felix Schindler on 26.04.23.
//

import UIKit

class ViewController: UIViewController {
	
	var shop: String = ""
	
	@IBOutlet weak var textField: UITextField!
	
	init(shop: String) {
		self.shop = shop
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		// fatalError("init(coder:) has not been implemented")
	}
	
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
			
			if (shop.isEmpty) {
				// Create new shop
				ShoppingList.shared.addShop(item)
				print("[DEBUG] New shop created")
			} else {
				// Add item and persist
				ShoppingList.shared.add(shop: shop, item: item)
				print("[DEBUG] New shop created")
			}
			
			// Reset text field value
			textField.text = ""
		}
	}
}
