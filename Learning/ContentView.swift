//
//  ContentView.swift
//  Learning
//
//  Created by Denis Evers on 25.07.21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject private var vm: ContentViewModel

    @State private var showAddItemView: Bool = false

    var body: some View {
        ZStack {
            // background layer
            Color.white
                .ignoresSafeArea()
                .sheet(isPresented: $showAddItemView) {

                } content: {
                    AddItemView()
                }

            // content layer
            VStack {
                List {
                    ForEach(vm.allItems, id: \.id) { item in
                        ItemRowView(item: item)
                    }
                    //            .onDelete(perform: deleteItems)
                }
                Spacer(minLength: 0)
                Button(action: {
                    showAddItemView.toggle()
                }, label: {
                    Text("Add Item")
                })
                    .padding()
                Button(action: {
                    vm.reloadData()
                }, label: {
                    Text("Reload")
                })
                    .padding()
            }
        }
//        .toolbar {
//            #if os(iOS)
//            EditButton()
//            #endif
//
//            Button(action: addItem) {
//                Label("Add Item", systemImage: "plus")
//            }
//        }
    }

//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
        .environmentObject(ContentViewModel())
//            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
