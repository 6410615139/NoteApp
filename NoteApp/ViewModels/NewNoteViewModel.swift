//
//  NewNoteViewModel.swift
//  NoteApp
//
//  Created by Supakrit Nithikethkul on 22/3/2567 BE.
//


import Foundation
import FirebaseAuth
import FirebaseFirestore

class NewNoteViewModel: ObservableObject {
    @Published var title = ""
    @Published var content = ""
    @Published var dueDate = Date()
    @Published var showAlert = false
    
    func save() {
        guard canSave else { return }
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let newId = UUID().uuidString
        let newItem = Note(id: newId
                                   , title: title
                                   , dueDate: dueDate.timeIntervalSince1970
                                   , createDate: Date().timeIntervalSince1970
                                   , isDone: false
                                   , content: content)
        let db = Firestore.firestore()
        db.collection("users")
            .document(uId)
            .collection("notes")
            .document(newId)
            .setData(newItem.asDictionary())
    }
    
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        guard dueDate >= Date().addingTimeInterval(-86400) else {
            return false
        }
        return true
    }
}
