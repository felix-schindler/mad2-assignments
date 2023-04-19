//
//  ImageView.swift
//  assignment
//
//  Created by Felix Schindler on 19.04.23.
//

import SwiftUI

struct ImageView: View {
    var body: some View {
			VStack {
				Text("What is this image showing?")
					.font(.title)
					.fontWeight(.bold)
				Spacer()
				Image("")
					.scaledToFit()
					.background(.secondary)
					.frame(minWidth: 200, maxWidth: .infinity, minHeight: 200, maxHeight: .infinity)
				Spacer()
				HStack {
					Spacer()
					Button("Young lady") { }
					Spacer()
					Button("Old woman") { }
					Spacer()
				}
			}
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
