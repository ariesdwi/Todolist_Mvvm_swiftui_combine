//
//  ListNoteParameter.swift
//  TodoListApps
//
//  Created by Aries Prasetyo on 06/01/25.
//


import Foundation

internal struct ListNoteParameter {
    let id: String
    let title: String
    let description: String
    let todoCount: Int32
    let priority: NoteModel.Priority
}

extension ListNoteParameter {
    func toRequest() -> ListNoteRequestDTO {
        return .init(
            id: self.id,
            title: self.title,
            description: self.description,
            todoCount: self.todoCount,
            priority: self.priority.rawValue
        )
    }
}

