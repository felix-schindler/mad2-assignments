// Variables
var foo = "Hello, playground"		// Can be changed
foo = "Hello, World!"
let bar = "Hello, playground"		// Can NOT be changed - Const / Final / Immutable

// Int
let a = 0
let b: Int

// Double
let c = 0.0
let d: Double

// Float
let e = 0.0
let f: Float

// String
let g = "Hello"
let h = "World"

let abc: [String] = []

// Dictionary
let i = [
	"hello": "Hallo",
	"world": "Welt",
	"!": "!"
]
let j: Dictionary<String, String>		// Empty

// "Array" aus verschiedenen Datentypen
let touple = (a, c, e, g, i, k)

// Optional
var k: String?		// Kann nil sein; nil ist das gleiche wie null in anderen Sprachen
k = "Something"		// Kann auch ein String sein
k = nil						// und wieder nil
k = "STRIIINGG"		// und wieder ein String

print(foo)

if (k != nil) {
	print(k!)
}

if k != nil {
	print("Man braucht übrigens keine Klammern beim IF")
}

if let l = k {
	print("l is better than k. It can't be nil; \(l)")
}

k = nil						// und wieder nil
print(k ?? "k is nil")
