//
//  Note.swift
//  NoteApp
//
//  Created by Supakrit Nithikethkul on 22/3/2567 BE.
//

import Foundation

struct Note: Codable, Identifiable {
    let id: String
    let title: String
    let dueDate: TimeInterval
    let createDate: TimeInterval
    var isDone: Bool
    let content: String
    
    mutating func setDone(_ state: Bool) {
        isDone = state
    }
}
