//
//  NoteDetailView.swift
//  NoteApp
//
//  Created by Supakrit Nithikethkul on 22/3/2567 BE.
//
import SwiftUI
import FirebaseFirestoreSwift

struct NoteDetailsView: View {
    @StateObject var viewModel: NoteDetailsViewModel
    
    init(itemId: String) {
        _viewModel = StateObject(wrappedValue: NoteDetailsViewModel(itemId: itemId))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                if let item = viewModel.item {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(item.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.bottom, 10)
                        
                        Text(item.content)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 10)
                        
                        Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .padding(.bottom, 10)
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                    .padding()

                    Text("ID: \(item.id)")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.top, 5)
                        .padding(.bottom, 20)
                } else {
                    Text("Loading note details...")
                        .font(.body)
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle("Note Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                viewModel.showingEditView = true
            } label: {
                Image(systemName: "pencil")
            }
        }
        .sheet(isPresented: $viewModel.showingEditView) {
            EditNoteView(note: viewModel.item!, editItemPresented: $viewModel.showingEditView)
        }
        .onChange(of: viewModel.showingEditView) {
            viewModel.fetch_item()
        }
    }
}

// Preview
struct NoteDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NoteDetailsView(itemId: "439421B0-4CC9-4D02-8BFC-E660303F37D7")
    }
}
