//
//  LearningApp.swift
//  Learning
//
//  Created by Denis Evers on 25.07.21.
//

import SwiftUI

@main
struct LearningApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
