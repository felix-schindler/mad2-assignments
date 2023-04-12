//
//  ContentView.swift
//  assignment
//
//  Created by Felix Schindler on 12.04.23.
//

import SwiftUI

struct ContentView: View {
	var body: some View {
		NavigationView {
			List {
				Section {
					HStack {
						Image(systemName: "globe")
							.imageScale(.large)
							.foregroundColor(.accentColor)
						Text("Hello, world!")
					}
				}

				Section("Links") {
					NavigationLink("Shopping list", destination: ShoppingList())
					NavigationLink("Number guess", destination: NumberGuess())
				}
			}.navigationTitle("2nd Assigment")
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
