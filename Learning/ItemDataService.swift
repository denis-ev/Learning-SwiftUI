//
//  Persistence.swift
//  Learning
//
//  Created by Denis Evers on 25.07.21.
//

import CoreData

//struct PersistenceController {
//    static let shared = PersistenceController()
//
//    static var preview: PersistenceController = {
//        let result = PersistenceController(inMemory: true)
//        let viewContext = result.container.viewContext
//        for _ in 0..<10 {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//        }
//        do {
//            try viewContext.save()
//        } catch {
//            // Replace this implementation with code to handle the error appropriately.
//            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//        return result
//    }()
//
//    let container: NSPersistentContainer
//
//    init(inMemory: Bool = false) {
//        container = NSPersistentContainer(name: "Learning")
//        if inMemory {
//            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
//        }
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//
//                /*
//                Typical reasons for an error here include:
//                * The parent directory does not exist, cannot be created, or disallows writing.
//                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
//                * The device is out of space.
//                * The store could not be migrated to the current model version.
//                Check the error message to determine what the actual problem was.
//                */
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//    }
//}

import CoreData
import SwiftUI

class ItemDataService: ObservableObject {

    private let container: NSPersistentContainer
    private let containerName: String = "Learning"
    private let entityName: String = "Item"

    @Published var items: [Item] = []

    static let shared = ItemDataService()

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: containerName)
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
        })
        self.getItems()
    }

    static var preview: ItemDataService = {
        let result = ItemDataService(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<10 {
            let newItem = Item(context: viewContext)
            newItem.id = UUID()
            newItem.name = "Name \(i)"
            newItem.timestamp = Date()
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    // MARK: PUBLIC


    func addItem(item: AddItem) {
        add(item: item)
    }

    func deleteItem(item: Item) {
        delete(entity: item)
    }

    func deleteAll() {
#if DEBUG
        print(items)
#endif
        for item in items {
            delete(entity: item)
        }
#if DEBUG
        print(items)
#endif
    }

    // MARK: PRIVATE

    func getItems() {
        let requestItem = NSFetchRequest<Item>(entityName: entityName)
        do {
            items = try container.viewContext.fetch(requestItem)
        } catch let error {
            print("Error fetching Items. \(error)")
        }
#if DEBUG
        print("Items fetched! \(items)")
#endif
    }

    private func add(item: AddItem) {

        let newItem = Item(context: container.viewContext)
        newItem.id = item.id
        newItem.name = item.name
        newItem.timestamp = Date()

        applyChanges()

    }

    private func update(item: Item) {
        // Not implemented yet
    }

    private func delete(entity: Any) {
        if let entity = entity as? NSManagedObject {
            container.viewContext.delete(entity)
        } else { return }
        applyChanges()
    }

    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to Core Data. \(error)")
        }
    }

    private func applyChanges() {
        save()
        getItems()
    }

}

