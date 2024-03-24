//
//  NoteItemView.swift
//  NoteApp
//
//  Created by Supakrit Nithikethkul on 22/3/2567 BE.
//

import SwiftUI

struct NoteItemView: View {
    @StateObject var viewModel = NoteItemViewModel()
    let item: Note
    @State private var isNavigationActive = false  // State to control navigation

    var body: some View {
        HStack {
            // NavigationLink disguised as part of the HStack content
            NavigationLink(destination: NoteDetailsView(itemId: item.id), isActive: $isNavigationActive) {
                EmptyView()
            }
            .frame(width: 0)
            .opacity(0)

            // Tappable area for navigation
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.title)
                    .bold()
                
                Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
            }
            .contentShape(Rectangle())
            .onTapGesture {
                isNavigationActive = true
            }
            .background(NavigationLink("", destination: NoteDetailsView(itemId: item.id)).hidden())

            Spacer()

//            // Toggle isDone button
//            Button(action: {
//                viewModel.toggleIsDone(item: item)
//            }) {
//                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
//                    .foregroundColor(.blue)
//            }
        }
    }
}
