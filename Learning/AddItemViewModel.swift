//
//  AddItemViewModel.swift
//  Learning
//
//  Created by Denis Evers on 25.07.21.
//

import SwiftUI

final class AddItemViewModel: ObservableObject {

    @Published var item: AddItem = AddItem(name: "", timestamp: Date())

    private let itemDataService = ItemDataService()

    init() {}

    // MARK: PUBLIC

    func test() {
        print(item)
    }

    func addItem() {
        itemDataService.addItem(item: item)
    }

    // MARK: PRIVATE

}
