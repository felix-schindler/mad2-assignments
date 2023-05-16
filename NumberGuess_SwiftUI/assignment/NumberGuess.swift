//
//  NumberGuess.swift
//  assignment
//
//  Created by Felix Schindler on 12.04.23.
//

import SwiftUI

struct NumberGuess: View {
	@State var min = 0
	@State var max = 1000
	@State var currentValue = 500
	
	@State var tries = 0
	@State var showAlert = false
	
	var body: some View {
		VStack {
			Text("Please think about a number between 0 and 1000")
				.font(.headline)
				.padding(.bottom)
			Text("Is the number")
			Text(String(currentValue))
				.font(.largeTitle)
				.padding(2)
			Text("greater or smaller than your number or is it correct?")
			HStack {
				Button("Smaller") {
					tries += 1
					max = currentValue
					currentValue = min + (max - min) / 2
				}
				Spacer()
				Button("Correct") {
					showAlert = true
				}.alert(
					"Congratulations",
					isPresented: $showAlert,
					actions: {
						Button("Restart", action: {
							min = 0
							max = 1000
							currentValue = 500
							tries = 0
							showAlert = false
						})
					}, message: {
						Text("It took \(tries) try(ies) to guess the number")
					})
				Spacer()
				Button("Greater") {
					tries += 1
					min = currentValue
					currentValue = min + (max - min) / 2
				}
			}.padding()
			Button("Reset", role: .destructive) {
				min = 0
				max = 1000
				currentValue = 500
				tries = 0
				showAlert = false
			}
		}.padding()
	}
}

struct NumberGuess_Previews: PreviewProvider {
	static var previews: some View {
		NumberGuess()
	}
}
