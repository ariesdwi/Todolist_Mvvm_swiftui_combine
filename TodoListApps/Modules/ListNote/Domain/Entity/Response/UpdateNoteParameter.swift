//
//  UpdateNoteParameter.swift
//  TodoListApps
//
//  Created by Aries Prasetyo on 06/01/25.
//

import Foundation

internal struct UpdateNoteParameter {
    let id: String
    let title: String
    let completed: Bool
    let description: String
    let priority: NoteModel.Priority
}

extension UpdateNoteParameter {
    func toRequest() -> UpdateNoteRequestDTO {
        return .init(
            id: self.id,
            title: self.title,
            completed: self.completed,
            description: self.description,
            priority: self.priority.rawValue
        )
    }
}
