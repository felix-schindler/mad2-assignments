//
//  ShoppingList.swift
//  assignment
//
//  Created by Felix Schindler on 26.04.23.
//

import Foundation

class ShoppingList {
	public static let shared = ShoppingList()
	public private(set) var lists: Dictionary<String, [String]> = [:]
	
	private init() {
	}
	
	/// Append item to  `list` and persist
	public func add(shop: String, item: String) -> Void {
		addShop(shop)
		lists[shop]!.append(item)
		print("[DEBUG] Added '\(item)' to list '\(shop)'")
		persist()
	}
	
	public func add(shop: String, items: [String]) -> Void {
		addShop(shop)
		lists[shop]!.append(contentsOf: items)
		print("[DEBUG] Added '\(items)' to list '\(shop)'")
		persist()
	}

	/// Create a new shopping list
	public func addShop(_ name: String) -> Void {
		if (lists[name] != nil) {
			return
		}
		
		lists[name] = []
		print("[DEBUG] List '\(name)' created - \(lists)")
		persist()
	}
	
	/// Load list from `UserDefaults`
	public func load() {
		// Try load the new shopping list
		if let _lists = UserDefaults.standard.dictionary(forKey: "shopping_lists") as? Dictionary<String, [String]> {
			// Set the shopping list
			lists = _lists
			print("[DEBUG] Loaded - \(lists)")
		} else {
			print("[ERROR] Failed to load")
		}

		// If old list still exists, add it to the new system
		if let _oldList = UserDefaults.standard.stringArray(forKey: "shopping_list") {
			add(shop: "old", items: _oldList)
			
			// Remove old shopping list (without store names)
			UserDefaults.standard.removeObject(forKey: "shopping_list")
		}
	}

	/// Persist the list using `UserDefaults`
	private func persist() {
		// Persist data using UserDefaults
		UserDefaults.standard.set(lists, forKey: "shopping_lists")
		print("[DEBUG] Persisted - \(lists)")
	}

	/// Clear list
	private func reset() {
		lists = [:]
		self.persist()
	}
}
