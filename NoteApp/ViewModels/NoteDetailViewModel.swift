//
//  NoteDetailViewModel.swift
//  NoteApp
//
//  Created by Supakrit Nithikethkul on 22/3/2567 BE.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class NoteDetailsViewModel: ObservableObject {
    var itemId: String
    @Published var item: Note? = nil
    
    init(itemId: String) {
        self.itemId = itemId
        fetch_item()
    }
    
    func toggleIsDone(item: Note) {
        var itemCopy = item
        itemCopy.setDone(!item.isDone)
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("notes")
            .document(itemCopy.id)
            .setData(itemCopy.asDictionary())
    }
    
    func fetch_item() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("notes")
            .document(itemId)
            .getDocument { [weak self]snapshot, error in
                guard let data = snapshot?.data(), error == nil else {
                    return
                }
                DispatchQueue.main.async {
                    self?.item = Note(
                        id: data["id"] as? String ?? "",
                        title: data["title"] as? String ?? "",
                        dueDate: data["dueDate"] as? TimeInterval ?? 0,
                        createDate: data["createDate"] as? TimeInterval ?? 0,
                        isDone: data["isDone"] as? Bool ?? false,
                        content: data["content"] as? String ?? ""
                    )
                }
                
            }
    }
}
