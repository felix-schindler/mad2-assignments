//
//  ContentView.swift
//  assignment
//
//  Created by Felix Schindler on 19.04.23.
//

import SwiftUI

struct ContentView: View {
	var body: some View {
		NavigationView {
			List {
				HStack {
					Image(systemName: "globe")
						.imageScale(.large)
						.foregroundColor(.accentColor)
					Text("Hello, world!")
				}
				
				Section("Views") {
					NavigationLink("Login", destination: LoginView())
					NavigationLink("Image", destination: ImageView())
				}
			}.navigationTitle("3rd assignment")
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
