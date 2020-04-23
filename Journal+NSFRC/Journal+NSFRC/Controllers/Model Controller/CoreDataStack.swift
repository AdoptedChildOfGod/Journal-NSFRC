//
//  CoreDataStack.swift
//  Journal+NSFRC
//
//  Created by Karl Pfister on 4/22/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataStack {

    static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Journal_NSFRC")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error{
                fatalError("Failed to load from Persistent Store \(error) \(error.localizedDescription)")
            }
        })
        return container
    }()

    // direct touchpoint to the context/"sandbox"/larger Source of Truth
    static var context: NSManagedObjectContext { return container.viewContext }
}
