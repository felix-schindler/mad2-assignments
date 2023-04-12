//
//  ShoppingList.swift
//  assignment
//
//  Created by Felix Schindler on 12.04.23.
//

import SwiftUI

struct ShoppingList: View {
	@State var item = ""
	@State var list: [String] = []
	
	var body: some View {
		List {
			Section {
				TextField("Enter item", text: $item)
				Button("Add to list") {
					if (item != "") {
						addItem(item)
					}
				}
			}
			
			if (!list.isEmpty) {
				Section("List items") {
					ForEach(list, id: \.self) { item in
						Text(item)
					}.swipeActions {
						Button(role: .destructive, action: {
							let i = list.firstIndex(of: item)
							if (i != nil) {
								list.remove(at: i!)
								persist()
							}
						}, label: {
							Label("Delete", systemImage: "trash")
								.labelStyle(.iconOnly)
						})
					}
				}
			}
		}.navigationTitle("Shopping list")
			.onAppear() {
				loadPersited()
			}
			.refreshable {
				loadPersited()
			}
	}
	
	/// Adds item to the array and persists it
	func addItem(_ newItem: String) {
		list.append(newItem)
		self.item = ""
		
		persist()
	}
	
	/// Persists the shopping list
	func persist() {
		// Save the data to UserDefaults
		UserDefaults.standard.set(list, forKey: "shopping_list")
		print(list)
		print("Persisted")
	}
	
	/// Loads the persited data into the array
	func loadPersited() {
		// Retrieve the data from UserDefaults
		if let _list = UserDefaults.standard.stringArray(forKey: "shopping_list") {
			// Set the shopping list
			list = _list
			print("List loaded")
			print(list)
		}
	}
	
	func clearList() {
		list = []
		UserDefaults.standard.removeObject(forKey: "shopping_list")
	}
}

struct ShoppingList_Previews: PreviewProvider {
	static var previews: some View {
		ShoppingList()
	}
}
