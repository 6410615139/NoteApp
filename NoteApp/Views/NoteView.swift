//
//  NoteView.swift
//  NoteApp
//
//  Created by Supakrit Nithikethkul on 22/3/2567 BE.
//


import SwiftUI
import FirebaseFirestoreSwift

struct NoteView: View {
    
    @StateObject var viewModel: NoteViewModel
    @FirestoreQuery var items: [Note]
    
    init(userId: String) {
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/notes")
        self._viewModel = StateObject(wrappedValue: NoteViewModel(userId: userId))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(items) { item in
                    NoteItemView(item: item)
                        .swipeActions {
                            Button {
                                viewModel.delete(id: item.id)
                            } label: {
                                Image(systemName: "trash.fill")
                            }
                        }
                        .tint(.red)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Note")
            .toolbar {
                Button {
                    viewModel.showingnewItemView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingnewItemView) {
                NewNoteView(newItemPresented: $viewModel.showingnewItemView)
            }
        }
    }
}

#Preview {
    NoteView(userId: "mLogCOM2DrNLPNnD0KdWfICfdlg1")
}
