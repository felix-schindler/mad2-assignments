//
//  PersistenceManager.swift
//  OMDBApp
//
//  Created by Felix Schindler on 16.05.23.
//

import Foundation
import CoreData

class PersistenceManager {
	static let shared = PersistenceManager()
	
	lazy var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "OMDBApp")
		container.loadPersistentStores { (_, error) in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		}
		return container
	}()
	
	var context: NSManagedObjectContext {
		return persistentContainer.viewContext
	}
	
	private init() {}
	
	func saveContext() {
		guard context.hasChanges else { return }
		
		do {
			try context.save()
		} catch {
			let nsError = error as NSError
			fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
		}
	}
}
