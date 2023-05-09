//
//  LoginView.swift
//  assignment
//
//  Created by Felix Schindler on 19.04.23.
//

import SwiftUI

struct LoginView: View {
	@State var user: String = ""
	@State var pass: String = ""

	var body: some View {
		Form {
			// Text("Username")
			TextField("Username", text: $user)
			// Text("Password")
			SecureField("Password", text: $pass)
			Button("Login") { }
		}.navigationTitle("Login")
	}
}

struct LoginView_Previews: PreviewProvider {
	static var previews: some View {
		LoginView()
	}
}
