//
//  EditNoteView.swift
//  NoteApp
//
//  Created by Supakrit Nithikethkul on 24/3/2567 BE.
//

import SwiftUI

struct EditNoteView: View {
    
    @StateObject var viewModel: EditNoteViewModel
    @Binding var editItemPresented: Bool
    
    init(note: Note, editItemPresented: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: EditNoteViewModel(note: note))
        _editItemPresented = editItemPresented
    }
    
    var body: some View {
        VStack {
            Text("Edit Item")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 50)
            
            Form {
                TextField("Title", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                TextField("Content", text: $viewModel.content)
                    .textFieldStyle(DefaultTextFieldStyle())
                DatePicker("Due Date", selection: $viewModel.dueDate)
                    .datePickerStyle(GraphicalDatePickerStyle())
                myButton(title: "Save", background: .pink) {
                    if viewModel.canSave {
                        viewModel.save()
                        editItemPresented = false
                    } else {
                        viewModel.showAlert = true
                    }
                }
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text("Please fill in all fields and select due date that is today or newer")
                )
            }
        }
    }
}

#Preview {
    NewNoteView(newItemPresented: .constant(true))
}

