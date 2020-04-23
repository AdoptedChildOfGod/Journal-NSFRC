//
//  EntryController.swift
//  Journal+NSFRC
//
//  Created by Karl Pfister on 4/22/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import Foundation
import CoreData

class EntryController {
    
    static let sharedInstance = EntryController()
    
    // MARK: - Source of Truth
    
    var fetchResultsController: NSFetchedResultsController<Entry>
    
    init() {
        let request: NSFetchRequest<Entry> = Entry.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: true)]
        
        let resultsController: NSFetchedResultsController<Entry> = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchResultsController = resultsController
        
        do {
            try fetchResultsController.performFetch()
        } catch {
            print("There was an error performing the fetch \(error.localizedDescription)")
        }
    }
    
    
    // MARK: - CRUD Methods
    
    func createEntry(withTitle: String, withBody: String) {
        // Could remove the wildcard if we added @discardableResult to the Model
        let _ = Entry(title: withTitle, body: withBody)

        saveToPersistentStore()
    }

    func updateEntry(entry: Entry, newTitle: String, newBody: String) {
        entry.title = newTitle
        entry.body = newBody

        saveToPersistentStore()
    }

    func deleteEntry(entry: Entry) {
        entry.managedObjectContext?.delete(entry)
        saveToPersistentStore()
    }
    
    
    // MARK: - Persistence

    func saveToPersistentStore() {
        do {
             try CoreDataStack.context.save()
        } catch {
            print("Error saving Managed Object. Items not saved!! \(#function) : \(error.localizedDescription)")
        }
    }
}
