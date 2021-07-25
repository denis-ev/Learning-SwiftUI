//
//  AddItemView.swift
//  Learning
//
//  Created by Denis Evers on 25.07.21.
//

import SwiftUI

struct AddItemView: View {

    @Environment(\.presentationMode) var presentationMode

    @StateObject private var vm = AddItemViewModel()

    // Real validation check is not yet implemented
    private var validationCheck: Bool = true

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Section(header: Text("Item").underline()) {
                        VStack {
                            Text("Name:")
                            TextField("Name", text: $vm.item.name)
                        }
                            .padding(.vertical)
                    }
                }
                .padding()
                .font(.headline)
            }
            .navigationTitle("Edit Item")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.headline)
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        vm.test()
                        vm.addItem()
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "checkmark")
                            Text("Save")
                        }
                        .opacity(validationCheck ? 1.0 : 0.0)
                    }
                }
            }
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}

class AddItem: ObservableObject, Identifiable {
    var id: UUID = UUID()

    @Published var name: String
    @Published var timestamp: Date

    init(name: String, timestamp: Date) {
        self.name = name
        self.timestamp = timestamp
    }
}
