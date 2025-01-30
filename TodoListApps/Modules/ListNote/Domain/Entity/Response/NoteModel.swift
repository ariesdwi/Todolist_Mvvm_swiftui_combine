//
//  ListNoteModel.swift
//  TodoListApps
//
//  Created by Aries Prasetyo on 06/01/25.
//

import Foundation

internal struct NoteModel: Identifiable, Equatable {
    enum Priority: String, CaseIterable, Identifiable {
        case low = "Low"
        case medium = "Medium"
        case high = "High"
        case all = "All"
        
        var id: String { self.rawValue }
    }

    let id: String
    var title: String?
    var descriptionnote: String?
    var todoCount: Int
    var completed: Bool
    var priority: Priority
}

