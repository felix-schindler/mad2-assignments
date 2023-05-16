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
person.sayHello()
print("Firstname: \(person.firstname) Lastname: \(person.lastname) Fullname: \(person.fullname)")

person.fullname = "Hans Meiser"
print("Firstname: \(person.firstname) Lastname: \(person.lastname) Fullname: \(person.fullname)")
