//
//  ListNoteResponseDTO.swift
//  TodoListApps
//
//  Created by Aries Prasetyo on 06/01/25.
//

import Foundation

internal struct ListNoteResponseDTO: Codable {
    let id: String?
    let title: String?
    let description: String?
    let todoCount: Int?
    let completed: Bool?
    let priority: String?
}

internal extension ListNoteResponseDTO {
    func toDomain() -> NoteModel {
        return .init(
            id: self.id ?? "-",
            title: self.title ?? "-",
            descriptionnote: self.description ?? "-",
            todoCount: self.todoCount ?? 0,
            completed: self.completed ?? false,
            priority: NoteModel.Priority(rawValue: self.priority ?? "Low") ?? .low
        )
    }
}
