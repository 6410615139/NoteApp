//
//  NoteItemViewModel.swift
//  NoteApp
//
//  Created by Supakrit Nithikethkul on 22/3/2567 BE.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class NoteItemViewModel: ObservableObject {
    
    func toggleIsDone(item: Note) {
        var itemCopy = item
        itemCopy.setDone(!item.isDone)
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("todos")
            .document(itemCopy.id)
            .setData(itemCopy.asDictionary())
    }
    
    func viewDetail(item: Note) {
        var itemCopy = item
        
        
    }
}
