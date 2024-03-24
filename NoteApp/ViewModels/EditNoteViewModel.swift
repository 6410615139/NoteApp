//
//  EditNoteViewModel.swift
//  NoteApp
//
//  Created by Supakrit Nithikethkul on 24/3/2567 BE.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class EditNoteViewModel: ObservableObject {
    @Published var title: String
    @Published var content: String
    @Published var dueDate = Date()
    @Published var showAlert = false
    
    @Published var note: Note
    
    init(note: Note) {
        self.note = note
        self.title = note.title
        self.content = note.content
        self.dueDate = Date(timeIntervalSince1970: note.dueDate)
    }
    
    func save() {
        guard canSave else { return }
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        note.editNote(title: title, dueDate: dueDate.timeIntervalSince1970, content: content)
        
        let db = Firestore.firestore()
        db.collection("users")
          .document(uId)
          .collection("notes")
          .document(note.id)
          .setData(note.asDictionary(), merge: true)
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
