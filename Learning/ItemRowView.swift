//
//  ItemRowView.swift
//  Learning
//
//  Created by Denis Evers on 25.07.21.
//

import SwiftUI

import SwiftUI

struct ItemRowView: View {

    let item: Item

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(item.name ?? "Unknown")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            Spacer()

            Text("\(item.timestamp! , formatter: itemDateFormatter)")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

private let itemDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()

//struct ItemRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemRowView()
//    }
//}
