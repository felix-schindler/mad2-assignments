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
	public func add(shop: String, item: String) {
		if (lists[shop] == nil) {
			print("[ERROR] There is no shop with name '\(shop)'")
			return
		}

		lists[shop]!.append(item)
		print("[DEBUG] Added '\(item)' to list '\(shop)'")
		self.persist()
	}

	/// Create a new shopping list
	public func addShop(_ name: String) {
		lists[name] = []
		print("[DEBUG] List '\(name)' created - \(lists)")
		self.persist()
	}
	
	/// Load list from `UserDefaults`
	public func load() {
		if let _lists = UserDefaults.standard.dictionary(forKey: "shopping_lists") as? Dictionary<String, [String]> {
			// Set the shopping list
			lists = _lists
			print("[DEBUG] Loaded - \(lists)")
		} else {
			print("[ERROR] Failed to load")
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
