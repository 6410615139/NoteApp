//
//  Note.swift
//  NoteApp
//
//  Created by Supakrit Nithikethkul on 22/3/2567 BE.
//

import Foundation

struct Note: Codable, Identifiable {
    let id: String
    var title: String
    var dueDate: TimeInterval
    let createDate: TimeInterval
    var isDone: Bool
    var content: String
    
    mutating func setDone(_ state: Bool) {
        isDone = state
    }
    
    mutating func editNote(title: String, dueDate: TimeInterval, content: String) {
        self.title = title
        self.dueDate = dueDate
        self.content = content
    }
}
