//
//  Person.swift
//  1st_assignment
//
//  Created by Felix Schindler on 22.03.23.
//

import Foundation

protocol FriendlyPerson {
	func sayHello() -> String
}

class Person: FriendlyPerson {
	public private(set) var firstname: String
	public private(set) var lastname: String
	
	public var fullname: String {
		get {
			return "\(firstname) \(lastname)"
		}
		
		set(newValue) {
			let split = newValue.split(separator: " ")
			firstname = String(split.first!)
			lastname = String(split.last!)
		}
	}
	
	public init(firstname: String, lastname: String) {
		self.firstname = firstname
		self.lastname = lastname
	}
	
	func sayHello() -> String {
		 "\(self.fullname) says 'Hello'"
	}
}


let person = Person(firstname: "Otto", lastname: "Hahn")

print("Firstname: \(person.firstname) Lastname: \(person.lastname)")
print("Fullname: \(person.fullname)")

person.fullname = "Hans Meiser"

print("Firstname: \(person.firstname) Lastname: \(person.lastname)")
print("Fullname: \(person.fullname)")
