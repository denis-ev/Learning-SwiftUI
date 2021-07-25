//
//  LearningApp.swift
//  Learning
//
//  Created by Denis Evers on 25.07.21.
//

import SwiftUI

@main
struct LearningApp: App {
    @StateObject private var vm = ContentViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .environmentObject(vm)
        }
    }
}
