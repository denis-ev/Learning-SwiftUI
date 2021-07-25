//
//  ContentViewModel.swift
//  Learning
//
//  Created by Denis Evers on 25.07.21.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    @Published var allItems: [Item] = []

    private let itemDataService = ItemDataService()
    private var cancellables = Set<AnyCancellable>()

    enum SortOption {
        case name, nameReversed, updated, updatedReversed
    }

    init() {
        addSubscribers()
    }

    // MARK: Public

    func deleteItem(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = allItems[index]
        itemDataService.deleteItem(item: entity)
    }

    func reloadData() {
        itemDataService.getItems()
    }

    // MARK: Private

    private func addSubscribers() {

        // updates allItems
        itemDataService.$items
            .sink { [weak self] (returnedItems) in
                self?.allItems = returnedItems
            }
            .store(in: &cancellables)
    }
}
